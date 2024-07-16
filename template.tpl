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

<h2>CardAccess</h2>
{{if .CardAccess}}
<div><pre>
{{.CardAccess.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.CardAccess.RawData | TlvBytesToString}}
</pre></div>
{{else}}
<i>No data</i>
{{end}}

<h2>CardSecurity</h2>
{{if .CardSecurity}}
<div><pre>
{{.CardSecurity.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.CardSecurity.RawData | TlvBytesToString}}
</pre></div>
{{else}}
<i>No data</i>
{{end}}

<h2>DIR</h2>
{{if .Dir}}
<div><pre>
{{.Dir.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Dir.RawData | TlvBytesToString}}
</pre></div>
{{else}}
<i>No data</i>
{{end}}

<h2>COM</h2>
{{if .Com}}
<div><pre>
{{.Com.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Com.RawData | TlvBytesToString}}
</pre></div>
{{else}}
<i>No data</i>
{{end}}

<h2>SOD</h2>
{{if .Sod}}
<div><pre>
{{.Sod.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Sod.RawData | TlvBytesToString}}
</pre></div>
{{else}}
<i>No data</i>
{{end}}

<h2>DG1</h2>
{{if .Dg1}}
<div><pre>
{{.Dg1.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Dg1.RawData | TlvBytesToString}}
</pre></div>

<div><pre>
DocumentCode  : {{.Dg1.Mrz.DocumentCode}}
IssuingState  : {{.Dg1.Mrz.IssuingState}}
NameOfHolder  : [Primary] {{.Dg1.Mrz.NameOfHolder.Primary}} [Secondary] {{.Dg1.Mrz.NameOfHolder.Secondary}}
DocumentNumber: {{.Dg1.Mrz.DocumentNumber}}
Nationality   : {{.Dg1.Mrz.Nationality}}
DateOfBirth   : {{.Dg1.Mrz.DateOfBirth}}
Sex           : {{.Dg1.Mrz.Sex}}
DateOfExpiry  : {{.Dg1.Mrz.DateOfExpiry}}
OptionalData  : {{.Dg1.Mrz.OptionalData}}
OptionalData2 : {{.Dg1.Mrz.OptionalData2}}
</pre></div>
{{else}}
<i>No data</i>
{{end}}

<h2>DG2</h2>
{{if .Dg2}}
<div><pre>
{{.Dg2.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Dg2.RawData | TlvBytesToString}}
</pre></div>

<!-- TODO - would be good got DG2 to provide an easier way to access the images -->
{{ range .Dg2.BITs }}
    {{ range .BDB.Facial.Images }}
        <img src="data:image/jpeg;base64,{{.Data | BytesToBase64}}" />
        <br/>
        Image size (bytes): {{len .Data}}
    {{ end }}
{{ end }}


{{else}}
<i>No data</i>
{{end}}

<h2>DG7</h2>
{{if .Dg7}}
<div><pre>
{{.Dg7.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Dg7.RawData | TlvBytesToString}}
</pre></div>
{{else}}
<i>No data</i>
{{end}}

<h2>DG11</h2>
{{if .Dg11}}
<div><pre>
{{.Dg11.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Dg11.RawData | TlvBytesToString}}
</pre></div>

<div><pre>
NameOfHolder        : {{.Dg11.Details.NameOfHolder}}
OtherNames          : {{.Dg11.Details.OtherNames}}
PersonalNumber      : {{.Dg11.Details.PersonalNumber}}
FullDateOfBirth     : {{.Dg11.Details.FullDateOfBirth}}
PlaceOfBirth        : {{.Dg11.Details.PlaceOfBirth}}
Address             : {{.Dg11.Details.Address}}
Telephone           : {{.Dg11.Details.Telephone}}
Profession          : {{.Dg11.Details.Profession}}
Title               : {{.Dg11.Details.Title}}
PersonalSummary     : {{.Dg11.Details.PersonalSummary}}
ProofOfCitizenship  : {{.Dg11.Details.ProofOfCitizenship | BytesToHex}}
OtherTravelDocuments: {{.Dg11.Details.OtherTravelDocuments}}
CustodyInformation  : {{.Dg11.Details.CustodyInformation}}
</div></pre>

{{else}}
<i>No data</i>
{{end}}

<h2>DG12</h2>
{{if .Dg12}}
<div><pre>
{{.Dg12.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Dg12.RawData | TlvBytesToString}}
</pre></div>

<div><pre>
IssuingAuthority           : {{.Dg12.Details.IssuingAuthority}}
DateOfIssue                : {{.Dg12.Details.DateOfIssue}}
OtherPersons               : {{.Dg12.Details.OtherPersons}}
EndorsementsAndObservations: {{.Dg12.Details.EndorsementsAndObservations}}
TaxExitRequirements        : {{.Dg12.Details.TaxExitRequirements}}
ImageFront                 : {{.Dg12.Details.ImageFront | BytesToHex}}
ImageRear                  : {{.Dg12.Details.ImageRear | BytesToHex}}
PersoDateTime              : {{.Dg12.Details.PersoDateTime}}
PersoSystemSerialNumber    : {{.Dg12.Details.PersoSystemSerialNumber}}
</pre></div>

{{else}}
<i>No data</i>
{{end}}

<h2>DG13</h2>
{{if .Dg13}}
<div><pre>
{{.Dg13.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Dg13.RawData | TlvBytesToString}}
</pre></div>
{{else}}
<i>No data</i>
{{end}}

<h2>DG14</h2>
{{if .Dg14}}
<div><pre>
{{.Dg14.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Dg14.RawData | TlvBytesToString}}
</pre></div>
{{else}}
<i>No data</i>
{{end}}

<h2>DG15</h2>
{{if .Dg15}}
<div><pre>
{{.Dg15.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Dg15.RawData | TlvBytesToString}}
</pre></div>
{{else}}
<i>No data</i>
{{end}}

<h2>DG16</h2>
{{if .Dg16}}
<div><pre>
{{.Dg16.RawData | BytesToHex}}
</pre></div>

<div><pre>
{{.Dg16.RawData | TlvBytesToString}}
</pre></div>
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
