docker kill streaming-node
docker rm streaming-node
docker build --tag streaming-node .
docker run -d -p 80:80 -v $(realpath ../data):/data --name streaming-node streaming-node:latest