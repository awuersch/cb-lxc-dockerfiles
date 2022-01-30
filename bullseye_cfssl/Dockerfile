# DESCRIPTION:	  Run in a default user space with sudo and go
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo and gcc and go and cfssl.

FROM rg1.tony.wuersch.name:443/bullseye_go
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian" \
	distro_long="debian-bullseye" \
	arch="amd_64"

ARG USER=me
ARG MEHOME=/home/$USER
USER $USER
RUN . $MEHOME/.profile && go get -u github.com/cloudflare/cfssl/cmd/...

EXPOSE 8888

ENTRYPOINT ["/home/me/go/bin/cfssl"]
CMD ["--help"]
