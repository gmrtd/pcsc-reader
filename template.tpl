** MRTD DOCUMENT OUTPUT **

CardAccess:
{{if .CardAccess}}
{{.CardAccess.RawData | BytesToHex}}

{{.CardAccess.RawData | TlvBytesToString}}
{{end}}

CardSecurity:
{{if .CardSecurity}}
{{.CardSecurity.RawData | BytesToHex}}

{{.CardSecurity.RawData | TlvBytesToString}}
{{end}}

DIR:
{{if .Dir}}
{{.Dir.RawData | BytesToHex}}

{{.Dir.RawData | TlvBytesToString}}
{{end}}

COM:
{{if .Com}}
{{.Com.RawData | BytesToHex}}

{{.Com.RawData | TlvBytesToString}}
{{end}}

SOD:
{{if .Sod}}
{{.Sod.RawData | BytesToHex}}

{{.Sod.RawData | TlvBytesToString}}
{{end}}

DG1:
{{if .Dg1}}
{{.Dg1.RawData | BytesToHex}}

{{.Dg1.RawData | TlvBytesToString}}
{{end}}

DG2:
{{if .Dg2}}
{{.Dg2.RawData | BytesToHex}}

{{.Dg2.RawData | TlvBytesToString}}
{{end}}

DG7:
{{if .Dg7}}
{{.Dg7.RawData | BytesToHex}}

{{.Dg7.RawData | TlvBytesToString}}
{{end}}

DG11:
{{if .Dg11}}
{{.Dg11.RawData | BytesToHex}}

{{.Dg11.RawData | TlvBytesToString}}
{{end}}

DG12:
{{if .Dg12}}
{{.Dg12.RawData | BytesToHex}}

{{.Dg12.RawData | TlvBytesToString}}
{{end}}

DG13:
{{if .Dg13}}
{{.Dg13.RawData | BytesToHex}}

{{.Dg13.RawData | TlvBytesToString}}
{{end}}

DG14:
{{if .Dg14}}
{{.Dg14.RawData | BytesToHex}}

{{.Dg14.RawData | TlvBytesToString}}
{{end}}

DG15:
{{if .Dg15}}
{{.Dg15.RawData | BytesToHex}}

{{.Dg15.RawData | TlvBytesToString}}
{{end}}

DG16:
{{if .Dg16}}
{{.Dg16.RawData | BytesToHex}}

{{.Dg16.RawData | TlvBytesToString}}
{{end}}

ChipAuthStatus: {{.ChipAuthStatus}}
