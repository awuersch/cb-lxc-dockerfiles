# DESCRIPTION:	  Run in a default user space with sudo and krb5
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and texlive and R and bookdown

FROM rg1.tony.wuersch.name:443/buster_tl
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian" \
	distro_long="debian-buster"

ARG DEBIAN_FRONTEND=noninteractive
ARG PROFILE=/etc/R/Rprofile.site

# Add R and R packages
RUN /usr/local/bin/clean-install \
    git \
    neovim \
    r-base \
    pandoc \
    pandoc-citeproc && \
    echo 'local({' >> $PROFILE && \
    echo '  r <- getOption("repos")' >> $PROFILE && \
    echo '  r["CRAN"] <- "http://cran.cnr.berkeley.edu/"' >> $PROFILE && \
    echo '  options(repos = r)' >> $PROFILE && \
    echo '  })' >> $PROFILE && \
    R --slave -e 'install.packages(c("bookdown"));'
