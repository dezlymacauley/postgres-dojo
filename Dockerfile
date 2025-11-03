# SECTION: Install Base Image

# This will download the official Postgres Docker image from Docker Hub
# Version 18 of the Postgres database will be used, 
# and the operating system that will be used is Trixie (aka Debian 13.0)
FROM postgres:18.0-trixie

# Create the working directory
RUN mkdir -p /home/postgres-dojo-user

# Set this as both HOME and WORKDIR
ENV HOME=/home/postgres-dojo-user
WORKDIR /home/postgres-dojo-user

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

#______________________________________________________________________________
# SECTION: Load the configuration files

# This will create the following inside a container created from this image:
# A .zshrc file located at: $HOME/.zshrc
# A .config directory locatated: 
RUN mkdir -p ${HOME}/.config && touch ${HOME}/.zshrc

# Copy the `dojo-configs` directory from this repo,
# rename it to `.config`, and then save it to this location 
# inside the container:
# $HOME/.config/
COPY dojo-configs/ ${HOME}/.config/

#______________________________________________________________________________

# This will add the line: 
# "source /home/postgres-dojo-user/.config/.zshrc" 
# to the .zshrc file at the root of the container.

# The reason for the this is because zsh expects a .zshrc file to be in
# $HOME/.zshrc, however I want the `.zshrc` file to be in `$HOME/.config`,
# because when the container is created, a volume is attached to 
# SHOME/.config to ensure that any changes made to the configuration file
# are saved even if the container is deleted.

# So the simplest way to solve this problem is to simply create a .zshrc
# at the root of the container, and then have it load the .zshrc file that
# is located at $HOME/.config
RUN echo "source ${HOME}/.config/.zshrc" > ${HOME}/.zshrc

#______________________________________________________________________________

# Ensure that both /home/postgres-dojo-user/.config (and everything inside it) 
# and /home/postgres-dojo-user/.zshrc are owned by the root user 
# and root group
RUN chown -R root:root ${HOME}/.config ${HOME}/.zshrc

#______________________________________________________________________________
