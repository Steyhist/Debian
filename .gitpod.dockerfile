# CentOS Docker Image
FROM centos/centos:stream8   # Corrected base image tag

# Non-interactive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Update repository configuration to use CentOS Vault mirrors
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Synchronize packages
RUN yum distro-sync -y

# Install necessary packages (using yum, and filtering for CentOS-specific ones)
RUN yum install -y yum-utils epel-release \
    sudo openssh-server screen python3 git android-tools adb bc bison \
    build-essential curl flex gcc gcc-c++ gnupg gperf imagemagick libncurses-devel \
    libreadline-devel zlib-devel lz4-devel libxml2 libxml2-utils lzop \
    pngcrush rsync schedtool squashfs-tools xsltproc yasm zip zlib-devel \
    ncurses tmux ccache zsh neofetch glibc-all-langpacks wget shellcheck nano direnv

# Create user steyhist 
RUN useradd -l -u 33333 -G wheel -md /home/steyhist -s /usr/bin/bash -p steyhist steyhist && \
    # passwordless sudo for users in the 'wheel' group (CentOS uses 'wheel')
    sed -i.bkp -e 's/%wheel\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%wheel ALL=NOPASSWD:ALL/g' /etc/sudoers

# Switch to steyhist User
USER steyhist

# Setup Localtime to Asia/Jakarta
RUN sudo ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Set the locale (adjusting for CentOS)
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN sudo localedef -i en_US -f UTF-8 en_US.UTF-8
