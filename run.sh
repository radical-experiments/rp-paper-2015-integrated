#!/bin/sh

# number of repetitions
REPS=1

# target resource
# RESOURCE='local'
RESOURCE='stampede'

# compute unit load
CU_LOAD='sleep_%s.json'

# experiment sizes
# SIZES="128: 512: 1024:"
SIZES="128:development 512:development 1024:normal 4096:large"

# number of workers
WORKERS="1 4 8"

# number of workers
UNITS="8192"

# fixed parameters
RUNTIME=30

mkdir -p "data/"
mkdir -p 'log/'
touch experiment.sids

# create 10^[246] byte sized dummy files for staging
for d in 1 1K 1M
do
   if ! test -f /tmp/input_$d.dat
   then
       dd if=/dev/urandom of=/tmp/input_$d.dat count=$d iflag=count_bytes
   fi
done


for tmp in $SIZES
do

    s=`echo $tmp | cut -f 1 -d :`
    q=`echo $tmp | cut -f 2 -d :`

    for w in $WORKERS
    do

        cat agent_config.tmpl | sed -e "s/###worker###/$w/g" \
                              | sed -e "s/###.*###/1/g" \
                              > agent_config.json
        # diff agent_config.tmpl  agent_config.json

    
      # for d in 1 1K 1M
        for d in 1
        do
    
            i=0
            while ! test $i = "$REPS"
            do
                i=$((i+1))
                exp="${RESOURCE}_${s}_${d}_${w}_${i}"
                log="log/$exp.log"
                load=`printf "$CU_LOAD" $d`

                tag="$RESOURCE : $s : $d : $w : $i :"
                grep "$tag" experiment.sids >/dev/null

                if test $? = 0
                then
                    echo "tag exists - skipping experiment $tag"

                else
                    echo "running experiment $tag"

                    rm -rf $HOME/.saga/adaptors/shell_job/
                    killall -9 -q -u merzky python
                    sleep 1
    
                    python experiment.py       \
                        -a "agent_config.json" \
                        -c "$s"                \
                        -u "$UNITS"            \
                        -t "$RUNTIME"          \
                        -r "$RESOURCE"         \
                        -l "$load"             \
                        -q "$q"                \
                        | tee "$log" 
    
                    sid=`grep 'session id:' $log | tail -n 1 | cut -f 2 -d :`
                    sid=`echo $sid` # trim white spaces
    
                    echo "$tag $sid" | tee -a experiment.sids
    
                    # radicalpilot-stats -m prof -s "$sid" -p "data/"
                    # radicalpilot-close-session -m export -s "$sid" 
                    mv -v "$sid".json data/
                fi
            done
        done
    done
done


