# DESCRIPTION:	  Run in a default user space with sudo and krb5
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and texlive and vscode.

FROM rg1.test.tony.wuersch.name:443/buster_tl
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian" \
	distro_long="debian-buster" \
	vscode_version="vscode-insiders"

ARG DEBIAN_FRONTEND=noninteractive
COPY start.sh /usr/local/bin/start.sh
COPY get_vscode_extensions.sh /usr/local/bin/get_vscode_extensions.sh

# Add the vscode debian repo
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor \
  | apt-key add -
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

RUN /usr/local/bin/clean-install \
    code-insiders \
    git \
    neovim \
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
