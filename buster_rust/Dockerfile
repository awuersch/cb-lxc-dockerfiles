# DESCRIPTION:	  Run in a default user space with sudo
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Buster with a user "me" with sudo and gcc and rust.

FROM rg1.tony.wuersch.name:443/buster_gcc

LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian"\
	distro_long="debian-buster"

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.31.1

RUN set -eux; \
    rustArch='x86_64-unknown-linux-gnu'; \
    rustupSha256='2d4ddf4e53915a23dda722608ed24e5c3f29ea1688da55aa4e98765fc6223f71'; \
    basePath="https://static.rust-lang.org/rustup/archive/1.16.0"; \
    curl -k -L -o rustup-init "${basePath}/${rustArch}/rustup-init"; \
    echo "${rustupSha256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
