# DESCRIPTION:	  Run in a default user space with sudo and clang
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and clang.

FROM rg1.tony.wuersch.name:443/buster_clang

LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian" \
	distro_long="debian-buster" \
	arch="x86_64" \
	clang_version="6.0"

ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/local/bin/clean-install \
	python3-pip \
	python3-setuptools

ENV HOME /home/me
WORKDIR $HOME/app
USER me
RUN pip3 install --user flake8 pipenv cython
