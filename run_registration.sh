#!/bin/bash

#module load ants
#module load fsl/5.0.11
#module unload mrtrix/0.2.12 
#module load mrtrix/3.0

#[ $PBS_O_WORKDIR ] && cd $PBS_O_WORKDIR

tck_id=`jq -r '._inputs[0].meta.subject' config.json`
t1_id=`jq -r '._inputs[1].meta.subject' config.json`

echo "Check the inputs subject id"
if [ $tck_id == $t1_id  ]; then
	echo "Inputs subject IDs correctly inserted"
else
	echo "Inputs subject IDs incorrectly inserted. Check them again."
	exit 1
fi

WARP_DIR=warp_dir
OUT_DIR=track_aligned
mkdir -p $WARP_DIR
mkdir -p $OUT_DIR
mkdir -p warps

tck=`jq -r '.tractogram_static' config.json`
t1=`jq -r '.t1_static' config.json`
atlas=MNI152_T1_1.25mm_brain.nii.gz
cp $tck ./tractogram.tck

echo "Computing warp to MNI space..."
singularity exec -e docker://giuliaberto/ants2-mrtrix3-fsl6:1.1 ./ants_t1w_transformation.sh $t1_id $t1 MNI $atlas
mv sub-${t1_id}_space_MNI_var-t1w_affine.txt $WARP_DIR
mv sub-${t1_id}_space_MNI_var-t1w_warp.nii.gz $WARP_DIR
mv sub-${t1_id}_space_MNI_var-t1w4tck_warp.nii.gz $WARP_DIR	

if [ -z "$(ls -A -- "$WARP_DIR")" ]; then    
	echo "Transformation failed."
	exit 1
else    
	echo "Transformation done."
fi		

echo "Registering the tractogram to MNI space..."
singularity exec -e docker://brainlife/dipy:0.16.0 python ants_t1w_tractogram_registration.py -movID $tck_id -tck $tck -warp_dir ${WARP_DIR}
mv track.tck $OUT_DIR 

if [ -z "$(ls -A -- "$OUT_DIR")" ]; then    
	echo "Registration failed."
	exit 1
else    
	echo "Registration done."
fi	
