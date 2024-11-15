FROM ubuntu

ARG user=ubuntu
ARG pass=debian
ARG uid=1000
ARG gid=1000
ARG timezone=Europe/London
ENV USERNAME $user
ENV PASSWORD $pass
ENV PUID $uid
ENV PGID $gid
ENV TZ $timezone

COPY . /root/

RUN apt-get update && \
    apt-get upgrade --assume-yes && \ 
    apt-get install --assume-yes --no-install-recommends tzdata && \
    groupadd -g 1500 ftp && \
    useradd -rm -s /bin/bash -g ftp -u 1500 ftp && \
    apt-get install --assume-yes build-essential rsyslog socat gcc make autoconf automake libssl-dev libpam0g-dev libevent-2.1-7 libsodium23 libwrap0 openbsd-inetd pure-ftpd-common tcpd update-inetd && \
    cd /root/pure-ftpd-1.0.49 && \
    /bin/bash ./configure --with-everything && \
    make && \
    make install-strip && \
    ln -sf /usr/local/sbin/pure-ftpd /usr/sbin/pure-ftpd && \
    apt-get clean && \
    apt-get autoremove --assume-yes && \
    chmod +x /root/user_create.sh

# Ouverture du port ftp
EXPOSE 21

# Lancement du script de création d'utilisateur basé sur les ENV ci-dessus
ENTRYPOINT [ "/bin/bash" , "-c" , "/root/user_create.sh $USERNAME $PASSWORD $PUID $PGID $TZ" ]