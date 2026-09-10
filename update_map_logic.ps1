$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

# 1. Update applyCategory
$html = $html -replace "(?s)else if \(cat === 'potencias'\) \{\s*if \(info && info\.potencia_regional\) el\.style\('fill', '#9333ea'\)\.style\('opacity', 1\);\s*else el\.style\('opacity', 0\.2\);\s*\}", @"
else if (cat === 'potencias') {
      if (info && info.potencia_regional) {
        if (info.potencia_regional.tipo_poder.toLowerCase().includes('global')) {
          el.style('fill', '#4f46e5').style('opacity', 1);
        } else {
          el.style('fill', '#9333ea').style('opacity', 1);
        }
      }
      else el.style('opacity', 0.2);
    }
"@

# 2. Update updateLegend
$html = $html -replace '(?s)case ''potencias'':\s*html = `\s*<div class="legend-title">Potencias</div>\s*<div class="legend-item"><div class="legend-dot" style="background:#9333ea"></div>Potencia Global</div>\s*<div class="legend-item"><div class="legend-dot" style="background:#a855f7"></div>Potencia Regional</div>\s*`;\s*break;', @"
case 'potencias':
      html = `
        <div class="legend-title">Potencias regionales</div>
        <div class="legend-item"><div class="legend-dot" style="background:#4f46e5"></div>Potencia global con predominio regional</div>
        <div class="legend-item"><div class="legend-dot" style="background:#9333ea"></div>Potencia regional principal</div>
      `;
      break;
"@

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "Map and Legend logic updated!"
