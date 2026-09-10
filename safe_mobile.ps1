$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

# 1. Append overriding CSS for mobile
$newCss = @"

/* ===== MOBILE RESPONSIVE OVERRIDES ===== */
@media (max-width: 768px) {
  body, html { overflow-x: hidden; width: 100%; position: relative; overscroll-behavior-y: none; }
  
  /* Compact multi-row header */
  #header {
    height: auto;
    display: grid !important;
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
    display: flex !important;
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
    top: 92px !important; /* Below the header */
    width: 100%;
    border-radius: 0;
    justify-content: flex-start;
    overflow-x: auto;
    padding: 6px 10px !important;
    -webkit-overflow-scrolling: touch;
    scrollbar-width: none;
    background: rgba(15, 23, 42, 0.85);
    border-bottom: 1px solid rgba(255,255,255,0.05);
  }
  #continent-nav::-webkit-scrollbar { display: none; }
  .cont-btn { white-space: nowrap; flex-shrink: 0; padding: 6px 12px !important; font-size: 11px !important; }

  /* Bottom Sheet Info Panel */
  #info-panel {
    top: auto !important;
    bottom: 0 !important;
    left: 0 !important;
    right: 0 !important;
    width: 100% !important;
    height: auto !important;
    max-height: 75dvh !important;
    border-left: none !important;
    border-top: 1px solid rgba(255,255,255,0.1) !important;
    border-radius: 20px 20px 0 0 !important;
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

  #map-legend { bottom: 10px !important; left: 10px !important; font-size: 11px !important; padding: 10px !important; z-index: 900; }
  
  #controls {
    top: auto !important;
    bottom: 10px !important;
    right: 10px !important;
    flex-direction: column;
  }
}
</style>
"@
$html = $html.Replace("</style>", $newCss)


# 2. Update JS interactions
$html = $html.Replace("panel.classList.add('open');", "panel.classList.add('open');`n  if (window.innerWidth <= 768) { hideTooltip(); document.getElementById('map-legend').style.display = 'none'; document.getElementById('controls').style.display = 'none'; }")

$html = $html.Replace("document.getElementById('info-panel').classList.remove('open');", "document.getElementById('info-panel').classList.remove('open');`n  if (window.innerWidth <= 768) { document.getElementById('map-legend').style.display = ''; document.getElementById('controls').style.display = ''; }")

$html = $html.Replace("function showTooltipAt(x, y, data) {", "function showTooltipAt(x, y, data) {`n  if (window.innerWidth <= 768 && document.getElementById('info-panel').classList.contains('open')) return;")

$html = $html.Replace("selectedCountry = name;`r`n`r`n  // Show info panel", "selectedCountry = name;`n  if (window.innerWidth <= 768) hideTooltip();`n`n  // Show info panel")

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "Mobile responsive CSS & JS injected securely!"
