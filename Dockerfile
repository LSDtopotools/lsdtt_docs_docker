# This is a dockerfile for the LSDTT documentation, only slightly modified from this dockerfile:
# https://github.com/asciidoctor/docker-asciidoctor

FROM alpine:3.7

LABEL MAINTAINERS="Simon Mudd <simon.m.mudd@ed.ac.uk>"

ARG asciidoctor_version=1.5.7.1
ARG asciidoctor_pdf_version=1.5.0.alpha.16

ENV ASCIIDOCTOR_VERSION=${asciidoctor_version} \
  ASCIIDOCTOR_PDF_VERSION=${asciidoctor_pdf_version}

# Installing package required for the runtime of
# any of the asciidoctor-* functionnalities
RUN apk add --no-cache \
    bash \
    git \
    curl \
    ca-certificates \
    findutils \
    font-bakoma-ttf \
    graphviz \
    make \
    openjdk8-jre \
    py2-pillow \
    py-setuptools \
    python2 \
    ruby \
    ruby-mathematical \
    ttf-liberation \
    unzip \
    which

# Installing Ruby Gems needed in the image
# including asciidoctor itself
RUN apk add --no-cache --virtual .rubymakedepends \
    build-base \
    libxml2-dev \
    ruby-dev \
  && gem install --no-document \
    "asciidoctor:${ASCIIDOCTOR_VERSION}" \
    asciidoctor-confluence \
    asciidoctor-diagram \
    asciidoctor-epub3:1.5.0.alpha.7 \
    asciidoctor-mathematical \
    "asciidoctor-pdf:${ASCIIDOCTOR_PDF_VERSION}" \
    asciidoctor-revealjs \
    coderay \
    epubcheck:3.0.1 \
    haml \
    kindlegen:3.0.3 \
    pygments.rb \
    rake:12.3.1 \
    rouge \
    slim \
    thread_safe \
    tilt \
    rake \
    addressable \
    pdf-reader \
    rubyzip:1.2.1 \
    public_suffix:3.0.3 \
    awesome_print \
    bundler \
  && apk del -r --no-cache .rubymakedepends

# Installing Python dependencies for additional
# functionnalities as diagrams or syntax highligthing
RUN apk add --no-cache --virtual .pythonmakedepends \
    build-base \
    python2-dev \
    py2-pip \
  && pip install --upgrade pip \
  && pip install --no-cache-dir \
    actdiag \
    'blockdiag[pdf]' \
    nwdiag \
    Pygments \
    seqdiag \
  && apk del -r --no-cache .pythonmakedepends

WORKDIR /documents

