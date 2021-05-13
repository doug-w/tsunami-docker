FROM ubuntu:trusty

RUN apt-get update \
 && apt-get install -y subversion php5-cli libsvn-notify-perl libsvn-svnlook-perl libhtml-parser-perl git git-svn \
 && useradd -r -u 501 tsunami

COPY scripts/ /

VOLUME /mud
VOLUME /git
VOLUME /home/svn/tsunami-repo

USER 501:501

CMD ["/autosvn"]
