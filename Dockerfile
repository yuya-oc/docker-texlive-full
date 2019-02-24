FROM frolvlad/alpine-glibc

MAINTAINER yuya-oc

ARG version="2018"

ENV PATH /usr/local/texlive/${version}/bin/x86_64-linuxmusl:$PATH

RUN apk add --no-cache perl wget tar xz binutils && \
    mkdir -p /tmp/install-tl-unx && \
    wget -q ftp://tug.org/texlive/historic/${version}/install-tl-unx.tar.gz -O - \
      | tar zxvf - -C /tmp/install-tl-unx --strip-components=1 && \
    echo $'selected_scheme scheme-full\noption_doc 0\noption_src 0' \
      >> /tmp/install-tl-unx/profile && \
    /tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/profile && \
    apk del --no-cache perl wget tar xz binutils && \
    rm -rf /tmp/install-tl-unx

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["sh"]
