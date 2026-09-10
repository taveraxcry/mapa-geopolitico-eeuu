$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

# 1. Update CSS for mobile responsive
$cssOriginal = '(?s)@media \(max-width: 768px\) \{.*?\}'
$cssNew = @"
@media (max-width: 768px) {
  body, html { overflow-x: hidden; width: 100%; position: relative; overscroll-behavior-y: none; }
  
  /* Compact multi-row header */
  #header {
    height: auto;
    display: grid;
    grid-template-columns: auto 1fr;
    grid-template-rows: auto auto;
    gap: 8px;
    padding: 8px 10px;
    background: rgba(10, 14, 26, 0.95);
  }
  #header .logo { grid-column: 1; grid-row: 1; margin: 0; }
  #header .logo-text { display: none; }
  #search-container { grid-column: 2; grid-row: 1; margin: 0; flex: 1; min-width: 0; }
  
  /* Horizontal Categories */
  #categories {
    display: flex;
    grid-column: 1 / -1;
    grid-row: 2;
    overflow-x: auto;
    padding-bottom: 2px;
    -webkit-overflow-scrolling: touch;
    scrollbar-width: none;
    gap: 6px;
    width: 100%;
  }
  #categories::-webkit-scrollbar { display: none; }
  .cat-pill { white-space: nowrap; flex-shrink: 0; font-size: 11px; padding: 6px 12px; }

  /* Horizontal Continents */
  #continent-nav {
    top: 96px; /* Below the header */
    width: 100%;
    border-radius: 0;
    justify-content: flex-start;
    overflow-x: auto;
    padding: 6px 10px;
    -webkit-overflow-scrolling: touch;
    scrollbar-width: none;
    background: rgba(15, 23, 42, 0.85);
    border-bottom: 1px solid rgba(255,255,255,0.05);
  }
  #continent-nav::-webkit-scrollbar { display: none; }
  .cont-btn { white-space: nowrap; flex-shrink: 0; padding: 5px 12px; font-size: 11px; }

  /* Bottom Sheet Info Panel */
  #info-panel {
    top: auto !important;
    bottom: 0 !important;
    left: 0 !important;
    right: 0 !important;
    width: 100% !important;
    height: auto !important;
    max-height: 75dvh !important;
    border-left: none;
    border-top: 1px solid rgba(255,255,255,0.1);
    border-radius: 20px 20px 0 0;
    transform: translateY(110%);
    transition: transform 0.35s cubic-bezier(0.3, 1, 0.3, 1);
    background: rgba(15, 23, 42, 0.98);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    z-index: 2000;
    display: flex;
    flex-direction: column;
  }
  #info-panel.open {
    transform: translateY(0);
  }
  
  .panel-header {
    flex-shrink: 0;
    padding-top: 16px;
  }
  
  .panel-body {
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;
    overscroll-behavior-y: contain; /* Prevents background map scroll */
    padding-bottom: env(safe-area-inset-bottom, 20px);
  }

  #map-legend { bottom: 10px; left: 10px; font-size: 11px; padding: 10px; z-index: 900; }
  
  .comparator-body { grid-template-columns: 1fr; }
  .comparator-col:first-child { border-right: none; border-bottom: 1px solid var(--border-glass); }
}
"@
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $cssOriginal, $cssNew)

# 2. Update JavaScript to hide Tooltip, Controls, and Legend when panel opens in mobile
# Find showInfoPanel
$showPanelPattern = '(?s)function showInfoPanel\(name, info\) \{.*?(document\.getElementById\(''info-panel''\)\.classList\.add\(''open''\);)'
$showPanelReplacement = "`$1`n  if (window.innerWidth <= 768) {`n    hideTooltip();`n    document.getElementById('map-legend').style.display = 'none';`n    document.getElementById('controls').style.display = 'none';`n  }"
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $showPanelPattern, $showPanelReplacement)

# Find closePanel
$closePanelPattern = '(?s)function closePanel\(\) \{.*?(document\.getElementById\(''info-panel''\)\.classList\.remove\(''open''\);)'
$closePanelReplacement = "`$1`n  if (window.innerWidth <= 768) {`n    document.getElementById('map-legend').style.display = '';`n    document.getElementById('controls').style.display = '';`n  }"
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $closePanelPattern, $closePanelReplacement)

# Find showTooltipAt
$tooltipPattern = '(?s)function showTooltipAt\(x, y, data\) \{'
$tooltipReplacement = "function showTooltipAt(x, y, data) {`n  if (window.innerWidth <= 768 && document.getElementById('info-panel').classList.contains('open')) return;"
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $tooltipPattern, $tooltipReplacement)

# Find click handler to hide tooltip immediately
$clickPattern = '(?s)function handleClick\(event, d\) \{.*?(selectedCountry = name;)'
$clickReplacement = "`$1`n  if (window.innerWidth <= 768) hideTooltip();"
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $clickPattern, $clickReplacement)

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "Mobile responsive updates applied!"
