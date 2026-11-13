#!/bin/bash
# 快速打开终端工作目录

gnome-terminal \
  --tab --title="手机-ckfbrowser" -- bash -c "cd ~/workspace/alpha-chromium_135-mobile/ckfbrowser; exec bash"
gnome-terminal \
  --tab --title="手机-CkfChromium" -- bash -c "cd ~/workspace/alpha-chromium_135-mobile/CkfChromium/src; exec bash"

# 自定义当前终端标签页title
# printf '\033]0;自定义名称\007'
