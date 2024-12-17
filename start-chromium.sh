#!/bin/sh

# default URL
URL="http://localhost:9002"

chromium_base_params="--allow-insecure-localhost \
                      --disable-notifications \
                      --disable-gpu \
                      --disable-software-rasterizer \
                      --check-for-update-interval=315360000 \
                      --no-sandbox \
                      --test-type \
                      --disable-features=UseOzonePlatform \
		                  --in-process-gpu \
		                  --disable-gpu-compositing \
                      --window-size=1920,1080
                      "

chromium_mode_params="--kiosk "

chromium_extended_params=""

for arg in "$@"; do
  case $arg in
    --window-mode)
      chromium_mode_params="--start-maximized --app="
      shift
      ;;
    --browser-mode)
      chromium_mode_params="--start-maximized "
      shift
      ;;
    --virtual-keyboard)
      # Load the virtual keyboard
      chromium_extended_params="$chromium_extended_params --load-extension=/chrome-extensions/chrome-virtual-keyboard-master"
      shift
      ;;
    --*)
      chromium_extended_params="$chromium_extended_params $1"
      shift
      ;;
    *)
      URL=$1
      shift
      ;;
  esac
done

# Don't double quote, otherwise expanded arguments end up with `'`
# shellcheck disable=SC2086
chromium $chromium_base_params $chromium_extended_params $chromium_mode_params $URL
