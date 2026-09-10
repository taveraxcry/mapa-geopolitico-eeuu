$template = Get-Content -Raw "src\index_template.html" -Encoding UTF8
$worldData = Get-Content -Raw "lib\world-data.js" -Encoding UTF8
$d3 = Get-Content -Raw "d3.v7.min.js" -Encoding UTF8
$topo = Get-Content -Raw "topojson-client.min.js" -Encoding UTF8

$output = $template.Replace("<!-- WORLD_DATA -->", "<script>`n" + $worldData + "`n</script>")
$output = $output.Replace('<script src="https://d3js.org/d3.v7.min.js"></script>', "<script>`n" + $d3 + "`n</script>")
$output = $output.Replace('<script src="https://unpkg.com/topojson-client@3"></script>', "<script>`n" + $topo + "`n</script>")

[System.IO.File]::WriteAllText("index.html", $output, [System.Text.Encoding]::UTF8)
Write-Output "Build complete."