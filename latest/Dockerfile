FROM frolvlad/alpine-glibc:alpine-3.10 AS install
RUN apk add --no-cache perl wget tar xz binutils
RUN rm -rf /var/cache/apk/*
RUN mkdir -p /tmp/install-tl-unx
RUN wget -q http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -O /tmp/install-tl-unx.tar.gz
RUN tar zxvf /tmp/install-tl-unx.tar.gz -C /tmp/install-tl-unx --strip-components=1
RUN printf '%b' 'selected_scheme scheme-full\noption_doc 0\noption_src 0' \
    >> /tmp/install-tl-unx/profile
RUN /tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/profile -repository http://mirror.ctan.org/systems/texlive/tlnet

FROM frolvlad/alpine-glibc:alpine-3.10
LABEL maintainer="yuya-oc"
ENV PATH /usr/local/texlive/2019/bin/x86_64-linuxmusl:$PATH
COPY --from=install /usr/local/texlive /usr/local/texlive
