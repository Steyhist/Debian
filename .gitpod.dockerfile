# Debian Docker Image for Kernel Building
FROM debian:latest

# Non-interactive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Update all packages (use apt for Debian)
RUN apt-get update && apt-get upgrade -y

#Install necessary packages (using apt)
RUN apt-get install -y apt-utils software-properties-common apt-transport-https sudo \
    openssh-server screen python3 git android-tools-adb bc bison \
    build-essential curl flex g++-multilib gcc-multilib gnupg gperf imagemagick libncurses5-dev \
    libreadline-dev zlib1g-dev libssl-dev libxml2 libxml2-utils lzop \
    pngcrush rsync schedtool squashfs-tools xsltproc yasm zip zlib1g-dev \
    libncurses5 tmux ccache zsh neofetch locales locales-all wget shellcheck nano direnv
    
# Create user gitpod (replace 'gitpod' with your desired username)
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /usr/bin/bash -p gitpod gitpod && \
    # passwordless sudo for users in the 'sudo' group
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

# Switch to gitpod User
USER gitpod

# Setup Localtime to Asia/Jakarta
RUN sudo ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Set the locale
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN sudo locale-gen en_US.UTF-8
