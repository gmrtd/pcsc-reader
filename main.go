package main

import (
	"bytes"
	"encoding/base64"
	"flag"
	"fmt"
	"html/template"
	"log"
	"log/slog"
	"os"

	"github.com/dumacp/smartcard/pcsc"
	"github.com/gmrtd/gmrtd"
	"github.com/pkg/browser"
)

type PCSCTransceiver struct {
	card pcsc.Card
}

func (transceiver *PCSCTransceiver) Transceive(cApdu []byte) (rApduBytes []byte) {
	rApduBytes, err := transceiver.card.Apdu(cApdu)
	if err != nil {
		slog.Error("Transceive", "error", err)
		return
	}

	slog.Debug("Transceive", "cApdu", gmrtd.BytesToHex(cApdu), "rApdu", gmrtd.BytesToHex(rApduBytes))

	return
}

var temp *template.Template

func outputDocument(document *gmrtd.Document) {
	var err error

	if document == nil {
		return
	}
	// TODO - update to include DG2/7 images.. maybe easier if we switch to a html output
	// e.g.
	//	gmrtd.WriteFile("DG2_image", document.Dg2.BITs[0].BDB.Facial.Images[0].Data)
	//	gmrtd.WriteFile("DG7_image", document.Dg7.Images[0].Image)

	funcMap := template.FuncMap{
		"BytesToHex":       func(bytes []byte) string { return fmt.Sprintf("%X", bytes) },
		"TlvBytesToString": func(bytes []byte) string { return gmrtd.TlvDecode(bytes).String() },
		"BytesToBase64":    func(bytes []byte) string { return base64.StdEncoding.EncodeToString(bytes) },
	}

	temp = template.Must(template.New("template.tpl").Funcs(funcMap).ParseFiles("template.tpl"))

	byteBuf := bytes.NewBuffer(nil)

	// convert to HTML using template
	err = temp.Execute(byteBuf, document)
	if err != nil {
		log.Fatalln(err)
	}

	// display in default browser
	err = browser.OpenReader(byteBuf)
	if err != nil {
		log.Fatalln(err)
	}
}

func getParams() (password *gmrtd.Password, debug bool, err error) {
	documentNo := flag.String("doc", "", "Document Number")
	dateOfBirth := flag.String("dob", "", "Date of Birth (YYMMDD)")
	expiryDate := flag.String("exp", "", "Expiry Date (YYMMDD)")
	can := flag.String("can", "", "Card Access Number")
	debugFlag := flag.Bool("debug", false, "Debug")

	flag.Parse()

	if len(*documentNo) > 0 && len(*dateOfBirth) == 6 && len(*expiryDate) == 6 {
		password = gmrtd.NewPasswordMrzi(*documentNo, *dateOfBirth, *expiryDate)

	} else if len(*can) > 0 {
		password = gmrtd.NewPasswordCan(*can)
	} else {
		return nil, false, fmt.Errorf("usage: must speciffy either doc+dob+exp *OR* can")
	}

	log.Printf("Doc:%s, DOB:%s, Exp:%s, CAN:%s, Debug:%t", *documentNo, *dateOfBirth, *expiryDate, *can, *debugFlag)

	log.Printf("Password: %+v", password)

	return password, *debugFlag, nil
}

func initLogging(debug bool) {
	logLevel := &slog.LevelVar{}
	opts := &slog.HandlerOptions{
		Level: logLevel,
	}
	logger := slog.New(slog.NewJSONHandler(os.Stdout, opts))
	slog.SetDefault(logger)
	if debug {
		logLevel.Set(slog.LevelDebug.Level()) // enable debug
	}
}

func main() {

	var password *gmrtd.Password
	var debug bool = false
	var err error

	password, debug, err = getParams()
	if err != nil {
		slog.Error("%s", err)
		os.Exit(1)
	}

	initLogging(debug)

	ctx, err := pcsc.NewContext()
	if err != nil {
		slog.Error("Unable to initialise PCSC")
		os.Exit(1)
	}
	defer ctx.Release()

	readers, err := pcsc.ListReaders(ctx)
	if err != nil {
		slog.Error("Unable to get PCSC readers")
		os.Exit(1)
	}
	slog.Debug("PCSC", "readers", readers)

	if len(readers) < 1 {
		slog.Error("No PCSC reader found")
		os.Exit(1)
	}

	// NB we currently just select the 1st reader (if multiple)
	reader := pcsc.NewReader(ctx, readers[0])

	card, err := reader.ConnectCardPCSC()
	if err != nil {
		slog.Error("No chip detected")
		os.Exit(1)
	}

	var transceiver *PCSCTransceiver = new(PCSCTransceiver)

	transceiver.card = card

	document, err := gmrtd.ReadDocument(transceiver, password)
	if err != nil {
		// output whatever we have from the document
		outputDocument(document)
		slog.Error("ReadDocument", "error", err)
		os.Exit(1)
	}

	// TODO - passive auth doesn't currently do anything
	gmrtd.MrtdPassiveAuth(document)

	outputDocument(document)
}
