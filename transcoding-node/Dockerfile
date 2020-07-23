FROM tiangolo/nginx-rtmp
COPY nginx.conf /etc/nginx/nginx.conf
COPY dashify.sh /usr/local/bin/dashify.sh
RUN apt-get update
RUN apt-get install -y ffmpeg
EXPOSE 1935