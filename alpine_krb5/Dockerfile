# DESCRIPTION:	  Run in a default user space with sudo and krb5
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Alpine latest with a user "me" with sudo and krb5.
#	Note: Alpine ssh client is not compiled with gssapi libraries.

FROM rg1.test.tony.wuersch.name:443/alpine_me_sudo
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro_style="apk" distro="alpine" distro_long="alpine-latest" arch="x86_64" krb5_version="1.15.2-r2" operatingsystem="linux"

RUN apk update && apk --no-cache add \
	krb5 \
	krb5-pkinit \
	krb5-libs
