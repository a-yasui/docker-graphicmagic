# Released under the MIT license
# https://opensource.org/licenses/MIT
#

FROM alpine:3.11

MAINTAINER a-yasui

ENV PKGNAME=graphicsmagick
ENV PKGVER=1.3.35
ENV PKGSOURCE=http://downloads.sourceforge.net/$PKGNAME/$PKGNAME/$PKGVER/GraphicsMagick-$PKGVER.tar.lz

WORKDIR /workdir

# Installing graphicsmagick dependencies
RUN cd / && \
    apk add --update g++ \
                     gcc \
                     make \
                     lzip \
                     wget \
                     libjpeg-turbo-dev \
                     libpng-dev \
                     libtool \
                     libgomp && \
    wget $PKGSOURCE && \
    lzip -d -c GraphicsMagick-$PKGVER.tar.lz | tar -xvf - && \
    cd GraphicsMagick-$PKGVER && \
    ./configure \
      --build=$CBUILD \
      --host=$CHOST \
      --prefix=/usr \
      --sysconfdir=/etc \
      --mandir=/usr/share/man \
      --infodir=/usr/share/info \
      --localstatedir=/var \
      --enable-shared \
      --disable-static \
      --with-modules \
      --with-threads \
      --with-gs-font-dir=/usr/share/fonts/Type1 \
      --with-quantum-depth=16 && \
    make && \
    make install && \
    cd / && \
    rm -rf GraphicsMagick-$PKGVER && \
    rm GraphicsMagick-$PKGVER.tar.lz && \
    apk del g++ \
            gcc \
            make \
            lzip \
            wget


COPY IPAfont00303.zip /
RUN cd / && \
  unzip IPAfont00303.zip && \
  mkdir -p /usr/share/fonts && \
  cp -R IPAfont00303 /usr/share/fonts/IPA && \
  rm -rf IPAfont00303.zip IPAfont00303

CMD ["sh"]
