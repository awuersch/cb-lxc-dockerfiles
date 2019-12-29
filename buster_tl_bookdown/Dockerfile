# DESCRIPTION:	  Run in a default user space with sudo and krb5
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and texlive and R and bookdown

FROM rg1.tony.wuersch.name:443/buster_tl
LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian" \
	distro_long="debian-buster"

ARG DEBIAN_FRONTEND=noninteractive
# define PROFILE for R calls
ARG PROFILE=/etc/R/Rprofile.site
ARG CRAN_URL=https://cloud.r-project.org

RUN /usr/local/bin/clean-install \
    git \
    neovim \
    pandoc \
    pandoc-citeproc \
    libopenblas-base
# prerequisites for ggplot2-book dependent packages
RUN /usr/local/bin/clean-install \
    libcurl4-openssl-dev \
    libxml2-dev \
    libudunits2-dev \
    libgdal-dev \
    libv8-dev \
    libjq-dev \
    libprotobuf-dev \
    protobuf-compiler \
    ghostscript
# use CRAN buster backport to bring R to 3.6
RUN apt-key adv \
    --keyserver keys.gnupg.net \
    --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' && \
    echo "deb $CRAN_URL/bin/linux/debian buster-cran35/" >> /etc/apt/sources.list
# R packages (use debian versions to ease calling R)
RUN /usr/local/bin/clean-install \
    r-base-dev \
    r-cran-foreign \
    r-cran-lattice \
    r-cran-tidyverse \
    r-cran-rcppeigen \
    r-cran-bh
RUN R --slave -e 'install.packages(c("rstan"));'
RUN R --slave -e 'install.packages(c("bookdown","blogdown"));'
