$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

$pattern = '(?s)if \(activeCategory === ''potencias'' && info\.potencia_regional\) \{.*?let html = `.*?</div>\s*`;'

$replacement = @'
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
'@

$html = [System.Text.RegularExpressions.Regex]::Replace($html, $pattern, $replacement)

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "Fixed the corrupted template!"
