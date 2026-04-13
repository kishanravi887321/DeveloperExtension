# Fix HTML: insert 10 themes after the monokai theme-option closing div
$htmlFile = 'index.html'
$html = Get-Content $htmlFile -Raw -Encoding UTF8

# Use a unique anchor - the span+div combo only appears once for monokai
$anchor = '<span class="theme-name">Monokai Pro</span>' + "`r`n              " + '<span class="theme-check">✓</span>' + "`r`n            </div>"

if (-not $html.Contains($anchor)) {
    # Try without \r
    $anchor = '<span class="theme-name">Monokai Pro</span>' + "`n              " + '<span class="theme-check">✓</span>' + "`n            </div>"
    Write-Host "Trying LF-only anchor"
}

if ($html.Contains($anchor)) {
    $newThemes = @'

            <div class="theme-option" data-theme="synthwave">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#ff2d9f"></div>
                <div class="theme-dot" style="background:#3a86ff"></div>
                <div class="theme-dot" style="background:#ff9f1c"></div>
              </div>
              <span class="theme-name">Synthwave '84</span>
              <span class="theme-check">✓</span>
            </div>
            <div class="theme-option" data-theme="hacker">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#00ff41"></div>
                <div class="theme-dot" style="background:#00cc33"></div>
                <div class="theme-dot" style="background:#66ff88"></div>
              </div>
              <span class="theme-name">Hacker Terminal</span>
              <span class="theme-check">✓</span>
            </div>
            <div class="theme-option" data-theme="blood-moon">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#ff2233"></div>
                <div class="theme-dot" style="background:#cc2255"></div>
                <div class="theme-dot" style="background:#ff6633"></div>
              </div>
              <span class="theme-name">Blood Moon</span>
              <span class="theme-check">✓</span>
            </div>
            <div class="theme-option" data-theme="ocean-deep">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#00b4d8"></div>
                <div class="theme-dot" style="background:#0a9396"></div>
                <div class="theme-dot" style="background:#f4a261"></div>
              </div>
              <span class="theme-name">Ocean Deep</span>
              <span class="theme-check">✓</span>
            </div>
            <div class="theme-option" data-theme="sunset">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#ff6b35"></div>
                <div class="theme-dot" style="background:#f7931e"></div>
                <div class="theme-dot" style="background:#e63972"></div>
              </div>
              <span class="theme-name">Sunset Blaze</span>
              <span class="theme-check">✓</span>
            </div>
            <div class="theme-option" data-theme="mint">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#00f5d4"></div>
                <div class="theme-dot" style="background:#00cccc"></div>
                <div class="theme-dot" style="background:#66ffcc"></div>
              </div>
              <span class="theme-name">Mint Matrix</span>
              <span class="theme-check">✓</span>
            </div>
            <div class="theme-option" data-theme="neon-violet">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#b388ff"></div>
                <div class="theme-dot" style="background:#6c63ff"></div>
                <div class="theme-dot" style="background:#ff6584"></div>
              </div>
              <span class="theme-name">Neon Violet</span>
              <span class="theme-check">✓</span>
            </div>
            <div class="theme-option" data-theme="amber">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#ffb700"></div>
                <div class="theme-dot" style="background:#ffd60a"></div>
                <div class="theme-dot" style="background:#ff6600"></div>
              </div>
              <span class="theme-name">Amber Circuit</span>
              <span class="theme-check">✓</span>
            </div>
            <div class="theme-option" data-theme="cherry">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#ff3383"></div>
                <div class="theme-dot" style="background:#cc44aa"></div>
                <div class="theme-dot" style="background:#ff85a1"></div>
              </div>
              <span class="theme-name">Cherry Blossom</span>
              <span class="theme-check">✓</span>
            </div>
            <div class="theme-option" data-theme="glacier">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#7ec8e3"></div>
                <div class="theme-dot" style="background:#48aadd"></div>
                <div class="theme-dot" style="background:#b0e4f5"></div>
              </div>
              <span class="theme-name">Glacier</span>
              <span class="theme-check">✓</span>
            </div>
'@
    $html = $html.Replace($anchor, $anchor + $newThemes)
    [System.IO.File]::WriteAllText((Resolve-Path $htmlFile).Path, $html, [System.Text.UTF8Encoding]::new($false))
    Write-Host "SUCCESS: Added 10 themes to index.html"
} else {
    # Debug: show what's near Monokai Pro
    $idx = $html.IndexOf('Monokai Pro')
    Write-Host "Monokai Pro found at index: $idx"
    Write-Host "Context around it:"
    Write-Host ($html.Substring([Math]::Max(0,$idx-30), 200) | ForEach-Object { $_ -replace "`r", '\r' -replace "`n", '\n' })
}
