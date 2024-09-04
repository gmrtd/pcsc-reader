<html>
<head>
<style>
h1 {
    background-color:SkyBlue
}
h2 {
    background-color:Silver
}
</style>
<title>GMRTD</title>
</head>
<body>

{{define "fileHexAndTlv"}}
<div><pre>
{{. | BytesToHex}}
</pre></div>

<div><pre>
{{. | TlvBytesToString}}
</pre></div>
{{end}}

<h1>GMRTD</h1>

<div><pre>
LDS version: <b>{{.LdsVersion}}</b>
Unicode version: <b>{{.UnicodeVersion}}</b>
</pre></div>

<pre><div>
ChipAuthStatus: <b>{{.ChipAuthStatus}}</b>
</pre></div>

<div><pre>
ATR: {{.Atr | BytesToHex}}
ATS: {{.Ats | BytesToHex}}
</pre></div>

<h2>Passive Authentication (SOD)</h2>
{{if .PassiveAuthSOD}}
    {{ range .PassiveAuthSOD.CertChain }}
        {{template "fileHexAndTlv" .}}
    {{ end }}
{{else}}
<i>No data</i>
{{end}}

<h2>Passive Authentication (CardSecurity)</h2>
{{if .PassiveAuthCardSec}}
    {{ range .PassiveAuthCardSec.CertChain }}
        {{template "fileHexAndTlv" .}}
    {{ end }}
{{else}}
<i>No data</i>
{{end}}

<h2>CardAccess</h2>
{{if .Mf.CardAccess}}
{{template "fileHexAndTlv" .Mf.CardAccess.RawData}}
{{else}}
<i>No data</i>
{{end}}

<h2>CardSecurity</h2>
{{if .Mf.CardSecurity}}
{{template "fileHexAndTlv" .Mf.CardSecurity.RawData}}
{{else}}
<i>No data</i>
{{end}}

<h2>DIR</h2>
{{if .Mf.Dir}}
{{template "fileHexAndTlv" .Mf.Dir.RawData}}
{{else}}
<i>No data</i>
{{end}}

<h2>COM</h2>
{{if .Mf.Lds1.Com}}
{{template "fileHexAndTlv" .Mf.Lds1.Com.RawData}}
{{else}}
<i>No data</i>
{{end}}

<h2>SOD <sub>Document Security Object</sub></h2>
{{if .Mf.Lds1.Sod}}
{{template "fileHexAndTlv" .Mf.Lds1.Sod.RawData}}
{{else}}
<i>No data</i>
{{end}}

<h2>DG1 <sub>Machine Readable Zone Information</sub></h2>
{{if .Mf.Lds1.Dg1}}
{{template "fileHexAndTlv" .Mf.Lds1.Dg1.RawData}}

<div><pre>
DocumentCode  : {{.Mf.Lds1.Dg1.Mrz.DocumentCode}}
IssuingState  : {{.Mf.Lds1.Dg1.Mrz.IssuingState}}
NameOfHolder  : [Primary] {{.Mf.Lds1.Dg1.Mrz.NameOfHolder.Primary}} [Secondary] {{.Mf.Lds1.Dg1.Mrz.NameOfHolder.Secondary}}
DocumentNumber: {{.Mf.Lds1.Dg1.Mrz.DocumentNumber}}
Nationality   : {{.Mf.Lds1.Dg1.Mrz.Nationality}}
DateOfBirth   : {{.Mf.Lds1.Dg1.Mrz.DateOfBirth}}
Sex           : {{.Mf.Lds1.Dg1.Mrz.Sex}}
DateOfExpiry  : {{.Mf.Lds1.Dg1.Mrz.DateOfExpiry}}
OptionalData  : {{.Mf.Lds1.Dg1.Mrz.OptionalData}}
OptionalData2 : {{.Mf.Lds1.Dg1.Mrz.OptionalData2}}
</pre></div>
{{else}}
<i>No data</i>
{{end}}

<h2>DG2 <sub>Encoded Identification Features - Face</sub></h2>
{{if .Mf.Lds1.Dg2}}
{{template "fileHexAndTlv" .Mf.Lds1.Dg2.RawData}}

<!-- TODO - would be good got DG2 to provide an easier way to access the images -->
{{ range .Mf.Lds1.Dg2.BITs }}
    {{ range .BDB.Facial.Images }}
        <img src="data:image/jpeg;base64,{{.Data | BytesToBase64}}" />
        <br/>
        Image size (bytes): {{len .Data}}
    {{ end }}
{{ end }}


{{else}}
<i>No data</i>
{{end}}

