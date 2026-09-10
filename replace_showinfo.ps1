$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

$startIdx = $html.IndexOf('function showInfoPanel(name, info) {')
$endIdx = $html.IndexOf('function closePanel() {')

if ($startIdx -ge 0 -and $endIdx -gt $startIdx) {
    $before = $html.Substring(0, $startIdx)
    $after = $html.Substring($endIdx)
    
    $newFunction = @"
function showInfoPanel(name, info) {
  const panel = document.getElementById('info-panel');

  // Fallback support for new vs legacy schema
  const flag = info.identity ? info.identity.flag : info.flag;
  const name_es = info.identity ? info.identity.name_es : info.name_es;
  const capital = info.identity ? info.identity.capital : info.capital;
  const region = info.identity ? info.identity.region : info.region;
  const relation_es = info.relation_es || (info.usa_relation ? info.usa_relation.level : "—");
  
  const panelFlag = document.getElementById('panel-flag');
  panelFlag.textContent = getFlagEmoji(flag);
  panelFlag.className = 'panel-flag';
  document.getElementById('panel-name').textContent = name_es;
  document.getElementById('panel-capital').textContent = `"Capital: `$capital • `$region`";

  const badge = document.getElementById('panel-relation');
  
  if (activeCategory === 'potencias' && info.potencia_regional) {
    badge.textContent = `"Potencia regional — `$(info.potencia_regional.region_poder || region)`";
    badge.style.background = 'rgba(147, 51, 234, 0.1)';
    badge.style.color = '#c084fc';
    badge.style.border = '1px solid rgba(147, 51, 234, 0.3)';
    
    let html = `"
      <div class="panel-section animate-in">
        <div class="panel-section-title" style="text-transform: uppercase;">Tipo de poder</div>
        <div class="panel-section-content" style="font-weight:600; color:var(--text-primary);">`$(info.potencia_regional.tipo_poder)</div>
      </div>

      <div class="panel-section animate-in" style="animation-delay:0.05s">
        <div class="panel-section-title" style="text-transform: uppercase;">¿Por qué es una potencia regional?</div>
        <div class="panel-section-content">`$(info.potencia_regional.long_reason)</div>
      </div>
      
      <div class="panel-section animate-in" style="animation-delay:0.1s">
        <div class="panel-section-title" style="text-transform: uppercase;">Ámbito de influencia</div>
        <div class="panel-section-content">`$(info.potencia_regional.influence)</div>
      </div>

      <div class="panel-section animate-in" style="animation-delay:0.15s">
        <div class="panel-section-title" style="text-transform: uppercase;">Principales fortalezas</div>
        <div class="panel-section-content">`$(info.potencia_regional.strengths)</div>
      </div>

      <div class="panel-section animate-in" style="animation-delay:0.2s">
        <div class="panel-section-title" style="text-transform: uppercase;">Importancia estratégica</div>
        <div class="panel-section-content">`$(info.potencia_regional.strategic)</div>
      </div>
    `";
    
    document.getElementById('panel-body').innerHTML = html;
    
    panel.classList.add('open');
    if (window.innerWidth <= 768) {
      document.getElementById('overlay').classList.add('active');
    }
    return;
  }

  badge.textContent = relation_es;
  badge.style.background = getRelationColor(relation_es, 0.15);
  badge.style.color = getRelationColor(relation_es, 1);
  badge.style.border = `"1px solid `$(getRelationColor(relation_es, 0.3))`";

  let html = '';

  if (info.summary) {
    html += `"<div class="panel-section animate-in"><div class="panel-section-title">🔍 Resumen Geopolítico</div>
             <div class="panel-section-content" style="font-weight:600;">`$(info.summary)</div></div>`";
  } else if (info.description) {
    html += `"<div class="panel-section animate-in"><div class="panel-section-title">🔍 Resumen Geopolítico</div>
             <div class="panel-section-content" style="font-weight:600;">`$(info.description)</div></div>`";
  }

  // Relations section
  if (info.usa_relation) {
    html += `"<div class="panel-section animate-in" style="animation-delay:0.05s">
               <div class="panel-section-title">🇺🇸 Relación con EE.UU.</div>
               <div class="panel-section-content">`$(info.usa_relation.details)</div>
             </div>`";
  }

  // Treaties/Orgs section
  if (info.orgs && info.orgs.length > 0) {
    html += `"<div class="panel-section animate-in" style="animation-delay:0.1s">
               <div class="panel-section-title">🏛️ Organizaciones y Tratados</div>
               <div class="tags-container">`";
    info.orgs.forEach(org => {
      html += `"<span class="tag">`$(org)</span>`";
    });
    html += '"</div></div>"';
  } else if (info.orgs_simple) {
    html += `"<div class="panel-section animate-in" style="animation-delay:0.1s">
               <div class="panel-section-title">🏛️ Organizaciones y Tratados</div>
               <div class="tags-container">`";
    info.orgs_simple.forEach(org => {
      html += `"<span class="tag">`$(org)</span>`";
    });
    html += '"</div></div>"';
  }

  // Conflicts
  if (info.conflicts && info.conflicts.length > 0) {
    html += `"<div class="panel-section animate-in" style="animation-delay:0.15s">
               <div class="panel-section-title">⚠️ Conflictos Activos</div>
               <div class="panel-section-content">
                 <ul style="margin:0; padding-left:20px; list-style-type:disc;">`";
    info.conflicts.forEach(c => {
      html += `"<li style="margin-bottom:4px; color:#ef4444">`$(c)</li>`";
    });
    html += '"</ul></div></div>"';
  }

  // Competitors
  if (info.competitors && info.competitors.length > 0) {
    html += `"<div class="panel-section animate-in" style="animation-delay:0.2s">
               <div class="panel-section-title">⚔️ Competidores / Tensiones</div>
               <div class="tags-container">`";
    info.competitors.forEach(c => {
      html += `"<span class="tag" style="background:rgba(245,158,11,0.1); color:#d97706; border-color:rgba(245,158,11,0.3)">`$(c)</span>`";
    });
    html += '"</div></div>"';
  }

  document.getElementById('panel-body').innerHTML = html;
  
  panel.classList.add('open');
  if (window.innerWidth <= 768) {
    document.getElementById('overlay').classList.add('active');
  }
}

"@

    # Replace `" with backtick ` because in PowerShell string literal I had to escape backticks
    $newFunction = $newFunction.Replace('`"', '`')

    $html = $before + $newFunction + $after
    [System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
    Write-Output "Successfully rebuilt showInfoPanel!"
} else {
    Write-Output "Could not find start or end index."
}
