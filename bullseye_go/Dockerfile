# DESCRIPTION:	  Run in a default user space with sudo and go
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo and gcc and go.

FROM rg1.tony.wuersch.name:443/bullseye_gcc
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian"\
	distro_long="debian-bullseye" \
	arch="amd_64"

ARG GOLANG_VERSION=1.13.1
ARG URL=https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz
ARG USER=me
ARG MEHOME=/home/$USER

RUN curl "${URL}" | tar -C /usr/local -xzf -

RUN echo "export GOPATH=$MEHOME/go" >> $MEHOME/.profile && . $MEHOME/.profile \
 && echo "export PATH='$PATH':/usr/local/go/bin:$GOPATH/bin" >> $MEHOME/.profile
