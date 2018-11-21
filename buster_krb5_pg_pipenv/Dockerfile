# DESCRIPTION:	  Run in a default user space with sudo and krb5 and psql and pipenv
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and krb5 and psql and pipenv.

FROM rg1.tony.wuersch.name:443/buster_krb5_pg
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro_style="apt" distro="debian" distro_long="debian-buster" arch="x86_64" krb5_version="1.16-2" postgresql_version="10" operatingsystem="linux"

ENV HOME=/home/me
ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/local/bin/clean-install \
	python3-pip \
	python3-setuptools
