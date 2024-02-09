FROM ghcr.io/void-linux/void-musl-full:20231230r1 as void

RUN \
    xbps-install -Suy xbps && \
    xbps-install -Suy

RUN \
    xbps-install -Sy docker python3 pulseaudio git neovim kitty tmux fish-shell

RUN \
    xbps-install -Sy \
    bash \
    coreutils

RUN \
  useradd \
    -u 1000 -U \
    -d /home/void \
    -s /usr/sbin/fish void
#   usermod -G users void && \
#   echo "void:kasm" | chpasswd && \
#   mkdir -p /home/void && \
#   chown 1000:1000 /home/void && \
#   mkdir -p /var/run/pulse && \
#   chown 1000:root /var/run/pulse && \
#   echo "abc:abc" | chpasswd && \
#   usermod -s /bin/bash abc && \
#   echo 'abc ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/abc && \
#   echo 'void ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/void && \
#   echo "allowed_users=anybody" > /etc/X11/Xwrapper.config


RUN \
    xbps-install -Sy \
    amdvlk \
    base-devel \
    cups \
    cups-pdf \
    docker \
    docker-compose \
    ffmpeg \
    fuse-overlayfs \
    git \
    inetutils \
    intel-media-driver \
    libjpeg-turbo \
    libwebp \
    libxshmfence \
    mesa \
    nginx \
    nodejs \
    openbox \
    openssh \
    pciutils \
    pixman \
    pulseaudio \
    python3 \
    sudo \
    xf86-video-amdgpu \
    xf86-video-ati \
    xf86-video-intel \
    xf86-video-nouveau \
    xf86-video-qxl \
    xkeyboard-config

COPY ./.config /home/void/
COPY ./.local /home/void/
COPY ./scripts /home/void/

EXPOSE 3000