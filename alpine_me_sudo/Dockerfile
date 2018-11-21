# DESCRIPTION:	  Run in a default user space with sudo
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Alpine edge with a user "me" with sudo.

# cf: use of addgroup and adduser
# https://gist.github.com/briceburg/47131d8caf235334b6114954a6e64922

FROM alpine:edge
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian"\
	distro_long="debian-alpine"

# UID, GID, UNAME, GNAME need definition if
#   1) there are multiple users or
#   2) the host running the container already has (UID,GID)==(1000,1000) taken.

ENV UID="1000" \
	UNAME="me" \
	GID="1000" \
	GNAME="me" \
	SHELL="/bin/bash" \
	UBASE=/home

RUN apk update && apk add sudo bash
RUN echo "$UNAME ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/$UNAME ; \
	addgroup -g $GID $GNAME ; \
	adduser -u $UID -D -s $SHELL -G $GNAME $UNAME && exit 0 ; exit 1
