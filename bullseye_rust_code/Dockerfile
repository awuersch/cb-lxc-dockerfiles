# DESCRIPTION:	  Run in a default user space with sudo, rust and vscode.
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo, rust and vscode.

FROM rg1.tony.wuersch.name:443/bullseye_rust
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro_style="apt" distro="debian" distro_long="debian-10" arch="x86_64" vscode_version="vscode-insiders" operatingsystem="linux"

ARG DEBIAN_FRONTEND=noninteractive
USER root
COPY start.sh /usr/local/bin/start.sh
COPY get_vscode_extensions.sh /usr/local/bin/get_vscode_extensions.sh

# Add the vscode debian repo
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor \
  | apt-key add -
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

RUN /usr/local/bin/clean-install \
    code-insiders \
    libasound2 \
    libatk1.0-0 \
    libcairo2 \
    libcups2 \
    libexpat1 \
    libfontconfig1 \
    libfreetype6 \
    libgtk2.0-0 \
    libpango-1.0-0 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6
