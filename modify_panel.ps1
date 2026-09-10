$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

# 1. Tooltip update
$html = $html -replace 'relEl\.textContent = data\.potencia_regional\.reason;', 'relEl.innerHTML = data.potencia_regional.long_reason;'

# 2. Panel title update
$pattern = '(?s)if \(activeCategory === ''potencias'' && info\.potencia_regional\) \{\s*badge\.textContent = `Potencia regional [^`]*`;'
$replacement = @"
if (activeCategory === 'potencias' && info.potencia_regional) {
    let panelTitle = "Potencia regional";
    if (info.potencia_regional.tipo_poder.toLowerCase().includes('global')) {
      panelTitle = "Potencia global con predominio regional";
    }
    badge.textContent = panelTitle;
"@
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $pattern, $replacement)

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "Panel and tooltip updated successfully!"
