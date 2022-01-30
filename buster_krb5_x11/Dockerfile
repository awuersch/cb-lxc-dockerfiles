# DESCRIPTION:	  Run in a default user space with sudo and krb5 and x11
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and krb5 and x11.

FROM rg1.tony.wuersch.name:443/buster_krb5
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro="debian" distro_long="debian-buster" arch="x86_64" krb5_version="1.16-2"

RUN /usr/local/bin/clean-install \
	libasound2 \
	libpulse0 \
	x11-utils \
	xterm

COPY local.conf /etc/fonts/local.conf
