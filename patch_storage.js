const fs = require('fs');

const path = 'd:\\WeBDevelopment\\Extensions\\tabExtension\\new-tab-extension\\script.js';
let content = fs.readFileSync(path, 'utf8');

if (!content.includes('safeSetItem')) {
    content = content.replace("'use strict';", "'use strict';\n\nfunction safeSetItem(key, val) {\n    try {\n        localStorage.setItem(key, val);\n    } catch(e) {\n        console.warn('localStorage full:', e);\n    }\n}");
}

content = content.replace(/localStorage\.setItem\(([^,]+),\s*(.+?)\)/g, 'safeSetItem($1, $2)');

fs.writeFileSync(path, content, 'utf8');
console.log('Patched setItem');
