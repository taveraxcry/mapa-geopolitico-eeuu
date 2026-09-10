// ============================================================
// GEOPOLITICAL DATABASE - ATLAS 2026
// ============================================================
const GEO_DB = {
  // Global settings
  last_updated: "2026-09-08",
  
  countries: {
    "United States of America": {
      // A. IDENTIDAD
      identity: {
        name_es: "Estados Unidos", name_official: "Estados Unidos de América", name_local: "United States of America",
        iso2: "US", iso3: "USA", flag: "us", capital: "Washington, D.C.",
        continent: "north-america", subregion: "América del Norte", region: "Norteamérica", hemisphere: "Norte/Occidental",
        area: "9,833,520 km²", pop: "334.9M", density: "34 hab/km²", currency: "Dólar estadounidense (USD)", languages: ["Inglés (de facto)"]
      },
      // B. ESTATUS POLÍTICO
      status: {
        type: "República federal constitucional", gov_system: "Presidencialista", 
        head_of_state: "Presidente de los Estados Unidos", head_of_gov: "Presidente de los Estados Unidos",
        updated: "2026-09-08", current_situation: "Polarización interna, elecciones recientes/próximas.", stability: "Media-Alta",
        institutions: ["Congreso", "Corte Suprema"], elections: "Elecciones de medio mandato en 2026."
      },
      // C. RELACIÓN CON EE.UU.
      usa_relation: {
        level: "self", 
        explanation: "Es el propio país hegemónico."
      },
      // D. RELACIÓN CON CHINA
      china_relation: {
        level: "Competidor sistémico / Rival",
        explanation: "Competencia comercial, tecnológica y militar a nivel global. Tensiones altas en el Indo-Pacífico (Taiwán, Mar de China Meridional). Restricciones a semiconductores y tecnología avanzada impuestas por Washington."
      },
      // E. RELACIÓN CON RUSIA
      russia_relation: {
        level: "Adversario geopolítico",
        explanation: "Relación en punto mínimo histórico debido a la guerra en Ucrania. Sanciones masivas de EE.UU. contra la economía rusa. Choque de intereses en Europa Oriental y Medio Oriente."
      },
      // F. ALIADOS
      allies: [
        { country: "United Kingdom", type: "Alianza Especial", org: "OTAN, AUKUS, Five Eyes", since: "1940s", area: "Global", importance: "Socio de inteligencia y militar de mayor confianza." },
        { country: "Japan", type: "Alianza de Defensa", org: "Tratado de Seguridad Mutua", since: "1951", area: "Indo-Pacífico", importance: "Pilar de la presencia de EE.UU. en Asia para contener a China." },
        { country: "Israel", type: "Aliado Estratégico", org: "Major Non-NATO Ally", since: "1980s", area: "Medio Oriente", importance: "Pilar de la política estadounidense en el Medio Oriente." }
      ],
      // G. SOCIOS
      partners: [
        { country: "Colombia", type: "Socio Estratégico", area: "Seguridad y Narcotráfico", importance: "Principal socio militar en Sudamérica." }
      ],
      // H. RIVALES
      rivals: [
        { country: "China", reason: "Hegemonía global y tecnológica", dimensions: ["económica", "militar", "tecnológica"] },
        { country: "Russia", reason: "Expansión en Europa y desafío al orden liberal", dimensions: ["militar", "diplomática", "energética"] },
        { country: "Iran", reason: "Programa nuclear y milicias proxy", dimensions: ["militar", "diplomática"] }
      ],
      // I. ORGANIZACIONES
      orgs: ["ONU (P5)", "OTAN", "G7", "G20", "FMI", "Banco Mundial", "USMCA", "OEA", "APEC"],
      // J. BLOQUES ECONÓMICOS
      blocks: [
        { name: "USMCA", type: "TLC", membership: "Miembro", date: "2020", partners: ["Canada", "Mexico"], importance: "Cadenas de suministro norteamericanas." }
      ],
      // K. BRICS
      brics: { is_member: false, role: "N/A" },
      // L. OTAN
      nato: { is_member: true, year: "1949", importance: "Líder de la alianza. Principal contribuyente de tropas, tecnología y presupuesto.", status: "miembro" },
      // M. CONFLICTOS
      conflicts: [
        { name: "Guerra de Ucrania (Proxy)", actors: ["Russia", "Ukraine", "EE.UU./OTAN"], since: "2022", current: "Provisión de inteligencia y armamento avanzado a Kiev. Evitando confrontación directa.", causes: "Defensa del orden europeo.", external: "China (apoyo ruso)" }
      ],
      // N. IMPORTANCIA GEOPOLÍTICA
      geo_importance: "Superpotencia mundial con capacidad de proyección militar global inigualable. Arquitecto del sistema internacional de posguerra, controlando las instituciones financieras globales a través del dólar.",
      // O. IMPORTANCIA ECONÓMICA
      econ_importance: {
        gdp: "US$ 28.78T (est. 2026)", gdp_pc: "US$ 86,601 (est. 2026)", growth: "2.1%", 
        sectors: ["Tecnología", "Finanzas", "Energía", "Aeroespacial"], 
        exports: ["Combustibles", "Aeronaves", "Componentes"], imports: ["Electrónica", "Automóviles", "Bienes de consumo"],
        dependence: "Altamente dependiente de Taiwán para semiconductores de vanguardia."
      },
      // P. ENERGÍA
      energy: "Mayor productor mundial de petróleo y gas (shale). Gran exportador de GNL hacia Europa, reemplazando la dependencia europea de Rusia.",
      // Q. MINERALES
      minerals: "Buscando reducir dependencia de China en tierras raras mediante re-shoring y alianzas (friend-shoring).",
      // R. TECNOLOGÍA
      technology: "Líder mundial en Inteligencia Artificial y software. Controla ecosistemas digitales (Google, Apple, Microsoft). Impone bloqueos a la exportación de chips a China.",
      // S. COMERCIO
      trade: "Principales socios: México, Canadá, China. Dominio de rutas marítimas globales gracias a la US Navy.",
      // T. RUTAS
      routes: "Control de facto de las vías marítimas globales mediante portaviones y alianzas oceánicas.",
      // U. TERRITORIOS ESTRATÉGICOS
      strategic_territories: "Bases en todo el mundo (Japón, Alemania, Corea del Sur, Guam, Diego García).",
      // V. ORGS SEGURIDAD
      security_orgs: ["OTAN", "AUKUS", "Five Eyes", "QUAD"],
      // W. INFLUENCIA REGIONAL
      inf_regional: { level: "Muy alta", why: "Hegemonía en América mediante el Comando Sur y fuerte interdependencia comercial (USMCA)." },
      // X. INFLUENCIA GLOBAL
      inf_global: { level: "Muy alta", why: "Moneda de reserva mundial, superioridad militar, dominio cultural/tecnológico y extensa red de alianzas." },
      // Y. POSICIONAMIENTO
      positioning: "Defensor del orden liberal internacional (Rules-based order). En transición hacia un enfoque más proteccionista e industrialista frente a la competencia de potencias revisionistas.",
      // Z. RESUMEN
      summary: "Estados Unidos importa porque es la única superpotencia con verdadera capacidad de proyección global, su moneda domina el comercio y su ecosistema tecnológico y militar sostienen a la alianza occidental. Sin embargo, enfrenta el mayor desafío a su hegemonía desde la Guerra Fría debido al ascenso de China.",
      
      // Legacy backwards compatibility for basic map coloring
      relation: "self", relation_es: "—", flag: "us", name_es: "Estados Unidos", orgs_simple: ["OTAN"], keywords: []
    },
    
    "China": {
      identity: {
        name_es: "China", name_official: "República Popular China", name_local: "Zhonghua Renmin Gongheguo",
        iso2: "CN", iso3: "CHN", flag: "cn", capital: "Pekín",
        continent: "asia", subregion: "Asia Oriental", region: "Asia", hemisphere: "Norte/Oriental",
        area: "9,596,960 km²", pop: "1.41B", density: "145 hab/km²", currency: "Renminbi (RMB/CNY)", languages: ["Chino mandarín"]
      },
      status: {
        type: "Estado socialista de partido único", gov_system: "Sistema unipartidista (PCCh)",
        head_of_state: "Presidente", head_of_gov: "Primer Ministro",
        updated: "2026-09-08", current_situation: "Consolidación de poder de Xi Jinping, transición hacia economía de alta tecnología frente a crisis inmobiliaria.", stability: "Alta (control estatal férreo)",
        institutions: ["Partido Comunista de China", "Ejército Popular de Liberación"], elections: "Internas del PCCh"
      },
      usa_relation: {
        level: "Competidor / Adversario",
        explanation: "Principal rival sistémico de EE.UU. Compite por el liderazgo tecnológico, económico y militar. Disputas críticas en el Indo-Pacífico."
      },
      china_relation: {
        level: "self",
        explanation: "Potencia hegemónica regional en Asia."
      },
      russia_relation: {
        level: "Socio Estratégico 'Sin Límites'",
        explanation: "Alianza de facto contra el orden occidental. Importación masiva de energía rusa a precios reducidos; apoyo económico y dual-use a Moscú."
      },
      allies: [
        { country: "North Korea", type: "Tratado Mutuo", org: "Tratado de Amistad de 1961", since: "1961", area: "Defensa", importance: "Zona de amortiguamiento crítico frente a tropas de EE.UU. en Corea del Sur." },
        { country: "Pakistan", type: "Socio Estratégico", org: "Corredor Económico (CPEC)", since: "1960s", area: "Infraestructura/Defensa", importance: "Contrapeso a India, acceso al Mar Arábigo." }
      ],
      partners: [
        { country: "Russia", type: "Asociación sin límites", area: "Global", importance: "Aliado anti-occidental clave." },
        { country: "Iran", type: "Socio Integral", area: "Energía/Seguridad", importance: "Suministro energético y presión en Medio Oriente." }
      ],
      rivals: [
        { country: "United States of America", reason: "Hegemonía global", dimensions: ["todas"] },
        { country: "India", reason: "Disputas fronterizas (Himalaya) y competencia por liderazgo del Sur Global", dimensions: ["territorial", "diplomática"] },
        { country: "Japan", reason: "Disputas territoriales (Islas Senkaku/Diaoyu) e historia militar", dimensions: ["territorial", "militar"] }
      ],
      orgs: ["ONU (P5)", "OCS", "BRICS", "RCEP", "APEC"],
      blocks: [
        { name: "RCEP", type: "TLC", membership: "Miembro", date: "2020", partners: ["ASEAN", "Japón", "Corea"], importance: "Mayor bloque comercial del mundo." }
      ],
      brics: { is_member: true, role: "Motor económico. Impulsa desdolarización e infraestructura global (Belt and Road)." },
      nato: { is_member: false, year: "-", importance: "Considerada como rival sistémico por la OTAN.", status: "competidor" },
      conflicts: [
        { name: "Tensión en el Estrecho de Taiwán", actors: ["China", "Taiwan", "EE.UU."], since: "1949", current: "Ejercicios militares de cerco e intimidación en 2026. Riesgo latente de invasión.", causes: "Soberanía sobre Taiwán.", external: "EE.UU., Japón" }
      ],
      geo_importance: "La mayor potencia emergente, con capacidad económica industrial inigualable. Construyendo una Marina de aguas azules para proyectar poder global. Centro de las cadenas de suministro.",
      econ_importance: {
        gdp: "US$ 18.5T (est. 2026)", gdp_pc: "US$ 13,000 (est. 2026)", growth: "4.5%",
        sectors: ["Manufactura avanzada", "Vehículos Eléctricos", "Energías renovables"],
        exports: ["Electrónica", "Maquinaria", "Vehículos Eléctricos"], imports: ["Energía", "Semiconductores", "Alimentos"],
        dependence: "Depende de las importaciones de energía y alimentos por el Estrecho de Malaca."
      },
      energy: "Mayor importador de petróleo. Lidera masivamente la instalación global de energía solar y eólica.",
      minerals: "Controla el refinado de la mayoría de tierras raras, litio, y grafito del mundo. Dominio de baterías EV.",
      technology: "Potencia en 5G, IA y energías verdes. Luchando por autonomía en semiconductores tras los embargos de EE.UU.",
      trade: "Mayor socio comercial para más de 120 países. Iniciativa de la Franja y la Ruta (BRI).",
      routes: "Vulnerable al 'Dilema de Malaca'. Desarrollo del corredor CPEC y control de puertos globales (Hamburgo, El Pireo, Chancay).",
      strategic_territories: "Militarización de islas artificiales en el Mar de China Meridional (Línea de los Nueve Trazos).",
      security_orgs: ["OCS", "Cooperación militar con Rusia e Irán"],
      inf_regional: { level: "Muy alta", why: "Domina económicamente Asia y reclama soberanía sobre el Mar de China Meridional." },
      inf_global: { level: "Alta", why: "Principal prestamista e inversor del Sur Global a través del BRI." },
      positioning: "Busca un orden multipolar, reemplazando la hegemonía estadounidense, e integrar a Taiwán por cualquier medio necesario.",
      summary: "China importa porque es la fábrica del mundo y el único rival con escala suficiente para desplazar a Estados Unidos como hegemón global. Su control sobre cadenas de suministro de energía verde y minerales críticos es un arma geopolítica de primer nivel.",
      
      relation: "adversary", relation_es: "Adversario / Competidor", flag: "cn", name_es: "China", orgs_simple: ["BRICS", "OCS"], keywords: []
    }
  },
  
  // Modos de vista del mapa
  modes: {
    "all": "Mundo",
    "potencias": "Potencias Regionales",
    "aliados": "Red de Alianzas",
    "rivales": "Rivales Sistémicos",
    "conflictos": "Zonas de Conflicto",
    "organizaciones": "Organizaciones Internacionales",
    "bloques": "Bloques Económicos",
    "zonas": "Zonas de Influencia",
    "territorios": "Puntos Estratégicos"
  },
  
  continentViews: {
    "north-america": { x: 250, y: 150, k: 2.2 },
    "south-america": { x: 300, y: -200, k: 2.2 },
    "europe": { x: -80, y: -100, k: 3.5 },
    "africa": { x: -100, y: -50, k: 2.0 },
    "asia": { x: -450, y: -50, k: 1.8 },
    "oceania": { x: -650, y: -250, k: 2.5 },
    "middle-east": { x: -200, y: -80, k: 3.0 }
  },

  strategicLocations: [
    { name: "Canal de Panamá", coords: [-79.91, 9.14], type: "canal", desc: "Ruta marítima hemisférica" },
    { name: "Estrecho de Ormuz", coords: [56.33, 26.56], type: "chokepoint", desc: "Ruta principal de petróleo" },
    { name: "Estrecho de Malaca", coords: [100.0, 3.0], type: "chokepoint", desc: "Corazón comercial de Asia" },
    { name: "Canal de Suez", coords: [32.34, 30.6], type: "canal", desc: "Ruta Europa-Asia" },
    { name: "Bab el-Mandeb", coords: [43.33, 12.58], type: "chokepoint", desc: "Cuello de botella en el Mar Rojo" }
  ]
};
