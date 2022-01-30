# DESCRIPTION:	  Run in a default user space with sudo
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and powershell.

FROM rg1.tony.wuersch.name:443/bionic_me_sudo

ARG DISTRO=ubuntu
ARG VERSION=bionic
ARG APT_LISTS=/var/lib/apt/lists

LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="$DISTRO"\
	distro_long="$DISTRO-$VERSION"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
	curl \
	gnupg \
	apt-transport-https \
	ca-certificates \
	liblttng-ust-ctl4 \
	liblttng-ust0 \
	libunwind8 \
	liburcu6 \
	wget \
	--no-install-recommends \
	&& apt-get install -f \
	&& rm -rf $APT_LISTS/*

ARG MS_URL=https://packages.microsoft.com/config/ubuntu/18.04

RUN wget -q $MS_URL/packages-microsoft-prod.deb \
	&& dpkg -i packages-microsoft-prod.deb \
	&& apt-get update \
	&& apt-get install -y powershell --no-install-recommends \
	&& apt-get install -f \
	&& rm -rf $APT_LISTS/*

ENTRYPOINT [ "pwsh" ]
