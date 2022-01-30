# DESCRIPTION:	  Run in a default user space with sudo
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo and mesa.

FROM rg1.tony.wuersch.name:443/bullseye_me_sudo
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian"\
	distro_long="debian-bullseye"

ARG DEBIAN_FRONTEND=noninteractive

RUN /usr/local/bin/clean-install \
	mesa-utils \
	dbus
