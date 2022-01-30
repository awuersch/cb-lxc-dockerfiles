# DESCRIPTION:	  Run in a default user space with sudo and krb5 and firefox
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and krb5 and firefox.

FROM rg1.test.tony.wuersch.name:443/buster_krb5
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro="debian" distro_long="debian-buster" arch="x86_64" krb5_version="1.16-2"

RUN /usr/local/bin/clean-install \
	dirmngr \
	gnupg \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0AB215679C571D1C8325275B9BDB3D89CE49EC21 \
	&& echo "deb http://ppa.launchpad.net/mozillateam/firefox-next/ubuntu xenial main" >> /etc/apt/sources.list.d/firefox.list \
 && /usr/local/bin/clean-install \
	apulse \
	ca-certificates \
	ffmpeg \
	firefox \
	hicolor-icon-theme \
	libasound2 \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpulse0 \
	fonts-noto \
	fonts-noto-cjk \
	fonts-noto-color-emoji

COPY local.conf /etc/fonts/local.conf

RUN echo 'pref("browser.tabs.remote.autostart", false);' >> /etc/firefox/syspref.js \
 && echo 'pref("network.negotiate-auth.trusted-uris", ".tony.wuersch.name");' >> /etc/firefox/syspref.js \
 && echo 'pref("network.negotiate-auth.delegation-uris", ".tony.wuersch.name");' >> /etc/firefox/syspref.js \
 && echo 'pref("network.automatic-ntlm-auth.trusted-uris", ".tony.wuersch.name");' >> /etc/firefox/syspref.js

COPY entrypoint.sh /usr/bin/startfirefox

# ENTRYPOINT [ "startfirefox" ]
