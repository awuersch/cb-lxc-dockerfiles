# DESCRIPTION:	  Run ldap utils or slapd in a default user space with sudo
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo, ldap utils, and slapd

FROM rg1.tony.wuersch.name:443/bullseye_me_sudo
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro="debian" distro_long="debian-bullseye" arch="x86_64"
#
# How to start the container:
#
# docker run -v /data/ldap:/var/lib/ldap \
# 	--network my-bridge \
# 	--env LDAP_DOMAIN=authy.auth.co \
# 	--env LDAP_ORGANISATION="E Corp" \
# 	--env LDAP_ROOTPASS=fsociety \
# 	--detach $REGISTRY/bullseye_slapd
#
# - `LDAP_DOMAIN` sets the LDAP root domain. (e.g. if you provide `foo.bar.com`
# 	here, the root of your directory will be `dc=foo,dc=bar,dc=com`)
# - `LDAP_ORGANIZATION` sets the human-readable name for your organization (e.g.
# 	`Acme Widgets Inc.`)
# - `LDAP_ROOTPASS` sets the LDAP admin user password (i.e. the password for
# 	`cn=admin,dc=example,dc=com` if your domain was `example.com`)
#
# You can load an LDIF file (to set up your directory) like so:
#
# docker exec -it your_container ldapadd \
# 	-h localhost -p <host_port_of_container> -c -x \
# 	-D cn=admin,dc=mycorp,dc=com -W -f data.ldif
#

ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/local/bin/clean-install \
	procps \
	psmisc \
	bash-completion \
        libssl-dev \
        apt-transport-https \
        ca-certificates \
        krb5-config \
        krb5-user \
        libsasl2-modules-gssapi-mit \
	slapd \
	ldap-utils
COPY kerberos.schema /etc/ldap/schema/kerberos.schema
COPY kerberos.ldif /etc/ldap/schema/kerberos.ldif
COPY start.sh /start.sh
COPY empty.sh /empty.sh

ENTRYPOINT [ "/start.sh" ]
