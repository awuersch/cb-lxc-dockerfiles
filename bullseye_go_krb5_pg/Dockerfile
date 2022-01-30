# DESCRIPTION:	  Run in a default user space with sudo and krb5
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo and go and krb5 and psql.

FROM rg1.tony.wuersch.name:443/bullseye_go_krb5
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro_style="apt" distro="debian" distro_long="debian-bullseye" krb5_version="1.16-2" postgresql_version="10"

ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/local/bin/clean-install \
	git \
	postgresql-client-13

ARG USER=me
ARG MEHOME=/home/$USER
RUN echo "\nexport SSH_AUTH_SOCK=/run/user/\$(id -u)/ssh-agent.socket" >> $MEHOME/.bashrc
