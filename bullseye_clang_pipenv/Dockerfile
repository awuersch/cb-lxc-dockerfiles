# DESCRIPTION:	  Run in a default user space with sudo and clang
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo and clang.

FROM rg1.tony.wuersch.name:443/bullseye_clang

LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian" \
	distro_long="debian-bullseye" \
	arch="x86_64" \
	clang_version="6.0"

ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/local/bin/clean-install \
	cython3 \
	pipenv \
	python3-pip \
	python3-setuptools \
	python3-wheel \
	python3-pytest \
	python3-pytest-xdist \
	python3-pytest-cython \
	python3-mock \
	python3-flake8 \
	python3-flake8-docstrings \
	python3-flake8-polyfill \
	python3-certifi \
	python3-requests \
	python3-requests-file \
	python3-requests-futures \
	python3-requests-unixsocket \
	python3-requests-mock \
	python3-gssapi \
	python3-kerberos \
	python3-flask-ldapconn \
	python3-django-oauth-toolkit \
	python3-djangorestframework \
	dh-python

ENV HOME /home/me
WORKDIR $HOME/app
USER me
