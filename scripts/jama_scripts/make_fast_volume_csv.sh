#!/bin/bash

#### Welcome to the fast csv party #########
### Pre: Must have run the get_fast_total_brain_volume_all_subjs.sh 
### Post: /project/msdepression/results/total_fast_brain_volumes_all_subjs.csvs
### Uses: Each person has a file with their brain volumes. Just need to put them all together
#dependencies: just working in bash

default='/project/msdepression/data/melissa_martin_files/csv/mimosa_binary_masks_hcp_space_20211026_n2336'
directory='/project/msdepression/results/'
output_csv="${directory}/total_fast_brain_volumes_all_subjs.csv"
num_cores=1

if [ $# == 0 ]
then
    echo "We will use the default mimosa path file" $default
    lesion_file=$default
else  
    lesion_file=$1
fi
echo "File being read is "$lesion_file
echo "... Starting to fast ..."

#initialize output file

#remove it if it exists
rm -f $output_csv
touch $output_csv
echo "EMPI,EXAM_DATE,gm_volume,wm_volume,total_volume" >> $output_csv


lesion_paths=$(cat $lesion_file)

for lesion in ${lesion_paths}; do
	path_to_indiv_volume_csv=$(echo ${lesion} | perl -pe 's/mimosa_binary_mask_0.25_mni_hcp.nii.gz/total_fast_brain_volume_values.csv/')
	more ${path_to_indiv_volume_csv} | tail -1 >> ${output_csv}
done
