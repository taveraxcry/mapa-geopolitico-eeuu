$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

$zoomPattern = "(?s)zoom = d3\.zoom\(\).*?g\.attr\('transform', event\.transform\);"
$zoomReplace = "zoom = d3.zoom()`n    .scaleExtent([0.8, 20])`n    .on('zoom', (event) => {`n      g.attr('transform', event.transform);`n      g.selectAll('.mesh-borders').attr('stroke-width', 1 / event.transform.k);`n      g.selectAll('.country-path').attr('stroke-width', 1 / event.transform.k);"
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $zoomPattern, $zoomReplace)

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
