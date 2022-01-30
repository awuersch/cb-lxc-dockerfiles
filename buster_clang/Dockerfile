# DESCRIPTION:	  Run in a default user space with sudo and clang
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and clang.

FROM rg1.test.tony.wuersch.name:443/buster_gcc

LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian" \
	distro_long="debian-buster" \
	arch="x86_64" \
	clang_version="6.0"

ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/local/bin/clean-install \
	llvm-6.0-dev \
	python \
	clang-6.0 \
 	python-clang-6.0 \
	&& update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 100 \
	&& update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 100
