#!/bin/bash
if [ `whoami` != "root" ];then
        echo "Not root!"
        exit
fi
apt update 
apt upgrade
apt install -y autoconf automake bc bison build-essential cmake curl flex gcc g++  libcap-ng-dev libcap-ng-utils libcurl4-openssl-dev libevent-dev libgd-dev libgeoip-dev libjpeg-dev libnspr4-dev libpam0g-dev libpcre3 libpcre3-dev libpng-dev libpng-tools libselinux1-dev libssl-dev libunbound-dev libxslt1-dev make nano software-properties-common unzip wget zip zlib1g-dev git vim
#php版本尾号改最新
#apt install -y php7.1-cli php7.1-dev php7.1-fpm php7.1-bcmath php7.1-bz2 php7.1-common php7.1-curl php7.1-gd php7.1-gmp php7.1-imap php7.1-intl php7.1-json php7.1-mbstring php7.1-mysql php7.1-readline php7.1-recode php7.1-soap php7.1-sqlite3 php7.1-xml php7.1-xmlrpc php7.1-zip php7.1-opcache php7.1-xsl 
apt autoremove -y
wget --inet4-only  https://github.com/FelixTennouji/privateWeb/raw/main/nginx.tar -O /root/nginx.tar
mkdir -p /usr/local/src/cannoli/{modules,nginx,packages/{openssl,pcre,zlib}} 
mkdir -p /etc/nginx/{cache/{client,proxy,fastcgi,uwsgi,scgi},config,lock,logs,pid,ssl}
cd /usr/local/src/cannoli/nginx 
mv /root/nginx.tar . 
tar xf /usr/local/src/cannoli/nginx/nginx.tar 
rm -rf /usr/local/src/cannoli/nginx/nginx.tar
cd /usr/local/src/cannoli/packages/openssl
#openssl 改最新版本
wget --inet4-only  https://www.openssl.org/source/openssl-1.1.1q.tar.gz
tar xf /usr/local/src/cannoli/packages/openssl/openssl-1.1.1q.tar.gz --strip-components=1
rm -rf /usr/local/src/cannoli/packages/openssl/openssl-1.1.1q.tar.gz 
cd /usr/local/src/cannoli/packages/pcre
wget --inet4-only  https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.gz
tar xf /usr/local/src/cannoli/packages/pcre/pcre-8.45.tar.gz --strip-components=1
rm -rf /usr/local/src/cannoli/packages/pcre/pcre-8.45.tar.gz
cd /usr/local/src/cannoli/packages/zlib
#zlib 改最新版本
wget --inet4-only  http://www.zlib.net/zlib-1.2.13.tar.gz
tar xf /usr/local/src/cannoli/packages/zlib/zlib-1.2.13.tar.gz --strip-components=1
rm -rf /usr/local/src/cannoli/packages/zlib/zlib-1.2.13.tar.gz
cd /usr/local/src/cannoli/nginx/nginx-1.23.1
useradd -d /etc/nginx/ -s /sbin/nologin nginx
./configure --prefix=/etc/nginx \
               --sbin-path=/usr/sbin/nginx \
               --conf-path=/etc/nginx/config/nginx.conf \
               --lock-path=/etc/nginx/lock/nginx.lock \
               --pid-path=/run/nginx.pid \
               --error-log-path=/etc/nginx/logs/error.log \
               --http-log-path=/etc/nginx/logs/access.log \
               --http-client-body-temp-path=/etc/nginx/cache/client \
               --http-proxy-temp-path=/etc/nginx/cache/proxy \
               --http-fastcgi-temp-path=/etc/nginx/cache/fastcgi \
               --http-uwsgi-temp-path=/etc/nginx/cache/uwsgi \
               --http-scgi-temp-path=/etc/nginx/cache/scgi \
               --user=nginx \
               --group=nginx \
               --with-stream \
               --with-stream_ssl_module \
               --with-stream_realip_module \
               --with-stream_ssl_preread_module \
               --with-threads \
               --with-file-aio \
               --with-http_ssl_module \
               --with-http_v2_module \
               --with-http_realip_module \
               --with-http_addition_module \
               --with-http_xslt_module \
               --with-http_image_filter_module \
               --with-http_gunzip_module \
               --with-http_gzip_static_module \
               --with-pcre=/usr/local/src/cannoli/packages/pcre \
               --with-pcre-jit \
               --with-zlib=/usr/local/src/cannoli/packages/zlib \
               --with-openssl=/usr/local/src/cannoli/packages/openssl
make
make install
wget --inet4-only  https://github.com/FelixTennouji/privateWeb/raw/main/nginx.service -O /lib/systemd/system/nginx.service
mkdir -p /var/www/main
wget --inet4-only  https://github.com/FelixTennouji/privateWeb/raw/main/404.html -O /var/www/main/404.html
apt install -y mariadb-server
mysql_secure_installation
cd ~
