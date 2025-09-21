#!/bin/sh
## https://github.com/create-dmg/create-dmg

create-dmg \
--volname "PromptBolt" \
--icon-size 128 \
--text-size 16 \
--icon "PromptBolt.app" 150 150 \
--app-drop-link 480 150 \
--window-pos 200 200 \
--window-size 650 376 \
--background bin/dmg_background.png \
$1/PromptBolt.dmg $1
