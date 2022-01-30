# DESCRIPTION:	  Run in a default user space with sudo and krb5 and x11 and openjdk-8-jre
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Stretch with a user "me" with sudo and krb5 and x11 and openjdk-8-jre

FROM rg1.test.tony.wuersch.name:443/debian_krb5_x11
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro="debian" distro_long="debian-stretch" arch="x86_64" krb5_version="1.16-2"

RUN /usr/local/bin/clean-install openjdk-8-jre