<h2>DG7 <sub>Displayed Signature or Usual Mark</sub></h2>
{{if .Mf.Lds1.Dg7}}
{{template "fileHexAndTlv" .Mf.Lds1.Dg7.RawData}}
<!-- TODO - output any image(s) -->
{{else}}
<i>No data</i>
{{end}}

<h2>DG11 <sub>Additional Personal Detail(s)</sub></h2>
{{if .Mf.Lds1.Dg11}}
{{template "fileHexAndTlv" .Mf.Lds1.Dg11.RawData}}

<div><pre>
NameOfHolder        : {{.Mf.Lds1.Dg11.Details.NameOfHolder}}
OtherNames          : {{.Mf.Lds1.Dg11.Details.OtherNames}}
PersonalNumber      : {{.Mf.Lds1.Dg11.Details.PersonalNumber}}
FullDateOfBirth     : {{.Mf.Lds1.Dg11.Details.FullDateOfBirth}}
PlaceOfBirth        : {{.Mf.Lds1.Dg11.Details.PlaceOfBirth}}
Address             : {{.Mf.Lds1.Dg11.Details.Address}}
Telephone           : {{.Mf.Lds1.Dg11.Details.Telephone}}
Profession          : {{.Mf.Lds1.Dg11.Details.Profession}}
Title               : {{.Mf.Lds1.Dg11.Details.Title}}
PersonalSummary     : {{.Mf.Lds1.Dg11.Details.PersonalSummary}}
ProofOfCitizenship  : {{.Mf.Lds1.Dg11.Details.ProofOfCitizenship | BytesToHex}}
OtherTravelDocuments: {{.Mf.Lds1.Dg11.Details.OtherTravelDocuments}}
CustodyInformation  : {{.Mf.Lds1.Dg11.Details.CustodyInformation}}
</div></pre>

{{else}}
<i>No data</i>
{{end}}

<h2>DG12 <sub>Additional Document Detail(s)</sub></h2>
{{if .Mf.Lds1.Dg12}}
{{template "fileHexAndTlv" .Mf.Lds1.Dg12.RawData}}

<div><pre>
IssuingAuthority           : {{.Mf.Lds1.Dg12.Details.IssuingAuthority}}
DateOfIssue                : {{.Mf.Lds1.Dg12.Details.DateOfIssue}}
OtherPersons               : {{.Mf.Lds1.Dg12.Details.OtherPersons}}
EndorsementsAndObservations: {{.Mf.Lds1.Dg12.Details.EndorsementsAndObservations}}
TaxExitRequirements        : {{.Mf.Lds1.Dg12.Details.TaxExitRequirements}}
ImageFront                 : {{.Mf.Lds1.Dg12.Details.ImageFront | BytesToHex}}
ImageRear                  : {{.Mf.Lds1.Dg12.Details.ImageRear | BytesToHex}}
PersoDateTime              : {{.Mf.Lds1.Dg12.Details.PersoDateTime}}
PersoSystemSerialNumber    : {{.Mf.Lds1.Dg12.Details.PersoSystemSerialNumber}}
</pre></div>

{{else}}
<i>No data</i>
{{end}}

<h2>DG13 <sub>Optional Detail(s)</sub></h2>
{{if .Mf.Lds1.Dg13}}
{{template "fileHexAndTlv" .Mf.Lds1.Dg13.RawData}}
{{else}}
<i>No data</i>
{{end}}

<h2>DG14 <sub>Security Options</sub></h2>
{{if .Mf.Lds1.Dg14}}
{{template "fileHexAndTlv" .Mf.Lds1.Dg14.RawData}}
{{else}}
<i>No data</i>
{{end}}

<h2>DG15 <sub>Active Authentication Public Key Info</sub></h2>
{{if .Mf.Lds1.Dg15}}
{{template "fileHexAndTlv" .Mf.Lds1.Dg15.RawData}}
{{else}}
<i>No data</i>
{{end}}

<h2>DG16 <sub>Person(s) to Notify</sub></h2>
{{if .Mf.Lds1.Dg16}}
{{template "fileHexAndTlv" .Mf.Lds1.Dg16.RawData}}
{{else}}
<i>No data</i>
{{end}}

<h1>APDU LOG</h1>

<h2>Count: {{len .Apdus}}</h2>
<h2>Duration(ms): {{.Apdus | ApduTotalDurMs}}</h2>

{{ range .Apdus }}
<div><pre>
Desc: <b>{{ .Desc }}</b>
Dur(ms): <b>{{ .DurMs }}</b>
</pre></div>
<div><pre>
-> {{ .Tx | BytesToHex }}
    {{if .Child}}
--> {{ .Child.Tx | BytesToHex }}
<-- {{ .Child.Rx | BytesToHex }}
    {{end}}
<- {{ .Rx | BytesToHex }}
</pre></div>
<hr>
{{ end }}

</body>
</html>
