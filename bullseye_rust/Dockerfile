# DESCRIPTION:	  Run in a default user space with sudo
# AUTHOR:	  Tony Wuersch <tony.wuersch@gmail.com>
# COMMENTS:
#	Debian Bullseye with a user "me" with sudo and gcc and rust.

FROM rg1.tony.wuersch.name:443/bullseye_gcc

LABEL maintainer="Tony Wuersch <tony.wuersch@gmail.com>" \
	distro="debian"\
	distro_long="debian-bullseye"

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.38.0

RUN set -eux; \
    rustArch='x86_64-unknown-linux-gnu'; \
    rustupSha256='36285482ae5c255f2decfab27d32ba19465804cb3ddf5a23e6ff2a7b0f6e0250'; \
    basePath="https://static.rust-lang.org/rustup/archive/1.19.0"; \
    curl -k -L -o rustup-init "${basePath}/${rustArch}/rustup-init"; \
    echo "${rustupSha256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
