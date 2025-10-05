# Base image (from tiredofit, stable + maintained)
FROM dorowu/ubuntu-desktop-lxde-vnc:latest

# Optional: set default environment variables
ENV DISPLAY=:0 \
    DISPLAY_NUM=0 \
    DISPLAY_MODE=auto \
    RESOLUTION=1280x720 \
    VNC_PASSWORD=secret123 \
    NOVNC_LISTEN_PORT=${PORT} \
    ENABLE_CJK_FONT=FALSE \
    DISABLE_DESKTOP=FALSE \
    APP_NAME=xterm

# Clean up stale X11 locks before starting (prevents "already running" crash)
ENTRYPOINT ["/bin/sh", "-c", "rm -f /tmp/.X*-lock /tmp/.X11-unix/* && /entrypoint.sh"]
