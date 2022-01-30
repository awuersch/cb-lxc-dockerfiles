# DESCRIPTION:	  Run in a default user space with sudo and krb5
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Stretch with a user "me" with sudo and krb5.

FROM rg1.test.tony.wuersch.name:443/debian_me_sudo
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro="debian" distro_long="debian-stretch" arch="x86_64" krb5_version="1.16-2"

ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/local/bin/clean-install \
	libssl-dev \
        apt-transport-https \
        ca-certificates \
	krb5-config \
	krb5-user \
	libsasl2-modules-gssapi-mit \
	krb5-k5tls \
	krb5-pkinit \
	openssh-client \
	pwgen \
	mosh \
	make
