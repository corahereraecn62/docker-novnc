# Base image
FROM tiredofit/novnc:latest

# Environment variables
ENV DISPLAY=:1
ENV PASSWORD=railway

# Install LXDE, xterm, and VNC utilities
RUN apt-get update && apt-get install -y \
    lxde-core lxterminal x11-xserver-utils x11vnc xterm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Cleanup old X server files
RUN rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

# Expose internal VNC port and desired noVNC port
EXPOSE 5900
EXPOSE 5901

# Start X server, LXDE, xterm, VNC, and noVNC
CMD ["sh", "-c", "\
    Xvfb :1 -screen 0 1024x768x16 & \
    startlxde & \
    xterm & \
    x11vnc -display :1 -forever -usepw -shared -rfbport 5900 & \
    websockify 5901 localhost:5900 --web /usr/share/novnc/ \
"]
