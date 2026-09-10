$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

# 1. Update .country-path CSS
$cssPattern = '(?s)\.country-path \{(.*?)\}'
$cssReplace = ".country-path {`n  fill: var(--land-default);`n  stroke: rgba(10, 14, 26, 0.8); /* Dark background color gap */`n  stroke-width: 1px;`n  cursor: pointer;`n  transition: fill 0.2s ease, stroke-width 0.2s ease;`n}"
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $cssPattern, $cssReplace, 1)

# 2. Update D3 mesh borders to be a crisp light line overlay
$meshPattern = '(?s)// Add country borders(.*?)attr\(''stroke'', ''rgba\(10, 14, 26, 0\.9\)''\)(.*?)attr\(''stroke-width'', 1\)(.*?)attr\(''class'', ''mesh-borders''\);'
$meshReplace = "// Add country borders`$1attr('stroke', 'rgba(148, 163, 184, 0.25)')`$2attr('stroke-width', 0.6)`$3attr('class', 'mesh-borders');"
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $meshPattern, $meshReplace)

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "Borders refined with embossed effect!"
