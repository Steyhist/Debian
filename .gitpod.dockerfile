# Fedora Docker Image for Kernel Building
FROM fedora:latest

# Non-interactive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Update all packages (use dnf for Fedora)
RUN dnf -y update

# Install necessary packages (using dnf)
RUN dnf install -y dnf-plugins-core 
RUN dnf config-manager --set-enabled powertools 
RUN dnf install -y @development-tools elfutils-libelf-devel openssl-devel bc git dwarves \
    sudo openssh-server screen python3 \
    make automake gcc gcc-c++ kernel-devel curl flex gnupg gperf ImageMagick \
    readline-devel zlib-devel libxml2 libxml2-utils lzop \
    pngcrush rsync schedtool squashfs-tools xsltproc yasm zip zlib-devel \
    ncurses tmux ccache zsh neofetch glibc-langpack-en wget shellcheck nano direnv
# Coba pasang android-tools atau android-platform-tools, lihat mana yang tersedia
RUN dnf search android-tools || dnf search android-platform-tools

# Create user steyhist 
RUN useradd -l -u 33333 -G wheel -md /home/steyhist -s /usr/bin/bash -p steyhist steyhist && \
    # passwordless sudo for users in the 'wheel' group (Fedora uses 'wheel')
    sed -i.bkp -e 's/%wheel\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%wheel ALL=NOPASSWD:ALL/g' /etc/sudoers

# Switch to steyhist User
USER steyhist

# Setup Localtime to Asia/Jakarta
RUN sudo ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Set the locale (adjusting for Fedora)
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN sudo localedef -i en_US -f UTF-8 en_US.UTF-8
