import os
import re

html_content = open("index.html", "r", encoding="utf-8").read()

os.makedirs("src", exist_ok=True)
os.makedirs("lib", exist_ok=True)

# Extract world-data
world_match = re.search(r'<script>\s*(const WORLD_TOPO_DATA = .*?)\s*</script>', html_content, re.DOTALL)
if world_match:
    open("lib/world-data.js", "w", encoding="utf-8").write(world_match.group(1))

# Extract GEO_DB
geo_match = re.search(r'(const GEO_DB = \{.*?\n    }\n  \};\n)', html_content, re.DOTALL)
if geo_match:
    open("src/geo-db.js", "w", encoding="utf-8").write(geo_match.group(1))

# Create template
template = re.sub(r'<script>\s*const WORLD_TOPO_DATA = .*?\s*</script>', '<!-- WORLD_DATA -->', html_content, flags=re.DOTALL)
template = re.sub(r'const GEO_DB = \{.*?\n    }\n  \};\n', '<!-- GEO_DB -->\n', template, flags=re.DOTALL)

open("src/index_template.html", "w", encoding="utf-8").write(template)
print("Setup complete.")
