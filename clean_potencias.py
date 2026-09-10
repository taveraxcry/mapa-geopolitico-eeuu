import json
import re

html_path = "src/index_template.html"
json_path = "potencias.json"

with open(json_path, "r", encoding="utf-8") as f:
    potencias = json.load(f)

with open(html_path, "r", encoding="utf-8") as f:
    content = f.read()

# Remove all existing potencia_regional blocks
# the block starts with potencia_regional: { and ends with },
# we use non-greedy match. We need to handle potential whitespace.
# It's possible there are multiple blocks due to duplication.
content = re.sub(r'potencia_regional:\s*\{[^}]+\},\s*', '', content)

# Also remove any remaining dangling potencia_regional blocks without trailing comma
content = re.sub(r'potencia_regional:\s*\{[^}]+\}\s*', '', content)

# Now, iterate over the countries in potencias and insert the new block before keywords:
for country, data in potencias.items():
    pot_str = f"""potencia_regional: {{
        reason: \"{data['reason']}\",
        long_reason: \"{data['long_reason']}\",
        influence: \"{data['influence']}\",
        strengths: \"{data['strengths']}\",
        strategic: \"{data['strategic']}\"
      }},"""
    
    # regex to find the country block and insert before keywords
    # Ex: "Mexico": { ... keywords: [ ... ]
    pattern = r'("' + country + r'":\s*\{[^}]*?)(keywords:\s*\[)'
    content = re.sub(pattern, r'\1' + pot_str + r'\n      \2', content, count=1)

with open(html_path, "w", encoding="utf-8") as f:
    f.write(content)

print("Cleaned up and injected potencias into index_template.html!")
