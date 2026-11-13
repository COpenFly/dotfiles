#!/bin/bash
setsid kitty --session <(cat <<'EOF' ) &
new_tab 手机-ckfbrowser
cd ~/workspace/alpha-chromium_135-mobile/ckfbrowser
launch bash

new_tab 手机-CkfChromium-Build 
cd ~/workspace/alpha-chromium_135-mobile/CkfChromium/src
launch bash

new_tab 手机-CkfChromium-Code
cd ~/workspace/alpha-chromium_135-mobile/CkfChromium/src
launch bash
EOF
