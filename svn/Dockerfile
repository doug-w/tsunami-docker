FROM ubuntu:trusty

ADD autosvn /
ADD tsu-svn.pl /

RUN apt-get update \
 && apt-get install -y subversion php5-cli libsvn-notify-perl libsvn-svnlook-perl libhtml-parser-perl

VOLUME /mud
VOLUME /home/svn/tsunami-repo

USER 501:501

CMD ["/autosvn"]
