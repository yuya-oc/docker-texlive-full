FROM frolvlad/alpine-glibc:alpine-3.10 AS install
RUN apk add --no-cache perl wget tar xz binutils
RUN mkdir -p /tmp/install-tl-unx
RUN wget -q http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2020/tlnet-final/install-tl-unx.tar.gz -O /tmp/install-tl-unx.tar.gz
RUN tar zxvf /tmp/install-tl-unx.tar.gz -C /tmp/install-tl-unx --strip-components=1
RUN printf '%b' 'selected_scheme scheme-full\noption_doc 0\noption_src 0' \
    >> /tmp/install-tl-unx/profile
RUN /tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/profile -repository http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2020/tlnet-final

FROM frolvlad/alpine-glibc:alpine-3.10
LABEL maintainer="yuya-oc"
ENV PATH /usr/local/texlive/2020/bin/x86_64-linux:$PATH
COPY --from=install /usr/local/texlive /usr/local/texlive
