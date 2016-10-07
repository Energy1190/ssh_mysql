FROM debian:jessie
MAINTAINER Adrian Dvergsdal [atmoz.net]

# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
    apt-get install -y $buildDeps \
        php5-cli \
        php5-common \
        php5-mysql \
        php5-gd \
        php5-fpm \
        php5-cgi \
        php5-fpm \
        php-pear \
        php5-mcrypt \
        php5-memcache \
        php5-curl \
        curl 
        
RUN apt-get update && \
    apt-get -y install openssh-server mysql-client && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key*

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint /

RUN chmod 777 /entrypoint

EXPOSE 22

ENTRYPOINT ["/entrypoint"]

