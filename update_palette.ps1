$htmlPath = "src\index_template.html"
$html = Get-Content $htmlPath -Encoding UTF8 -Raw

# Replace tooltip styling
$html = $html.Replace("relEl.style.background = 'rgba(147, 51, 234, 0.1)';", "relEl.style.background = 'rgba(234, 179, 8, 0.15)';")
$html = $html.Replace("relEl.style.color = '#c084fc';", "relEl.style.color = '#fde047';")

# Replace info panel badge styling
$html = $html.Replace("badge.style.background = 'rgba(147, 51, 234, 0.1)';", "badge.style.background = 'rgba(234, 179, 8, 0.15)';")
$html = $html.Replace("badge.style.color = '#c084fc';", "badge.style.color = '#fde047';")
$html = $html.Replace("badge.style.border = '1px solid rgba(147, 51, 234, 0.3)';", "badge.style.border = '1px solid rgba(234, 179, 8, 0.3)';")

# Replace map logic (applyCategory)
$html = $html.Replace("el.style('fill', '#4f46e5').style('opacity', 1);", "el.style('fill', '#d97706').style('opacity', 1);")
$html = $html.Replace("el.style('fill', '#9333ea').style('opacity', 1);", "el.style('fill', '#eab308').style('opacity', 1);")

# Replace legend (updateLegend)
$html = $html.Replace('style="background:#4f46e5"', 'style="background:#d97706"')
$html = $html.Replace('style="background:#9333ea"', 'style="background:#eab308"')

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "Palette updated perfectly!"
