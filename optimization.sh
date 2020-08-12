DATA_DIR="data"
LAMBDA="100"
DELTA="3.527e-5"
GAMMA="4.34e-3"

function enrich_output {
    awk '{ print NR " " $1 "," }' | sed '$ s/.$/;/'
}

# get simple params
echo "param lambda := ${LAMBDA};"
echo "param delta := ${DELTA};"
echo "param gamma := ${GAMMA};"

# get number of videos
NUMBER_OF_VIDEOS="$(echo ${DATA_DIR}/source/* | tr ' ' '\n' | wc -l)"
echo "param v := ${NUMBER_OF_VIDEOS};"

# get video popularities
echo "param p :="
python3 -c "import numpy as np; np.random.seed(42); a = np.random.zipf(1.5, ${NUMBER_OF_VIDEOS}); print('\n'.join(list(map(str, list(a / np.sum(a))))))" | enrich_output

# get video sizes in gigabytes
echo "param s :="
du -sk ${DATA_DIR}/dash/* | awk '{ print $1 / 1024/1024 }' | enrich_output

# get video durations in hours
echo "param d :="
for v in ${DATA_DIR}/source/*; do
    ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 ${v}
done | awk '{ print $1 / 60/60 }' | enrich_output

# erlang table fragment for 0.01 blockage probability
echo "
param e := 10;
param zeta :=
1 0.000,
2 0.010,
3 0.153,
4 0.455,
5 0.869,
6 1.360,
7 1.910,
8 2.500,
9 3.130,
10 3.780;
param xi :=
1 0,
2 1,
3 2,
4 3,
5 4,
6 5,
7 6,
8 7,
9 8,
10 9;
"