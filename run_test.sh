#!/bin/bash

subjID=`jq -r '._inputs[0].meta.subject' config.json`
static=`jq -r '.tractogram_static' config.json`
static_mni=track_aligned/track.tck
t1_static=`jq -r '.t1_static' config.json`
t1_static_mni=MNI152_T1_1.25mm_brain.nii.gz

echo "Check the inputs subject id"
if [ ! $subjID == `jq -r '._inputs[1].meta.subject' config.json` ]; then
echo "Inputs subject id incorrectly inserted. Check them again."
	exit 1
fi

echo "Tractogram conversion to trk"
python3 tck2trk.py $t1_static_mni $static_mni -f

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

#Tract conversion from trk to tck with python: .json file is not created
#mkdir -p output/tcks
#python3 trk2tck.py tracts_trks/* output/tcks/

#Prepare tract conversion from wmc to tck with matlab
sed -i '$s/}/,\n"classification":".\/classification.mat"}/' config.json
sed -i '$s/}/,\n"track":".\/tractogram.tck"}/' config.json
mkdir -p output/tcks


