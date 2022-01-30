# DESCRIPTION:	  Run in a default user space with sudo and krb5 and psql and pipenv
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and krb5 and psql and pipenv.

FROM rg1.tony.wuersch.name:443/buster_krb5_pg
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro_style="apt" distro="debian" distro_long="debian-buster" arch="x86_64" krb5_version="1.16-2" postgresql_version="10" operatingsystem="linux"

ENV HOME=/home/me
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
