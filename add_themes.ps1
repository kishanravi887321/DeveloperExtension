$htmlFile = 'index.html'
$html = [System.IO.File]::ReadAllText((Resolve-Path $htmlFile).Path, [System.Text.Encoding]::UTF8)

# Use a simple unique string as the anchor - data-theme="monokai" closing section
$anchor = 'data-theme="monokai"'
$idx = $html.IndexOf($anchor)
Write-Host "monokai data-theme found at: $idx"

if ($idx -ge 0) {
    # Find the closing </div> of this theme-option (the one right after monokai)
    # We know the pattern: after the last </div> of monokai option, before </div> (panel close)
    # Find "</div>`r`n          </div>" which closes the panel
    $panelClose = "</div>`r`n          </div>"
    $panelIdx = $html.IndexOf($panelClose, $idx)
    Write-Host "Panel close found at: $panelIdx"
    
    if ($panelIdx -ge 0) {
        $newThemes = @"
</div>
            <div class="theme-option" data-theme="synthwave">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#ff2d9f"></div>
                <div class="theme-dot" style="background:#3a86ff"></div>
                <div class="theme-dot" style="background:#ff9f1c"></div>
              </div>
              <span class="theme-name">Synthwave '84</span>
              <span class="theme-check">&#10003;</span>
            </div>
            <div class="theme-option" data-theme="hacker">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#00ff41"></div>
                <div class="theme-dot" style="background:#00cc33"></div>
                <div class="theme-dot" style="background:#66ff88"></div>
              </div>
              <span class="theme-name">Hacker Terminal</span>
              <span class="theme-check">&#10003;</span>
            </div>
            <div class="theme-option" data-theme="blood-moon">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#ff2233"></div>
                <div class="theme-dot" style="background:#cc2255"></div>
                <div class="theme-dot" style="background:#ff6633"></div>
              </div>
              <span class="theme-name">Blood Moon</span>
              <span class="theme-check">&#10003;</span>
            </div>
            <div class="theme-option" data-theme="ocean-deep">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#00b4d8"></div>
                <div class="theme-dot" style="background:#0a9396"></div>
                <div class="theme-dot" style="background:#f4a261"></div>
              </div>
              <span class="theme-name">Ocean Deep</span>
              <span class="theme-check">&#10003;</span>
            </div>
            <div class="theme-option" data-theme="sunset">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#ff6b35"></div>
                <div class="theme-dot" style="background:#f7931e"></div>
                <div class="theme-dot" style="background:#e63972"></div>
              </div>
              <span class="theme-name">Sunset Blaze</span>
              <span class="theme-check">&#10003;</span>
            </div>
            <div class="theme-option" data-theme="mint">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#00f5d4"></div>
                <div class="theme-dot" style="background:#00cccc"></div>
                <div class="theme-dot" style="background:#66ffcc"></div>
              </div>
              <span class="theme-name">Mint Matrix</span>
              <span class="theme-check">&#10003;</span>
            </div>
            <div class="theme-option" data-theme="neon-violet">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#b388ff"></div>
                <div class="theme-dot" style="background:#6c63ff"></div>
                <div class="theme-dot" style="background:#ff6584"></div>
              </div>
              <span class="theme-name">Neon Violet</span>
              <span class="theme-check">&#10003;</span>
            </div>
            <div class="theme-option" data-theme="amber">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#ffb700"></div>
                <div class="theme-dot" style="background:#ffd60a"></div>
                <div class="theme-dot" style="background:#ff6600"></div>
              </div>
              <span class="theme-name">Amber Circuit</span>
              <span class="theme-check">&#10003;</span>
            </div>
            <div class="theme-option" data-theme="cherry">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#ff3383"></div>
                <div class="theme-dot" style="background:#cc44aa"></div>
                <div class="theme-dot" style="background:#ff85a1"></div>
              </div>
              <span class="theme-name">Cherry Blossom</span>
              <span class="theme-check">&#10003;</span>
            </div>
            <div class="theme-option" data-theme="glacier">
              <div class="theme-preview">
                <div class="theme-dot" style="background:#7ec8e3"></div>
                <div class="theme-dot" style="background:#48aadd"></div>
                <div class="theme-dot" style="background:#b0e4f5"></div>
              </div>
              <span class="theme-name">Glacier</span>
              <span class="theme-check">&#10003;</span>
            </div>
          </div>
"@
        # Replace the panel close with new themes + panel close
        $html = $html.Substring(0, $panelIdx) + $newThemes + $html.Substring($panelIdx + $panelClose.Length)
        $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
        [System.IO.File]::WriteAllText((Resolve-Path $htmlFile).Path, $html, $utf8NoBom)
        Write-Host "SUCCESS: Written $((Get-Item $htmlFile).Length) bytes"
    } else {
        Write-Host "ERROR: panel close not found after idx $idx"
        # show context
        $chunk = $html.Substring($idx, [Math]::Min(300, $html.Length - $idx))
        Write-Host ($chunk -replace "`r", '\r' -replace "`n", '\n')
    }
} else {
    Write-Host "ERROR: monokai theme option not found"
}
