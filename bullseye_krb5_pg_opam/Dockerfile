# DESCRIPTION:	  Run in a default user space with sudo and krb5 and psql and opam
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo and krb5 and psql and opam.

FROM rg1.tony.wuersch.name:443/bullseye_krb5_pg
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" distro_style="apt" distro="debian" distro_long="debian-bullseye" arch="x86_64" krb5_version="1.16-2" postgresql_version="13" ocaml_version="4.13.1" operatingsystem="linux"

ARG DEBIAN_FRONTEND=noninteractive
ARG OCAML_GITDIR=src/git/github.com/ocaml
ARG HOME=/home/me

COPY get_min_ocaml_packages.sh /usr/local/bin/get_min_ocaml_packages.sh
COPY get_ocaml_packages.sh /usr/local/bin/get_ocaml_packages.sh
COPY opam_init.sh /usr/local/bin/opam_init.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends --allow-change-held-packages libcap2 && \
    /usr/local/bin/clean-install \
	mercurial \
	darcs \
	pkg-config \
	build-essential \
	autoconf \
	m4 \
	software-properties-common \
	aspcud \
	unzip \
	rsync \
	opam \
	libffi-dev

USER me
WORKDIR $HOME
RUN mkdir .ssh \
	&& chmod 700 .ssh \
	&& echo "\neval \$(opam env)" >> $HOME/.profile
