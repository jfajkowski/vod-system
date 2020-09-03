INPUT=$1
OUTPUT=$2

echo "Transcoding started ${INPUT} -> ${OUTPUT}"
mkdir -p $(dirname ${OUTPUT})
ffmpeg -y -rw_timeout 5000000 -i ${INPUT} \
    -c:v libx264 \
    -map 0:v:0 -b:v:0 1000k -s:v:0 640x360 -r:v:0 30 \
    -map 0:v:0 -b:v:1 2500k -s:v:1 832x468 -r:v:1 30 \
    -map 0:v:0 -b:v:2 5000k -s:v:2 1280x720 -r:v:2 30 \
    -map 0:v:0 -b:v:3 7500k -s:v:3 1280x720 -r:v:3 60 \
    -map 0:v:0 -b:v:4 8000k -s:v:4 1920x1080 -r:v:4 30 \
    -map 0:v:0 -b:v:5 12000k -s:v:5 1920x1080 -r:v:5 60 \
    -c:a aac \
    -map 0:a:0 \
    -use_timeline 1 -use_template 1 -adaptation_sets "id=0,streams=v id=1,streams=a" \
    -f dash ${OUTPUT} || rm -r $(dirname ${OUTPUT});
echo "Transcoding completed ${INPUT} -> ${OUTPUT}"