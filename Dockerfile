FROM ubuntu:14.04
MAINTAINER Shisei Hanai<ruimo.uno@gmail.com>

RUN apt-get update
RUN apt-get install -y wget build-essential
RUN wget https://mecab.googlecode.com/files/mecab-0.996.tar.gz && \
  tar -xzf mecab-0.996.tar.gz && \
  cd mecab-0.996 && \
  ./configure --enable-utf8-only && \
  make && \
  make install && \
  ldconfig

RUN wget https://mecab.googlecode.com/files/mecab-ipadic-2.7.0-20070801.tar.gz && \
  tar -xzf mecab-ipadic-2.7.0-20070801.tar.gz && \
  cd mecab-ipadic-2.7.0-20070801 && \
  ./configure --with-charset=utf8 && \
  make && \
  make install

RUN echo "dicdir = /usr/local/lib/mecab/dic/ipadic" > /usr/local/etc/mecabrc

add user.csv /user.csv

RUN /usr/local/libexec/mecab/mecab-dict-index -d/usr/local/lib/mecab/dic/ipadic -u user.dic -f utf-8 -t utf-8 user.csv
RUN echo "userdic = /user.dic" >> /usr/local/etc/mecabrc
