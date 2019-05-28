FROM frolvlad/alpine-glibc:latest AS install
RUN apk add --update perl wget tar xz binutils
RUN mkdir -p /tmp/install-tl-unx
RUN wget -q http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2016/tlnet-final/install-tl-unx.tar.gz -O - \
    | tar zxvf - -C /tmp/install-tl-unx --strip-components=1
RUN echo $'selected_scheme scheme-full\noption_doc 0\noption_src 0' \
    >> /tmp/install-tl-unx/profile
RUN /tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/profile -repository http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2016/tlnet-final

FROM frolvlad/alpine-glibc:latest
LABEL maintainer="yuya-oc"
ENV PATH /usr/local/texlive/2016/bin/x86_64-linux:$PATH
COPY --from=install /usr/local/texlive /usr/local/texlive
