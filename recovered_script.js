function getRelationColor(relation_es, alpha) {
  if (!relation_es) return `rgba(100,116,139,${alpha})`;
  const r = relation_es.toLowerCase();
  if (r.includes('aliado') || r.includes('ally')) return `rgba(34,197,94,${alpha})`;
  if (r.includes('socio') || r.includes('partner')) return `rgba(6,182,212,${alpha})`;
  if (r.includes('competidor') || r.includes('competitor')) return `rgba(245,158,11,${alpha})`;
  if (r.includes('adversario') || r.includes('adversary') || r.includes('sin relaciones') || r.includes('sanciones')) return `rgba(239,68,68,${alpha})`;
  if (r.includes('territorio') && r.includes('ee.uu')) return `rgba(37,99,235,${alpha})`;
  return `rgba(100,116,139,${alpha})`;
}

function getRelationColorHex(relation) {
  switch(relation) {
    case 'ally': return '#22c55e';
    case 'partner': return '#06b6d4';
    case 'competitor': return '#f59e0b';
    case 'adversary': return '#ef4444';
    case 'self': return '#2563eb';
    default: return '#64748b';
  }
}

// ============================================================
// INFO PANEL
// ============================================================

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
  document.getElementById('panel-capital').textContent = `Capital: ${capital} • ${region}`;

  const badge = document.getElementById('panel-relation');
  
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
  badge.style.border = `1px solid ${getRelationColor(relation_es, 0.3)}`;

  let html = '';

  if (info.summary) {
    html += `<div class="panel-section animate-in"><div class="panel-section-title">📋 Resumen Geopolítico</div>
             <div class="panel-section-content" style="font-weight:600;">${info.summary}</div></div>`;
  } else if (info.description) {
    html += `<div class="panel-section animate-in"><div class="panel-section-title">📋 Análisis Geopolítico</div>
             <div class="panel-section-content">${info.description}</div></div>`;
  }

  // New Schema Stats
  if (info.econ_importance) {
    html += `<div class="panel-section animate-in" style="animation-delay:0.05s"><div class="panel-section-title">📊 Datos Clave</div>
      <div class="panel-stat-row"><span class="panel-stat-label">Población</span><span class="panel-stat-value">${info.identity.pop}</span></div>
      <div class="panel-stat-row"><span class="panel-stat-label">PIB</span><span class="panel-stat-value">${info.econ_importance.gdp}</span></div>
      <div class="panel-stat-row"><span class="panel-stat-label">PIB per cápita</span><span class="panel-stat-value">${info.econ_importance.gdp_pc}</span></div>
      <div class="panel-stat-row"><span class="panel-stat-label">Crecimiento</span><span class="panel-stat-value">${info.econ_importance.growth}</span></div>
    </div>`;
  } else if (info.population) {
    html += `<div class="panel-section animate-in" style="animation-delay:0.05s"><div class="panel-section-title">📊 Datos Clave</div>
      <div class="panel-stat-row"><span class="panel-stat-label">Población</span><span class="panel-stat-value">${info.population}</span></div>
      <div class="panel-stat-row"><span class="panel-stat-label">PIB</span><span class="panel-stat-value">${info.gdp}</span></div>
      <div class="panel-stat-row"><span class="panel-stat-label">PIB per cápita</span><span class="panel-stat-value">${info.gdp_pc}</span></div>
      <div class="panel-stat-row"><span class="panel-stat-label">Continente</span><span class="panel-stat-value">${info.region}</span></div>
    </div>`;
  }

  // USA Relation Detailed
  if (info.usa_relation && info.usa_relation.explanation) {
    html += `<div class="panel-section animate-in" style="animation-delay:0.08s">
      <div class="panel-section-title">🇺🇸 Relación con EE.UU.</div>
      <div class="panel-section-content">${info.usa_relation.explanation}</div>
    </div>`;
  }
  // China Relation Detailed
  if (info.china_relation && info.china_relation.explanation) {
    html += `<div class="panel-section animate-in" style="animation-delay:0.1s">
      <div class="panel-section-title">🇨🇳 Relación con China</div>
      <div class="panel-section-content">${info.china_relation.explanation}</div>
    </div>`;
  }
  // Russia Relation Detailed
  if (info.russia_relation && info.russia_relation.explanation) {
    html += `<div class="panel-section animate-in" style="animation-delay:0.1s">
      <div class="panel-section-title">🇷🇺 Relación con Rusia</div>
      <div class="panel-section-content">${info.russia_relation.explanation}</div>
    </div>`;
  }

  const orgs = info.orgs || info.orgs_simple || [];
  if (orgs.length > 0) {
    html += `<div class="panel-section animate-in" style="animation-delay:0.1s">
      <div class="panel-section-title">🏛️ Organizaciones</div>
      <div class="panel-tags">${orgs.map(o => `<span class="panel-tag">${o}</span>`).join('')}</div>
    </div>`;
  }

  // Detailed Allies (New schema is array of objects, legacy is array of strings)
  if (info.allies && info.allies.length > 0) {
    const allyFlags = info.allies.map(a => {
      const allyName = typeof a === 'string' ? a : a.country;
      const ai = GEO_DB.countries[allyName];
      if (!ai) return '';
      const aName = ai.identity ? ai.identity.name_es : ai.name_es;
      const aFlag = ai.identity ? ai.identity.flag : ai.flag;
      const tooltip = typeof a === 'object' ? ` title="${a.type}: ${a.importance}"` : '';
      return `<span class="panel-tag" style="cursor:pointer; display: flex; align-items: center; gap: 4px;" onclick="selectCountryByName('${allyName}')"${tooltip}>
        <span>${getFlagEmoji(aFlag)}</span> ${aName}
      </span>`;
    }).join('');
    html += `<div class="panel-section animate-in" style="animation-delay:0.15s">
      <div class="panel-section-title">🤝 Aliados Principales</div>
      <div class="panel-tags">${allyFlags}</div>
    </div>`;
  }

  // Rivals
  if (info.rivals && info.rivals.length > 0) {
    const rivalFlags = info.rivals.map(r => {
      const rivalName = r.country;
      const ri = GEO_DB.countries[rivalName];
      if (!ri) return '';
      const rName = ri.identity ? ri.identity.name_es : ri.name_es;
      const rFlag = ri.identity ? ri.identity.flag : ri.flag;
      return `<span class="panel-tag" style="cursor:pointer; display: flex; align-items: center; gap: 4px; border-color: rgba(239,68,68,0.3); background: rgba(239,68,68,0.1);" onclick="selectCountryByName('${rivalName}')" title="${r.reason}">
        <span>${getFlagEmoji(rFlag)}</span> ${rName}
      </span>`;
    }).join('');
    html += `<div class="panel-section animate-in" style="animation-delay:0.16s">
      <div class="panel-section-title">⚔️ Rivales Principales</div>
      <div class="panel-tags">${rivalFlags}</div>
    </div>`;
  }

  // Conflicts
  if (info.conflicts && info.conflicts.length > 0) {
    html += `<div class="panel-section animate-in" style="animation-delay:0.17s">
      <div class="panel-section-title">💥 Conflictos</div>
      ${info.conflicts.map(c => `
        <div style="margin-bottom:8px; padding:8px; background:rgba(255,255,255,0.05); border-radius:6px; border-left: 2px solid var(--accent-rose)">
          <div style="font-weight:600; font-size:12px; color:var(--text-primary); margin-bottom:4px;">${c.name} (${c.since})</div>
          <div style="font-size:11px; color:var(--text-secondary);">${c.current}</div>
        </div>
      `).join('')}
    </div>`;
  }

  // Geo & Econ Importance
  if (info.geo_importance) {
    html += `<div class="panel-section animate-in" style="animation-delay:0.18s">
      <div class="panel-section-title">🎯 Importancia Geopolítica</div>
      <div class="panel-section-content">${info.geo_importance}</div>
    </div>`;
  }
  if (info.technology || info.minerals || info.energy) {
    html += `<div class="panel-section animate-in" style="animation-delay:0.19s">
      <div class="panel-section-title">⚡ Recursos y Tecnología</div>
      <div class="panel-section-content" style="font-size:12px; opacity:0.9;">
        ${info.technology ? `<b>Tecnología:</b> ${info.technology}<br><br>` : ''}
        ${info.energy ? `<b>Energía:</b> ${info.energy}<br><br>` : ''}
        ${info.minerals ? `<b>Minerales Críticos:</b> ${info.minerals}` : ''}
      </div>
    </div>`;
  }

  // Keywords (legacy)
  if (info.keywords && info.keywords.length > 0) {
    html += `<div class="panel-section animate-in" style="animation-delay:0.2s">
      <div class="panel-section-title">🏷️ Palabras Clave</div>
      <div class="panel-tags">${info.keywords.map(k => `<span class="panel-tag" style="opacity:0.7">#${k}</span>`).join('')}</div>
    </div>`;
  }

  // Compare button
  html += `<button class="compare-btn animate-in" style="animation-delay:0.25s" onclick="startCompare('${name}')">⚖️ Comparar con otro país</button>`;

  document.getElementById('panel-body').innerHTML = html;
  
  // Notice we use "active" for the panel instead of "open" based on previous logic? Wait, the previous code had panel.classList.add('open') at 3225
  panel.classList.add('open');
}

