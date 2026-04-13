# ── Add 10 new theme options to index.html ──────────────────────
$htmlFile = 'index.html'
$html = Get-Content $htmlFile -Raw -Encoding UTF8

$anchor = '<span class="theme-name">Monokai Pro</span>'

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

if ($html.Contains($anchor)) {
    # Find position right after the closing </div> of the monokai option
    $insertAfter = '<span class="theme-check">✓</span>' + "`r`n            </div>"
    # We need to find the LAST occurrence of this pattern (the monokai one)
    $idx = $html.LastIndexOf($insertAfter)
    if ($idx -ge 0) {
        $insertPos = $idx + $insertAfter.Length
        $html = $html.Substring(0, $insertPos) + $newThemes + $html.Substring($insertPos)
        [System.IO.File]::WriteAllText((Resolve-Path $htmlFile).Path, $html, [System.Text.Encoding]::UTF8)
        Write-Host "SUCCESS: Added 10 themes to $htmlFile"
    } else {
        Write-Host "ERROR: Could not find insert point"
    }
} else {
    Write-Host "ERROR: Anchor not found in $htmlFile"
}

# ── Update THEME_COLORS in script.js ────────────────────────────
$jsFile = 'script.js'
$js = Get-Content $jsFile -Raw -Encoding UTF8

$oldColors = "    'monokai': { matrix: 'rgba(166,226,46,{a})', bg: 'rgba(29,30,26,0.06)' }"
$newColors = "    'monokai': { matrix: 'rgba(166,226,46,{a})', bg: 'rgba(29,30,26,0.06)' },
    'synthwave': { matrix: 'rgba(255,45,159,{a})', bg: 'rgba(15,5,33,0.06)' },
    'hacker': { matrix: 'rgba(0,255,65,{a})', bg: 'rgba(0,8,0,0.06)' },
    'blood-moon': { matrix: 'rgba(255,34,51,{a})', bg: 'rgba(13,0,0,0.06)' },
    'ocean-deep': { matrix: 'rgba(0,180,216,{a})', bg: 'rgba(0,13,26,0.06)' },
    'sunset': { matrix: 'rgba(255,107,53,{a})', bg: 'rgba(13,5,0,0.06)' },
    'mint': { matrix: 'rgba(0,245,212,{a})', bg: 'rgba(0,15,14,0.06)' },
    'neon-violet': { matrix: 'rgba(179,136,255,{a})', bg: 'rgba(6,4,15,0.06)' },
    'amber': { matrix: 'rgba(255,183,0,{a})', bg: 'rgba(13,9,0,0.06)' },
    'cherry': { matrix: 'rgba(255,51,131,{a})', bg: 'rgba(13,0,8,0.06)' },
    'glacier': { matrix: 'rgba(126,200,227,{a})', bg: 'rgba(2,8,16,0.06)' }"

if ($js.Contains($oldColors)) {
    $js = $js.Replace($oldColors, $newColors)
    [System.IO.File]::WriteAllText((Resolve-Path $jsFile).Path, $js, [System.Text.Encoding]::UTF8)
    Write-Host "SUCCESS: Updated THEME_COLORS in $jsFile"
} else {
    Write-Host "ERROR: Could not find THEME_COLORS monokai entry in $jsFile"
    # Show what we're looking for vs what's there
    $lines = $js -split "`n"
    $monoLine = $lines | Where-Object { $_ -match 'monokai' } | Select-Object -First 5
    Write-Host "Found monokai lines: $monoLine"
}
