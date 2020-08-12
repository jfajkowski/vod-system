FROM tiangolo/nginx-rtmp
COPY nginx.conf /etc/nginx/nginx.conf
RUN apt-get update && apt-get install -y ffmpeg
COPY dashify.sh /usr/local/bin/dashify.sh
EXPOSE 1935