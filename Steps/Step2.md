# To segment the ROIs from the red image.

Matlab function used is [segmentation](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/segmentation.m)
in the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox) directory. 
Inputs to the [segmentation](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/segmentation.m) function are paths to the red image[*R.czi](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/test_data) file, microscope and threshold.
The output of this function produces a [jpeg](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/test_data/SS1803_50_Lime_A1_DIV42_1R4.jpeg) showing input redimage with its corresponding segmented image and a [matfile](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/test_data/SS1803_50_Lime_A1_DIV42_1R_ROI_info_4.mat) with table `ROI_info` which has different metrics for each segmented ROI. These files are saved in the same directory as the input red file.

To run a single file on matlab
```matlab
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox';
filename = '/LieberInstitute/CaImg_cellcultures/tree/master/test_data/SS1803_50_Lime_A1_DIV42_1R.czi';
microscope = '780';
thresh = 4;

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session
segmentation(filename,microscope,thresh)

Reading Images:  1  of  1 Frames
Elapsed time is 7.709206 seconds.
```
If the segmentation time is less use `for loop` to process the entire dataset file by file
```matlab

myfiles = dir('/PathToDataset/*R.czi');
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox'; 
microscope = '780'; % the user can input 'SD' for spinning disk microscope and 'Chronic' for Chronic microscope which will automatically set parameters like ROI size in the `segmentation` function.
thresh = 4;

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session

for i = 1:numel(myfiles)
filename = fullfile(myfiles(i).folder, myfiles(i).name);
segmentation(filename,microscope,thresh)
disp(['Completed: file',num2str(i)])
end
```
If the segmentation time is more batch run all the files using the [segmentation.sh](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Bash_scripts/segmentation.sh) bash script like below on jhpce.

``` bash
[jhpce01 /dcl01/lieber/ajaffe/Maddy]$ qrsh /dcl01/lieber/ajaffe/Maddy/Ca_Img/code_pipeline/segmentation.sh
```
The bash script needs path to user created `Seg_logs` folder to store function progress and any errors. Line 6 and 7 in [segmentation.sh](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Bash_scripts/segmentation.sh)

```bash
#$ -o /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/Seg_logs/$TASK_ID.txt
#$ -e /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/Seg_logs/$TASK_ID.txt
```
It also needs a text file with list of all files to batch run. Line 22 and 27 in [segmentation.sh](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Bash_scripts/segmentation.sh)
```bash
echo "Sample id: $(cat /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/segmentation_list.txt | awk '{print $NF}' | awk "NR==${SGE_TASK_ID}")"
FILE1=$(cat /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/segmentation_list.txt | awk '{print $NF}' | awk "NR==${SGE_TASK_ID}")
```

You can manually make this text file or use the R code to make one.

```R
path1 = "/dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown"  #dont include forward slash at end
listOfFiles = list.files(path1,pattern = glob2rx("*R.czi"),full.names=TRUE, recursive = TRUE) #recursive TRUE for subdirectories
write.table(listOfFiles,file = paste0(path1,"/segmentation_list.txt"), row.names = FALSE, col.names = FALSE, quote = FALSE)# stores the text file in the main data directory
```
