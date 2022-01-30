# DESCRIPTION:	  Run in a default user space with sudo and clang
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo and clang.

FROM rg1.tony.wuersch.name:443/bullseye_gcc

LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian" \
	distro_long="debian-bullseye" \
	arch="x86_64" \
	clang_version="6.0"

ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/local/bin/clean-install \
	python \
	clang \
 	python-clang \
	&& update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-11 100 \
	&& update-alternatives --install /usr/bin/clang clang /usr/bin/clang-11 100
