# DESCRIPTION:	  Run in a default user space with sudo
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and gcc.

FROM rg1.test.tony.wuersch.name:443/buster_me_sudo

LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian"\
	distro_long="debian-buster"

ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/local/bin/clean-install \
	xz-utils \
	lzma-dev \
	gzip \
	libssl-dev \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	build-essential \
	software-properties-common \
	git \
	&& update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8
