# DESCRIPTION:	  Run in a default user space with sudo and krb5 and x11 and openjdk-11-jre
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and krb5 and x11 and openjdk-8-jre

FROM rg1.tony.wuersch.name:443/buster_krb5_x11_openjdk11
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro="debian" distro_long="debian-buster" arch="x86_64" krb5_version="1.16-2"

RUN /usr/local/bin/clean-install gradle
