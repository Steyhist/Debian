# Rocky Linux Docker Image
FROM rockylinux/rockylinux:8

# Non-interactive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Update all packages (use dnf for Rocky Linux)
RUN dnf -y update

# Install necessary packages (using dnf)
RUN dnf install -y dnf-utils epel-release \
    sudo openssh-server screen python3 git android-tools adb bc bison \
    build-essential curl flex gcc gcc-c++ gnupg gperf imagemagick libncurses-devel \
    libreadline-devel zlib-devel lz4-devel libxml2 libxml2-utils lzop \
    pngcrush rsync schedtool squashfs-tools xsltproc yasm zip zlib-devel \
    ncurses tmux ccache zsh neofetch glibc-all-langpacks wget shellcheck nano direnv

# Create user steyhist 
RUN useradd -l -u 33333 -G wheel -md /home/steyhist -s /usr/bin/bash -p steyhist steyhist && \
    # passwordless sudo for users in the 'wheel' group (Rocky Linux uses 'wheel')
    sed -i.bkp -e 's/%wheel\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%wheel ALL=NOPASSWD:ALL/g' /etc/sudoers

# Switch to steyhist User
USER steyhist

# Setup Localtime to Asia/Jakarta
RUN sudo ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Set the locale (adjusting for Rocky Linux)
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN sudo localedef -i en_US -f UTF-8 en_US.UTF-8
