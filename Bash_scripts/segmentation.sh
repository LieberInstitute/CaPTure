#!/bin/bash
#$ -M madhavitippani28@gmail.com
#$ -m bea
#$ -cwd
#$ -l mem_free=25G,h_vmem=25G,h_stack=256M,h_fsize=10G
#$ -o /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/Seg_logs/$TASK_ID.txt
#$ -e /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/Seg_logs/$TASK_ID.txt
#$ -t 1-16
#$ -tc 10
#$ -m a

echo "**** Job starts ****"
date

echo "**** JHPCE info ****"
echo "User: ${USER}"
echo "Job id: ${JOB_ID}"
echo "Job name: ${JOB_NAME}"
echo "Hostname: ${HOSTNAME}"
echo "Task id: ${SGE_TASK_ID}"
echo "****"
echo "Sample id: $(cat /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/segmentation_list.txt | awk '{print $NF}' | awk "NR==${SGE_TASK_ID}")"
echo "****"

export TZ=America/New_York

FILE1=$(cat /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/segmentation_list.txt | awk '{print $NF}' | awk "NR==${SGE_TASK_ID}")
toolbox=/dcl01/lieber/ajaffe/Maddy/Ca_Img/vignette/toolbox
microscope=780
thresh=4

matlab -nodesktop -nosplash -r "addpath(genpath('$toolbox')); segmentation('$FILE1','$microscope',$thresh);exit;" 

echo "**** Job ends ****"

date
