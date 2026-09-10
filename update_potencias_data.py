import json
import re

html_path = "src/index_template.html"

potencias_data = {
    "United States of America": {
        "tipo_poder": "Potencia global con predominio regional en América y liderazgo estratégico en el sistema internacional.",
        "region_poder": "América del Norte, América Latina y el Caribe; influencia global.",
        "long_reason": "Es una potencia global con capacidades económicas, militares, tecnológicas, diplomáticas y financieras de alcance mundial. En el hemisferio occidental mantiene una posición estratégica privilegiada y una extensa red de alianzas y asociaciones.",
        "influence": "América del Norte, Caribe, América Latina y, a escala mundial, Europa, Indo-Pacífico y Medio Oriente.",
        "strengths": "economía, dólar y sistema financiero, tecnología, fuerzas armadas, inteligencia, alianzas, universidades, innovación y capacidad diplomática.",
        "strategic": "Su posición geográfica, capacidad militar y redes de alianzas le permiten proyectar poder en múltiples regiones simultáneamente."
    },
    "China": {
        "tipo_poder": "Potencia global con predominio regional en Asia Oriental e Indo-Pacífico.",
        "region_poder": "Asia Oriental, Mar de China Meridional, Taiwán, Asia-Pacífico e Indo-Pacífico.",
        "long_reason": "China combina una enorme capacidad económica e industrial con una creciente capacidad tecnológica, militar, comercial y diplomática. Su influencia es especialmente intensa en Asia Oriental y el Indo-Pacífico. <br><small><i>La investigación de 2026 describe a China como potencia global y señala su creciente capacidad para modificar el equilibrio estratégico del Indo-Pacífico. (<a href=\"https://www.swp-berlin.org/10.18449/2026RP08/?utm_source=chatgpt.com\" target=\"_blank\" style=\"color:var(--accent-blue)\">Stiftung Wissenschaft y Politik (SWP)</a>)</i></small>",
        "influence": "Asia Oriental, Sudeste Asiático, Asia Central y amplias redes comerciales globales.",
        "strengths": "manufactura, comercio, tecnología, infraestructura, finanzas, población, poder naval y misiles, cadenas de suministro y capacidad diplomática.",
        "strategic": "Su posición frente a Taiwán, el Mar de China Meridional y las principales rutas marítimas del Indo-Pacífico la convierte en uno de los centros principales de poder del sistema internacional."
    },
    "Russia": {
        "tipo_poder": "Potencia global con predominio regional en Eurasia.",
        "region_poder": "Europa Oriental, Cáucaso, Asia Central y Ártico.",
        "long_reason": "Rusia posee capacidades militares estratégicas, recursos energéticos, territorio continental enorme y capacidad diplomática que le permiten ejercer influencia mucho más allá de sus fronteras inmediatas. <br><small><i>La literatura de 2026 continúa ubicando a Rusia entre los actores capaces de proyectar poder a escala global, aunque con una concentración especialmente fuerte de sus intereses estratégicos en Eurasia. (<a href=\"https://www.swp-berlin.org/10.18449/2026RP08/?utm_source=chatgpt.com\" target=\"_blank\" style=\"color:var(--accent-blue)\">Stiftung Wissenschaft y Politik (SWP)</a>)</i></small>",
        "influence": "Europa Oriental, Cáucaso, Asia Central, Ártico y espacios estratégicos de Medio Oriente.",
        "strengths": "arsenal nuclear, fuerzas armadas, energía, territorio, recursos naturales, industria militar y capacidad de proyección estratégica.",
        "strategic": "Control de espacios euroasiáticos, rutas energéticas, acceso al Ártico y posición geográfica entre Europa y Asia."
    },
    "India": {
        "tipo_poder": "Potencia regional principal con creciente proyección global.",
        "region_poder": "Asia del Sur e Indo-Pacífico.",
        "long_reason": "India combina población, crecimiento económico, capacidades militares, tecnología, industria y una posición estratégica central en el océano Índico.",
        "influence": "Asia del Sur, océano Índico e Indo-Pacífico.",
        "strengths": "población, economía, tecnología, industria, fuerzas armadas, espacio y diplomacia.",
        "strategic": "Es un actor fundamental para el equilibrio de poder entre China, Estados Unidos y las demás potencias del Indo-Pacífico."
    },
    "Japan": {
        "tipo_poder": "Potencia regional principal y potencia económica-tecnológica del Indo-Pacífico.",
        "region_poder": "Asia Oriental e Indo-Pacífico.",
        "long_reason": "Posee una economía avanzada, tecnología de alto nivel, capacidades industriales, influencia financiera y una importante alianza estratégica con Estados Unidos.",
        "influence": "Japón, Pacífico occidental y Asia Oriental.",
        "strengths": "tecnología, industria, economía, innovación, diplomacia y capacidades de defensa.",
        "strategic": "Su posición frente a China, Corea del Norte, Taiwán y las rutas marítimas del Pacífico occidental le otorga gran importancia estratégica."
    },
    "Brazil": {
        "tipo_poder": "Potencia regional principal de América del Sur.",
        "region_poder": "América del Sur y Atlántico Sur.",
        "long_reason": "Es el Estado con mayor territorio, población y peso económico de Sudamérica y posee una importante capacidad diplomática regional y global.",
        "influence": "América del Sur, Atlántico Sur y espacios multilaterales.",
        "strengths": "territorio, población, agricultura, recursos naturales, energía, industria, mercado interno y diplomacia.",
        "strategic": "Amazonía, Atlántico Sur, alimentos, minerales, energía y liderazgo sudamericano."
    },
    "Mexico": {
        "tipo_poder": "Potencia regional principal de América del Norte y Mesoamérica.",
        "region_poder": "América del Norte, Centroamérica y espacio mesoamericano.",
        "long_reason": "Su economía, población, ubicación junto a Estados Unidos, industria manufacturera y vínculos comerciales le proporcionan una influencia regional considerable.",
        "influence": "América del Norte, Mesoamérica y América Latina.",
        "strengths": "manufactura, comercio, población, energía, ubicación geográfica y vínculos con Estados Unidos.",
        "strategic": "Frontera con Estados Unidos, cadenas de suministro norteamericanas, migración, comercio y conexión entre Norteamérica y América Latina."
    },
    "Germany": {
        "tipo_poder": "Potencia regional principal de Europa con fuerte capacidad económica.",
        "region_poder": "Europa Central y Unión Europea.",
        "long_reason": "Es una de las principales economías europeas y posee enorme peso industrial, comercial y político dentro de la Unión Europea.",
        "influence": "Europa y Unión Europea.",
        "strengths": "industria, exportaciones, tecnología, finanzas, diplomacia y peso institucional europeo.",
        "strategic": "Su posición económica influye directamente en las decisiones y orientaciones estratégicas de Europa."
    },
    "France": {
        "tipo_poder": "Potencia regional principal europea con capacidades globales.",
        "region_poder": "Europa, Mediterráneo, África y territorios franceses de ultramar.",
        "long_reason": "Combina economía, fuerzas armadas, capacidad nuclear, diplomacia, asiento permanente en el Consejo de Seguridad y presencia territorial en distintos océanos.",
        "influence": "Europa, Mediterráneo, África, Indo-Pacífico y territorios de ultramar.",
        "strengths": "capacidad nuclear, fuerzas armadas, diplomacia, industria, tecnología y territorios de ultramar.",
        "strategic": "Su presencia europea, africana e indo-pacífica le permite proyectar influencia más allá del continente europeo."
    },
    "United Kingdom": {
        "tipo_poder": "Potencia regional principal europea con proyección global.",
        "region_poder": "Europa y Atlántico Norte, con proyección Indo-Pacífica.",
        "long_reason": "Posee capacidades militares avanzadas, armas nucleares, una importante red diplomática, servicios financieros y alianzas estratégicas.",
        "influence": "Europa, Atlántico Norte e Indo-Pacífico.",
        "strengths": "defensa, inteligencia, finanzas, diplomacia, tecnología, capacidades navales y armas nucleares.",
        "strategic": "NATO, Atlántico Norte y creciente participación en el Indo-Pacífico."
    },
    "Turkey": {
        "tipo_poder": "Potencia regional principal euroasiática.",
        "region_poder": "Anatolia, Mediterráneo Oriental, Mar Negro, Cáucaso y Medio Oriente.",
        "long_reason": "Su posición geográfica conecta Europa, Asia y Medio Oriente y le proporciona una capacidad estratégica excepcional. <br><small><i>Estudios recientes destacan precisamente el enfoque regional de Türkiye hacia Medio Oriente y los Balcanes. (<a href=\"https://www.swp-berlin.org/10.18449/2026RP08/?utm_source=chatgpt.com\" target=\"_blank\" style=\"color:var(--accent-blue)\">Stiftung Wissenschaft y Politik (SWP)</a>)</i></small>",
        "influence": "Turquía, Mar Negro, Cáucaso, Balcanes, Mediterráneo Oriental y Medio Oriente.",
        "strengths": "fuerzas armadas, industria de defensa, posición geográfica, diplomacia y capacidad de mediación.",
        "strategic": "Estrechos del Bósforo y Dardanelos, acceso a mares estratégicos y pertenencia a NATO."
    },
    "Iran": {
        "tipo_poder": "Potencia regional principal de Medio Oriente.",
        "region_poder": "Golfo Pérsico, Medio Oriente y Asia Occidental.",
        "long_reason": "Su territorio, población, recursos energéticos, capacidades militares y redes políticas regionales le permiten ejercer influencia considerable en Medio Oriente.",
        "influence": "Golfo Pérsico, Irak, Siria, Líbano, Yemen y Asia Occidental.",
        "strengths": "energía, posición geográfica, misiles, capacidades militares, población y redes regionales.",
        "strategic": "Estrecho de Ormuz, energía mundial y posición entre Asia Central, Golfo Pérsico y Medio Oriente."
    },
    "Saudi Arabia": {
        "tipo_poder": "Potencia regional principal del Golfo y Medio Oriente.",
        "region_poder": "Península Arábiga, Golfo Pérsico y mundo árabe.",
        "long_reason": "Su peso energético, económico, financiero y diplomático le permite ejercer una influencia significativa en Medio Oriente.",
        "influence": "Golfo, Península Arábiga, mundo árabe y relaciones con grandes potencias.",
        "strengths": "petróleo, inversión, finanzas, diplomacia, posición geográfica y capacidad económica.",
        "strategic": "Energía mundial, Mar Rojo, Golfo Pérsico y relaciones estratégicas con Estados Unidos, China y otros actores."
    },
    "Israel": {
        "tipo_poder": "Potencia regional principal de Medio Oriente con capacidades tecnológicas y militares avanzadas.",
        "region_poder": "Levante y Mediterráneo Oriental.",
        "long_reason": "Su capacidad militar, tecnológica, de inteligencia y sus alianzas internacionales le proporcionan una influencia estratégica muy superior a su tamaño territorial y demográfico.",
        "influence": "Israel, Levante, Mediterráneo Oriental y seguridad de Medio Oriente.",
        "strengths": "tecnología, defensa, inteligencia, innovación, capacidades militares y alianzas.",
        "strategic": "Mediterráneo Oriental, seguridad regional, tecnología militar y relaciones con Estados Unidos."
    },
    "Egypt": {
        "tipo_poder": "Potencia regional principal del Norte de África y Medio Oriente.",
        "region_poder": "Norte de África, Mediterráneo Oriental y Mar Rojo.",
        "long_reason": "Su población, posición geográfica, fuerzas armadas y control del Canal de Suez le proporcionan un peso estratégico excepcional.",
        "influence": "Norte de África, Mediterráneo Oriental, Mar Rojo y mundo árabe.",
        "strengths": "posición geográfica, población, fuerzas armadas, Canal de Suez y diplomacia.",
        "strategic": "Canal de Suez, conexión entre Mediterráneo y Mar Rojo y rutas comerciales entre Europa y Asia."
    },
    "Indonesia": {
        "tipo_poder": "Potencia regional principal del Sudeste Asiático.",
        "region_poder": "Sudeste Asiático e Indo-Pacífico.",
        "long_reason": "Es el país más poblado del Sudeste Asiático, posee una economía importante y controla una posición geográfica fundamental entre los océanos Índico y Pacífico. <br><small><i>Indonesia es señalada en investigaciones recientes como un actor cuyo poder y objetivos tienen un fuerte componente regional e indo-pacífico. (<a href=\"https://www.swp-berlin.org/10.18449/2026RP08/?utm_source=chatgpt.com\" target=\"_blank\" style=\"color:var(--accent-blue)\">Stiftung Wissenschaft y Politik (SWP)</a>)</i></small>",
        "influence": "ASEAN, Sudeste Asiático, estrechos marítimos e Indo-Pacífico.",
        "strengths": "población, economía, ubicación marítima, recursos naturales y diplomacia.",
        "strategic": "Estrechos de Malaca, Sunda y Lombok; conexión entre los océanos Índico y Pacífico."
    },
    "Australia": {
        "tipo_poder": "Potencia regional principal / potencia media del Indo-Pacífico.",
        "region_poder": "Australia, Pacífico Sur, Sudeste Asiático e Índico.",
        "long_reason": "Aunque no es una superpotencia, Australia posee importantes capacidades económicas, militares, diplomáticas y de defensa, además de una posición estratégica excepcional en el Indo-Pacífico. <br><small><i>Lowy clasifica actualmente a Australia como potencia media en Asia y la sitúa entre los actores regionales más relevantes por sus redes de defensa y su influencia diplomática. (<a href=\"https://power.lowyinstitute.org/countries/australia/?utm_source=chatgpt.com\" target=\"_blank\" style=\"color:var(--accent-blue)\">Lowy Institute Asia Power Index 2025</a>)</i></small>",
        "influence": "Pacífico Sur, Sudeste Asiático, Indo-Pacífico y océano Índico.",
        "strengths": "defensa, alianzas, recursos minerales, economía, diplomacia, territorio marítimo y cooperación de seguridad.",
        "strategic": "AUKUS, alianzas con Estados Unidos y otros socios, rutas marítimas, minerales críticos y seguridad del Pacífico."
    },
    "South Africa": {
        "tipo_poder": "Potencia regional principal del África austral con proyección diplomática continental.",
        "region_poder": "África austral y continente africano.",
        "long_reason": "Posee una de las economías más diversificadas de África, importantes recursos minerales, capacidad industrial y peso diplomático dentro del continente.",
        "influence": "África austral, Unión Africana y espacios multilaterales.",
        "strengths": "minería, industria, economía, infraestructura, diplomacia y posición geográfica.",
        "strategic": "Recursos minerales, rutas marítimas alrededor del Cabo y liderazgo diplomático africano."
    },
    "Nigeria": {
        "tipo_poder": "Potencia regional principal de África Occidental.",
        "region_poder": "África Occidental y Golfo de Guinea.",
        "long_reason": "Su enorme población, economía, recursos energéticos y peso diplomático la convierten en uno de los actores centrales de África Occidental.",
        "influence": "África Occidental, Golfo de Guinea y organismos africanos.",
        "strengths": "población, petróleo y gas, mercado interno, economía, fuerzas armadas y diplomacia regional.",
        "strategic": "Seguridad del Golfo de Guinea, energía, población y estabilidad de África Occidental."
    }
}

with open(html_path, "r", encoding="utf-8") as f:
    content = f.read()

# 1. Clean existing potencia_regional from all countries
content = re.sub(r'potencia_regional:\s*\{[^}]+\},?\s*', '', content)

# 2. Add the new ones
for country, data in potencias_data.items():
    pot_str = f"""potencia_regional: {{
        tipo_poder: \"{data['tipo_poder']}\",
        region_poder: \"{data['region_poder']}\",
        long_reason: '{data['long_reason']}',
        influence: \"{data['influence']}\",
        strengths: \"{data['strengths']}\",
        strategic: \"{data['strategic']}\"
      }},"""
    
    # insert before keywords
    # if the country block doesn't exist, we skip
    pattern = r'("' + country + r'":\s*\{[^}]*?)(keywords:\s*\[)'
    if re.search(pattern, content):
        content = re.sub(pattern, r'\1' + pot_str + r'\n      \2', content, count=1)
    else:
        print(f"Warning: could not find {country} in index_template.html to insert data")

with open(html_path, "w", encoding="utf-8") as f:
    f.write(content)

print("Updated data in index_template.html!")
