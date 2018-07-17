FROM ubuntu:trusty

ADD tsunami.patch /

RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential ca-certificates curl bison autoconf autogen automake libgcrypt20-dev libmysqlclient-dev libiksemel-dev libssl-dev libjson-c-dev socat supervisor \
 && rm /usr/sbin/iconvconfig \
 && curl -L http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.11.tar.gz | tar -xvzf - \
 && cd libiconv-1.11 \
 && ./configure --prefix=/usr/local \
 && make install \
 && ldconfig -v \
 && cd .. \
 && rm -rf libiconv-1.11 \
 && curl -L https://github.com/ldmud/ldmud/archive/3.3.719.tar.gz | tar -xvzf - \
 && cd /ldmud-3.3.719/src && ./autogen.sh && cd /ldmud-3.3.719 && patch -p1 < /tsunami.patch && cd src \
 && rm /tsunami.patch \
 && ./configure --prefix=/usr/users --enable-compat-mode --enable-erq=xerq --with-erq-debug=0 --with-read-file-max-size=300000 --with-master-name=obj/master --with-max-array-size=0 --with-max-mapping-size=0 --with-max-mapping-keys=0 --with-max-players=100 --with-max-cost=5000000 --with-hard-malloc-limit=0 --enable-use-mysql --enable-use-mccp --enable-use-pcre=builtin --enable-use-xml=iksemel --enable-use-tls --with-portno=2777 --with-max-user-trace=260 --with-max-trace=270 LDFLAGS=-L/usr/lib64/mysql --with-pcre-recursion-limit=0 --with-evaluator_stack_size=20000 \
 && make install-driver \
 && cd /ldmud-3.3.719/src/util/xerq && make install \
 && rm -rf /ldmud-3.3.719 \
 && apt-get clean \
 && apt-get remove --purge -y build-essential ca-certificates git bison autoconf autogen automake libgcrypt20-dev \
 && apt-get autoremove -y \
 && mkdir -p /var/log/supervisor \
 && useradd -r -u 501 tsunami \
 && mkdir -p /var/run/mysqld \
 && chown tsunami.tsunami /var/run/mysqld /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 2777

VOLUME /usr/users/lib
VOLUME /usr/uesrs/lib/data
VOLUME /usr/uesrs/lib/www
VOLUME /usr/uesrs/lib/log
VOLUME /usr/uesrs/lib/secure/log

USER 501

CMD ["/usr/bin/supervisord"]

