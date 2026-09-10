$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

# 1. Update .country-path CSS
$cssPattern = '(?s)\.country-path \{(.*?)\}'
$cssReplace = ".country-path {`n  fill: var(--land-default);`n  stroke: rgba(10, 14, 26, 0.9); /* Dark background color for sharp separation */`n  stroke-width: 1px;`n  cursor: pointer;`n  transition: fill 0.2s ease, stroke-width 0.2s ease;`n}"
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $cssPattern, $cssReplace, 1)

$hoverPattern = '(?s)\.country-path:hover \{(.*?)\}'
$hoverReplace = ".country-path:hover {`n  fill: var(--land-hover);`n  stroke: rgba(255, 255, 255, 0.7);`n  stroke-width: 1.5px;`n}"
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $hoverPattern, $hoverReplace, 1)

# 2. Update D3 mesh borders
$meshPattern = '(?s)// Add country borders(.*?)attr\(''stroke'', ''rgba\(148,163,184,0\.4\)''\)(.*?)attr\(''stroke-width'', 0\.8\)(.*?)attr\(''d'', path\);'
$meshReplace = "// Add country borders`$1attr('stroke', 'rgba(10, 14, 26, 0.9)')`$2attr('stroke-width', 1).style('pointer-events', 'none')`$3attr('d', path).attr('class', 'mesh-borders');"
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $meshPattern, $meshReplace)

# 3. Add zoom behavior update for mesh borders
# So the border doesn't get ridiculously thick when zooming in
$zoomPattern = '(?s)function zoomed\(event\) \{.*?(g\.attr\(''transform'', event\.transform\);)'
$zoomReplace = "`$1`n  g.selectAll('.mesh-borders').attr('stroke-width', 1 / event.transform.k);`n  g.selectAll('.country-path').attr('stroke-width', 1 / event.transform.k);"
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $zoomPattern, $zoomReplace)

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "Borders updated!"
