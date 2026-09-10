$htmlPath = "src\index_template.html"
$jsonPath = "new_potencias.json"

$html = Get-Content $htmlPath -Encoding UTF8 -Raw
$potenciasObj = Get-Content $jsonPath -Encoding UTF8 -Raw | ConvertFrom-Json

foreach ($prop in $potenciasObj.psobject.properties) {
    $country = $prop.Name
    $data = $prop.Value
    
    $tipo = ($data.tipo_poder | ConvertTo-Json -Compress)
    $region = ($data.region_poder | ConvertTo-Json -Compress)
    $reason = ($data.long_reason | ConvertTo-Json -Compress)
    $influence = ($data.influence | ConvertTo-Json -Compress)
    $strengths = ($data.strengths | ConvertTo-Json -Compress)
    $strategic = ($data.strategic | ConvertTo-Json -Compress)
    
    $replacement = @"
      potencia_regional: {
        tipo_poder: $tipo,
        region_poder: $region,
        long_reason: $reason,
        influence: $influence,
        strengths: $strengths,
        strategic: $strategic
      },
      keywords:
"@
    
    $pattern = '(?s)("' + $country + '": \{.*?)\s*potencia_regional:\s*\{.*?\},?\s*keywords:'
    
    if ($html -match $pattern) {
        $html = [System.Text.RegularExpressions.Regex]::Replace($html, $pattern, "`$1`n" + $replacement)
    } else {
        $pattern2 = '(?s)("' + $country + '": \{.*?)\s*keywords:'
        if ($html -match $pattern2) {
            $html = [System.Text.RegularExpressions.Regex]::Replace($html, $pattern2, "`$1`n" + $replacement)
        }
    }
}

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "Injected clean JSON with correct encoding!"
