# DESCRIPTION:	  Run in a default user space with sudo
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Ubuntu Bionic with a user "me" with sudo and clang.

FROM rg1.tony.wuersch.name:443/bionic_gcc

LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="ubuntu" \
	distro_long="ubuntu-bionic" \
	arch="x86_64" \
	clang_version="6.0"

RUN apt-get update && apt-get install -y \
	llvm-6.0-dev \
	python \
	clang-6.0 \
 	python-clang-6.0 \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 100 \
	&& update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 100
