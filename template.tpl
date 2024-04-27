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
</head>
<body>
<h1>MRTD DOCUMENT OUTPUT</h1>

<div><pre>
LDS version: {{.LdsVersion}}
Unicode version: {{.UnicodeVersion}}
</pre></div>

<pre><div>
ChipAuthStatus: {{.ChipAuthStatus}}
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
NameOfHolder  : {{.Dg1.Mrz.NameOfHolder}}
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

</body>
</html>
