$json = Get-Content "potencias.json" -Encoding UTF8 | ConvertFrom-Json
$html = Get-Content "src\index_template.html" -Encoding UTF8 -Raw

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
"@
    
    # regex match the country block up to the end of potencia_regional: { ... },
    # taking into account whitespace
    $pattern = '(?s)("' + $name + '": \{.*?)potencia_regional:\s*\{[^}]*\},'
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, $pattern, "`$1" + $replacement)
}

[System.IO.File]::WriteAllText("src\index_template.html", $html, [System.Text.Encoding]::UTF8)
Write-Output "Fixed texts!"
