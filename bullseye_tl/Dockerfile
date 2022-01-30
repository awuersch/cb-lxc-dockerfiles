# DESCRIPTION:	  Run in a default user space with sudo and texlive
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo and texlive.

FROM rg1.tony.wuersch.name:443/bullseye_gcc

ENV LANG=C.UTF-8 \
	LC_ALL=C.UTF-8
ARG BUILD_DATE

LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian" \
	distro_long="debian-bullseye" \
	arch="x86_64" \
	org.label-schema.build-date=$BUILD_DATE

ARG TEXBASE=/usr/local/texlive
ARG YEAR=2018
ARG TEXDOC=$TEXBASE/$YEAR/texmf-dist/doc

ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/local/bin/clean-install \
	libgetopt-long-descriptive-perl \
	libdigest-perl-md5-perl \
	python3-pygments \
	fontconfig \
	man-db \
	info
  
WORKDIR /
RUN curl -sL ftp://tug.org/historic/systems/texlive/$YEAR/install-tl-unx.tar.gz | tar zxf - \
	&& mv install-tl-20* install-tl \
	&& cd install-tl \
	&& echo "selected_scheme scheme-full" > profile \
	&& echo "instopt_letter 1" >> profile

# \
# && ./install-tl -profile profile \
# && cd .. \
# && rm -rf install-tl $TEXBASE

ENV PATH=$TEXBASE/$YEAR/bin/x86_64-linux:$PATH \
    MANPATH=$TEXDOC/man:$MANPATH \
    INFOPATH=$TEXDOC/info:$INFOPATH

WORKDIR /home/me
CMD ["tlmgr", "--version"]
