#!/bin/bash

# export CUDA_VISIBLE_DEVICES=4
_EPOCHS=${1:-50}
_WARMUPS=8
_BS=64
_OBS=`jq -n $_BS*8`
_BASELR=`jq -n $_OBS*0.002`
_DATAPATH="/data/imagenet_pytorch/torch"

# _DEBUG=true
_DEBUG=false

if [ $_DEBUG == true ];
then
	python ./multiproc.py --nproc_per_node 8 ./main.py $_DATAPATH --data-backend pytorch --raport-file raport.json -j5 -p 100 --lr $_BASELR --optimizer-batch-size $_OBS --warmup $_WARMUPS --arch resnext101-32x4d -c fanin --label-smoothing 0.1 --lr-schedule cosine --mom 0.875 --wd 6.103515625e-05 --workspace ${2:-./} -b $_BS --static-loss-scale 128 --epochs $_EPOCHS
else
	nohup python ./multiproc.py --nproc_per_node 8 ./main.py $_DATAPATH --data-backend pytorch --raport-file raport.json -j5 -p 100 --lr $_BASELR --optimizer-batch-size $_OBS --warmup $_WARMUPS --arch resnext101-32x4d -c fanin --label-smoothing 0.1 --lr-schedule cosine --mom 0.875 --wd 6.103515625e-05 --workspace ${2:-./} -b $_BS --static-loss-scale 128 --epochs $_EPOCHS > run.log 2>&1 &
	nohup tensorboard --logdir=runs --port=6006 > tb.log 2>&1 &
fi

