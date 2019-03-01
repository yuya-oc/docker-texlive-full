FROM frolvlad/alpine-glibc

LABEL maintainer="yuya-oc"

ENV PATH /usr/local/texlive/2017/bin/x86_64-linux:$PATH

RUN apk add --no-cache perl wget tar xz binutils && \
    mkdir -p /tmp/install-tl-unx && \
    wget -q ftp://tug.org/texlive/historic/2017/tlnet-final/install-tl-unx.tar.gz -O - \
      | tar zxvf - -C /tmp/install-tl-unx --strip-components=1 && \
    echo $'selected_scheme scheme-full\noption_doc 0\noption_src 0' \
      >> /tmp/install-tl-unx/profile && \
    /tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/profile -repository ftp://tug.org/texlive/historic/2017/tlnet-final && \
    apk del --no-cache perl wget tar xz binutils && \
    rm -rf /tmp/install-tl-unx

WORKDIR /workdir

VOLUME ["/workdir"]
