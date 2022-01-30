# DESCRIPTION:	  Run in a default user space with sudo and gcloud
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo and gcloud.

FROM rg1.tony.wuersch.name:443/debian_me_sudo
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro="debian" distro_long="debian-bullseye" arch="x86_64"

ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/local/bin/clean-install \
	apt-transport-https \
	ca-certificates \
	curl \
	lsb-release \
	wget \
	openssh-client \
	git \
	neovim \
	tmux && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
      CLOUD_APT="http://packages.cloud.google.com/apt" \
      SDK_LIST="/etc/apt/sources.list.d/google-cloud-sdk.list" \
      KEY_GPG="https://packages.cloud.google.com/apt/doc/apt-key.gpg" && \
    echo "deb $CLOUD_APT $CLOUD_SDK_REPO main" | tee -a $SDK_LIST && \
    curl $KEY_GPG | apt-key add - && \
    /usr/local/bin/clean-install \
	google-cloud-sdk

ARG USER=me
ARG MEHOME=/home/$USER
RUN echo "\nexport SSH_AUTH_SOCK=/run/user/\$(id -u)/ssh-agent.socket" >> $MEHOME/.bashrc
