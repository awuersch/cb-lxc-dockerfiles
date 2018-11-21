# DESCRIPTION:	  Run in a default user space with sudo
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Ubuntu Bionic with a user "me" with sudo.

FROM haskell:latest
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>"

# UID, GID, UNAME, GNAME need definition if
#   1) there are multiple users or
#   2) the host running the container already has (UID,GID)==(1000,1000) taken.

ENV UID="1000" \
	UNAME="me" \
	GID="1000" \
	GNAME="me" \
	SHELL="/bin/bash" \
	UBASE=/home

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
	apt-utils \
	perl \
	dialog \
	&& apt-get install -y \
	sudo \
	--no-install-recommends \
	&& apt-get remove -y apt-utils perl dialog \
	&& apt-get autoremove -y \
	&& apt-get autoclean \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "$UNAME ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/$UNAME \
  && chmod 440 /etc/sudoers.d/$UNAME \
  && chown root:root /etc/sudoers.d/$UNAME \
  && groupadd --gid $GID $GNAME \
  && useradd \
	--create-home \
	--base-dir $UBASE \
	--uid $UID \
	--gid $GID \
	--shell $SHELL \
	$UNAME

VOLUME $UBASE/$UNAME/app

USER $UNAME
WORKDIR $UBASE/$UNAME/app

ENTRYPOINT [ "ghci" ]
