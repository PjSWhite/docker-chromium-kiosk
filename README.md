# 



## How to run the container

Simple command with docker run: 
```bash
docker run --rm \
    --name=chromium \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /var/run/dbus:/var/run/dbus \
    --device /dev/dri:/dev/dri \
    --shm-size=256mb \
    ghcr.io/vdovhanych/chromium-kiosk:latest \
    --window-mode --virtual-keyboard https://url-to-open.com
```

Using docker compose:
```yaml
services:
  chromium:
    image: ghcr.io/vdovhanych/chromium-kiosk:latest
    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix:ro
      - /var/run/dbus:/var/run/dbus
    devices:
      - /dev/dri:/dev/dri
    shm_size: 256mb
    command: >-
      --window-mode
      --virtual-keyboard
      https://url-to-open.com
```
Its possible to change what display to use by setting `DISPLAY` environment variable. For example, to use display `:1`:

```bash
docker run --rm \
    --name=chromium \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /var/run/dbus:/var/run/dbus \
    --device /dev/dri:/dev/dri \
    --shm-size=256mb \
    -e DISPLAY=:1 \
    ghcr.io/vdovhanych/chromium-kiosk:latest \
    --window-mode --virtual-keyboard https://url-to-open.com
```