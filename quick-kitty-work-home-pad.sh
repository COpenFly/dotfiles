#!/bin/bash
setsid kitty --session <(cat <<'EOF' ) &
new_tab 平板-ckfbrowser
cd ~/workspace/alpha-chromium_135-pad/ckfbrowser
launch bash

new_tab 平板-CkfChromium-Build 
cd ~/workspace/alpha-chromium_135-pad/CkfChromium-135-alpha/src
launch bash

new_tab 平板-CkfChromium-Code
cd ~/workspace/alpha-chromium_135-pad/CkfChromium-135-alpha/src
launch bash
EOF
