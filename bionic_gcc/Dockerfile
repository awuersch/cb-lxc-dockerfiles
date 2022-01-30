# DESCRIPTION:	  Run in a default user space with sudo
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Ubuntu Bionic with a user "me" with sudo and gcc.

FROM rg1.test.tony.wuersch.name:443/bionic_me_sudo

LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="ubuntu"\
	distro_long="ubuntu-bionic"

RUN apt-get update && apt-get install -y \
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
	g++-8 \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 \
	&& update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
