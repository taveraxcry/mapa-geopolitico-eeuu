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

# 3. Update showInfoPanel
# Because of Spanish characters, we'll use a more flexible regex that matches the start and end of the block.
$pattern = '(?s)if \(activeCategory === ''potencias'' && info\.potencia_regional\) \{.*?badge\.textContent = `Potencia regional [^`]+`;.*?let html = `.*?</div>\s*`;'

$replacement = @"
if (activeCategory === 'potencias' && info.potencia_regional) {
    badge.textContent = `Potencia regional — ${info.potencia_regional.region_poder || region}`;
    badge.style.background = 'rgba(147, 51, 234, 0.1)';
    badge.style.color = '#c084fc';
    badge.style.border = '1px solid rgba(147, 51, 234, 0.3)';
    
    let html = `
      <div class="panel-section animate-in">
        <div class="panel-section-title" style="text-transform: uppercase;">Tipo de poder</div>
        <div class="panel-section-content" style="font-weight:600; color:var(--text-primary);">${info.potencia_regional.tipo_poder}</div>
      </div>

      <div class="panel-section animate-in" style="animation-delay:0.05s">
        <div class="panel-section-title" style="text-transform: uppercase;">¿Por qué es una potencia regional?</div>
        <div class="panel-section-content">${info.potencia_regional.long_reason}</div>
      </div>
      
      <div class="panel-section animate-in" style="animation-delay:0.1s">
        <div class="panel-section-title" style="text-transform: uppercase;">Ámbito de influencia</div>
        <div class="panel-section-content">${info.potencia_regional.influence}</div>
      </div>

      <div class="panel-section animate-in" style="animation-delay:0.15s">
        <div class="panel-section-title" style="text-transform: uppercase;">Principales fortalezas</div>
        <div class="panel-section-content">${info.potencia_regional.strengths}</div>
      </div>

      <div class="panel-section animate-in" style="animation-delay:0.2s">
        <div class="panel-section-title" style="text-transform: uppercase;">Importancia estratégica</div>
        <div class="panel-section-content">${info.potencia_regional.strategic}</div>
      </div>
    `;
"@

$html = [System.Text.RegularExpressions.Regex]::Replace($html, $pattern, $replacement)

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "UI logic updated!"
