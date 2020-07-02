#!/bin/bash

subjID=`jq -r '._inputs[0].meta.subject' config.json`
static=track_aligned/track.tck
t1_static=`jq -r '.t1_static' config.json`

echo "Check the inputs subject id"
if [ ! $subjID == `jq -r '._inputs[1].meta.subject' config.json` ]; then
echo "Inputs subject id incorrectly inserted. Check them again."
	exit 1
fi

echo "Tractogram conversion to trk"
python3 tck2trk.py $t1_static $static -f

echo "Running Classifyber (only test)"
mkdir -p tracts_trks
python3 test_classifyber.py \
		-src_dir 'results_training' \
		-static 'track_aligned/track.trk' \
		-out_dir 'tracts_trks'

if [ -z "$(ls -A -- "tracts_trks")" ]; then    
	echo "Segmentation failed."
	exit 1
else    
	echo "Segmentation done."
fi

echo "Building the wmc structure"
mkdir -p tracts
python3 build_wmc.py -tractogram $static

if [ -f 'classification.mat' ]; then 
    echo "WMC structure created."
else 
	echo "WMC structure missing."
	exit 1
fi

mkdir -p output_wmc
mv tracts output_wmc
cp classification.mat output_wmc

#echo "Tract conversion to tck" #.json file is not created
#mkdir -p output/tcks
#python3 trk2tck.py tracts_trks/* output/tcks/

