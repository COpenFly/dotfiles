#!/bin/bash
# 快速打开终端工作目录

gnome-terminal \
  --tab --title="平板-ckfbrowser" -- bash -c "cd ~/workspace/alpha-chromium_135-pad/ckfbrowser; exec bash"
gnome-terminal \
  --tab --title="平板-CkfChromium-Build" -- bash -c "cd ~/workspace/alpha-chromium_135-pad/CkfChromium-135-alpha/src; exec bash"
gnome-terminal \
  --tab --title="平板-CkfChromium-Code" -- bash -c "cd ~/workspace/alpha-chromium_135-pad/CkfChromium-135-alpha/src; exec bash"

# 自定义当前终端标签页title
# printf '\033]0;自定义名称\007'
