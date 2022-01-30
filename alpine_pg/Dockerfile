# DESCRIPTION:	  Run in a default user space with sudo and psql.
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Note: Alpine psql does not support GSSAPI.

FROM rg1.test.tony.wuersch.name:443/alpine_me_sudo
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro_style="apk" distro="alpine" distro_long="alpine-latest" postgresql_version="11.1-r0"

RUN apk update && apk add --no-cache postgresql-client postgresql-dev
