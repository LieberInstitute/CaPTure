#!/bin/bash
#$ -M madhavitippani28@gmail.com
#$ -m bea
#$ -cwd
#$ -l mem_free=25G,h_vmem=25G,h_stack=256M,h_fsize=10G
#$ -o /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/storemat_log.txt
#$ -e /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/storemat_log.txt
#$ -t 1-10
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

export TZ=America/New_York

toolbox=/dcl01/lieber/ajaffe/Maddy/Ca_Img/vignette/toolbox
bftools=/dcl01/lieber/ajaffe/Maddy/Ca_Img/vignette/toolbox/bfmatlab

matlab -nodesktop -nosplash -r "addpath(genpath('$toolbox')); store_mat('$FILE1','$bftools');exit;" 

echo "**** Job ends ****"

date
