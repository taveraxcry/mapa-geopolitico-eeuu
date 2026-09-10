$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

$pattern = "(?s)case 'potencias':\s*html = \s*<div class=`"legend-title`">Potencias regionales</div>\s*<div class=`"legend-item`"><div class=`"legend-dot`" style=`"background:#4f46e5`"></div>Potencia global con predominio regional</div>\s*<div class=`"legend-item`"><div class=`"legend-dot`" style=`"background:#9333ea`"></div>Potencia regional principal</div>\s*;\s*break;"

$replacement = @"
case 'potencias':
      html = ``
        <div class="legend-title">Potencias regionales</div>
        <div class="legend-item"><div class="legend-dot" style="background:#4f46e5"></div>Potencia global con predominio regional</div>
        <div class="legend-item"><div class="legend-dot" style="background:#9333ea"></div>Potencia regional principal</div>
      ``;
      break;
"@

$html = $html -replace $pattern, $replacement
[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "Fixed missing backticks!"
