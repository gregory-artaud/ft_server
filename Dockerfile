FROM debian:buster
WORKDIR /app
COPY . .

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install nginx
RUN apt-get -y install php php-fpm php-json php-mbstring php-mysqlnd
RUN apt-get -y install mariadb-server
RUN apt-get -y install wget

COPY ./srcs/nginx_config/default /etc/nginx/sites-available/default

ENV USER='dbuser'
ENV PASSWORD='1234'

EXPOSE 80 443
CMD ["sh", "srcs/docker_entrypoint.sh"]