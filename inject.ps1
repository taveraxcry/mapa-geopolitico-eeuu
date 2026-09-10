$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

$startIdx = $html.IndexOf('function getRelationColor(relation_es, alpha) {')
$endIdx = $html.IndexOf('function closePanel() {')

Write-Output "startIdx: $startIdx"
Write-Output "endIdx: $endIdx"

if ($startIdx -ge 0 -and $endIdx -gt $startIdx) {
    $before = $html.Substring(0, $startIdx)
    $after = $html.Substring($endIdx)
    
    $newFunction = Get-Content "recovered_script.js" -Encoding UTF8 -Raw
    
    $html = $before + $newFunction + "`n" + $after
    [System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
    Write-Output "Successfully replaced block!"
} else {
    Write-Output "Indices not found!"
}
