docker kill transcoding-node
docker rm transcoding-node
docker build --tag transcoding-node .
docker run -d -p 1935:1935 -v $(realpath ../data):/data --name transcoding-node transcoding-node:latest