$json = Get-Content "potencias.json" -Encoding UTF8 | ConvertFrom-Json
$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

# 1. Remove all existing potencia_regional blocks to clean up duplicates
$html = [System.Text.RegularExpressions.Regex]::Replace($html, 'potencia_regional:\s*\{[^}]+\},?\s*', '')

# 2. Iterate and add them properly
foreach ($country in $json.psobject.properties) {
    $name = $country.Name
    $data = $country.Value
    
    $replacement = @"
      potencia_regional: {
        reason: "$($data.reason)",
        long_reason: "$($data.long_reason)",
        influence: "$($data.influence)",
        strengths: "$($data.strengths)",
        strategic: "$($data.strategic)"
      },
      keywords:
"@
    
    # Regex to find where to insert. We look for "CountryName": { ... keywords:
    $pattern = '(?s)("' + $name + '": \{.*?)\s*keywords:'
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, $pattern, "`$1`n" + $replacement)
}

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "Cleaned and Updated successfully!"
