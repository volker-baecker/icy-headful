# Headful ICY image
#
# run with
#
# docker run -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v $(pwd):/data mricnrsfr/icy-headful
#
# volker.baecker@mri.cnrs.fr

FROM ubuntu 
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y bzip2
run apt-get install -y gedit
run apt-get install -y xcb
run apt-get install -y unzip

# add webupd8 repository 
RUN \
    echo "===> add webupd8 repository..."  && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update  && \
    \
    \
    echo "===> install Java"  && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default  && \
    \
    \
    echo "===> clean up..."  && \
    rm -rf /var/cache/oracle-jdk8-installer  && \
    apt-get clean  && \
rm -rf /var/lib/apt/lists/*

RUN wget http://www.icy.bioimageanalysis.org/downloadIcy/icy.zip
RUN unzip icy.zip
RUN chmod a+x icy
RUN mkdir /data
COPY run_icy.sh /
RUN chmod a+x ./run_icy.sh
ENTRYPOINT ./run_icy.sh
