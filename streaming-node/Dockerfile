FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y wget unzip build-essential libpcre3-dev zlib1g-dev libssl-dev

RUN wget http://nginx.org/download/nginx-1.18.0.tar.gz
RUN wget https://github.com/bigplum/Nginx-limit-traffic-rate-module/archive/master.zip

RUN tar -xzvf nginx-1.18.0.tar.gz
RUN unzip master.zip

RUN cd nginx-1.18.0 \
  && ./configure --add-module=../Nginx-limit-traffic-rate-module-master \
  && make \
  && make install

ENV PATH /usr/local/nginx/sbin:$PATH

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]