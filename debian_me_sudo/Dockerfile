# DESCRIPTION:	  Run in a default user space with sudo
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Stretch with a user "me" with sudo.

FROM rg1.test.tony.wuersch.name:443/debian_base
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian"\
	distro_long="debian-stretch"

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

RUN /usr/local/bin/clean-install \
	bash \
	bash-completion \
	apt-utils \
	ncurses-base \
	ncurses-bin \
	perl \
	dialog \
	tzdata \
	sudo \
	util-linux \
	ldnsutils

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
