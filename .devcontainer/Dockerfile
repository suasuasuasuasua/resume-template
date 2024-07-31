#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------
FROM ubuntu:24.04

### Enable multi-architecture build
# https://unix.stackexchange.com/a/748634
# docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder
# docker buildx inspect --bootstrap
# docker buildx use multi-platform-builder
# docker buildx build --platform=linux/arm64,linux/amd64 --push --tag project-name:latest -f ./project-name/Dockerfile .

LABEL org.opencontainers.image.source=https://github.com/suasuasuasuasua/resumes

RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean && \
    apt update && \
    apt install gcc make git wget curl gnupg2 libfontconfig -y

# https://github.com/overleaf/overleaf/blob/7212c16dde66950b1a5456e98bba1effbe6aebf1/server-ce/Dockerfile-base
ARG TEXLIVE_MIRROR=https://mirror.ox.ac.uk/sites/ctan.org/systems/texlive/tlnet

# Install minimal latex
RUN mkdir /install-tl-unx \
    &&  wget --quiet https://tug.org/texlive/files/texlive.asc \
    &&  gpg --import texlive.asc \
    &&  rm texlive.asc \
    &&  wget --quiet ${TEXLIVE_MIRROR}/install-tl-unx.tar.gz \
    &&  wget --quiet ${TEXLIVE_MIRROR}/install-tl-unx.tar.gz.sha512 \
    &&  wget --quiet ${TEXLIVE_MIRROR}/install-tl-unx.tar.gz.sha512.asc \
    &&  gpg --verify install-tl-unx.tar.gz.sha512.asc \
    &&  sha512sum -c install-tl-unx.tar.gz.sha512 \
    &&  tar -xz -C /install-tl-unx --strip-components=1 -f install-tl-unx.tar.gz \
    &&  rm install-tl-unx.tar.gz* \
    &&  echo "tlpdbopt_autobackup 0" >> /install-tl-unx/texlive.profile \
    &&  echo "tlpdbopt_install_docfiles 0" >> /install-tl-unx/texlive.profile \
    &&  echo "tlpdbopt_install_srcfiles 0" >> /install-tl-unx/texlive.profile \
    &&  echo "selected_scheme scheme-basic" >> /install-tl-unx/texlive.profile \
    \
    &&  /install-tl-unx/install-tl \
    -profile /install-tl-unx/texlive.profile \
    -repository ${TEXLIVE_MIRROR} \
    \
    &&  $(find /usr/local/texlive -name tlmgr) path add

# Latex packages
RUN  tlmgr install --repository ${TEXLIVE_MIRROR} \
    latexmk \
    texcount \
    synctex \
    # Random ones that we need or else nothing works..
    etoolbox \
    xetex \
    xcharter \
    xkeyval \
    etoolbox \
    xstring \
    fontaxes \
    enumitem \
    titlesec \
    latexindent

RUN tlmgr path add \
    &&  rm -rf /install-tl-unx

# latexindent modules
RUN cpan -i \
    YAML::Tiny \
    File::HomeDir \
    Unicode::GCString

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=dialog \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8