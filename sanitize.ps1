$jsonPath = "new_potencias.json"
$json = Get-Content $jsonPath -Encoding UTF8 -Raw

$json = $json -replace 'lazos inquebrantables', 'lazos estrechos y estructurales'
$json = $json -replace 'indiscutible liderazgo', 'liderazgo estructural'
$json = $json -replace 'alianza inquebrantable', 'alianza estratgica prioritaria'
$json = $json -replace 'control exclusivo', 'soberana y control administrativo'
$json = $json -replace '\(indiscutible\)', '(rea de influencia primaria)'
$json = $json -replace 'indiscutible liderazgo hegemnico', 'liderazgo poltico y de seguridad'

[System.IO.File]::WriteAllText($jsonPath, $json, [System.Text.Encoding]::UTF8)
Write-Output "JSON sanitized!"
