# SECTION: Install Base Image

# This will download the official Postgres Docker image from Docker Hub
# Version 18 of the Postgres database will be used, 
# and the operating system that will be used is Trixie (aka Debian 13.0)
FROM postgres:18.0-trixie

#______________________________________________________________________________
# SECTION: Install CLI tools

# This will update apt (the Debian package manager),
# so that it knows about the latest packages available 
# in the Debian repository

# Install zsh and set it as the default shell

# Install `starship`, `lsd`, and `bat`,
# for a smooth user experience when browsing the container file system.

# Install neovim for editing configuration files in the container. 

# Install `pgcli` for a better user experience when interacting
# with the Postgres Engine.

# And finally the package cache will be cleared 
# to reduce the final image size.
RUN apt-get update \
&& apt-get install -y zsh \
&& apt-get install -y zsh-autosuggestions \
&& apt-get install -y zsh-syntax-highlighting \
&& chsh -s /bin/zsh $(whoami) \
&& apt-get install -y starship \
&& apt-get install -y lsd \
&& apt-get install -y bat \
&& apt-get install -y neovim \
&& apt-get install -y pgcli \
&& rm -rf /var/lib/apt/lists/*

# NOTE: The command for neovim is nvim

# NOTE: The command for bat on Debian systems is `batcat`

#______________________________________________________________________________
# SECTION: Set the value of the environment variables inside the container

# Sets the SHELL used
ENV SHELL=/usr/bin/zsh

# Sets the HOME directory
ENV HOME=/root

#______________________________________________________________________________
# SECTION: Loade the configuration files

# Create directory called `.config` at the `HOME` directory of the container
RUN mkdir -p ${HOME}/.config

# Copy the `dojo-configs` directory from this repo,
# and save it in the `HOME` directory of the container as `.config`
COPY dojo-configs/ ${HOME}/.config/

# Create a minimal .zshrc that sources .config/.zshrc
RUN echo "source ${HOME}/.config/.zshrc" > ${HOME}/.zshrc

# Ensure correct ownership (root owns everything)
RUN chown -R root:root ${HOME}/.config ${HOME}/.zshrc

#______________________________________________________________________________
