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

# And finally the package cache will be cleared 
# to reduce the final image size.
RUN apt-get update \
&& apt-get install -y pgcli \
&& apt-get install -y zsh \
&& apt-get install -y starship \
&& apt-get install -y lsd \
&& apt-get install -y bat \
&& apt-get install -y neovim \
&& rm -rf /var/lib/apt/lists/*

#______________________________________________________________________________

# Set zsh as the default shell
SHELL ["/bin/zsh", "-c"]

#______________________________________________________________________________
