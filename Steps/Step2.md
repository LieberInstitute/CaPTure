#To segment the ROIs from the red image.

Matlab function used is [segmentation](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/segmentation.m)
in the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox) directory. 
Inputs to the [segmentation](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/segmentation.m) function are paths to the red image[*R.czi](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/test_data/SS1803_50_Lime_A1_DIV42_1R.czi) file,
[toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox),
microscope and threshold.

To run a single file on matlab
```matlab
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox';
filename = '/LieberInstitute/CaImg_cellcultures/tree/master/test_data/SS1803_50_Lime_A1_DIV42_1R.czi';
microscope = '780';
thresh = 4;

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session
segmentation(filename,toolbox,microscope,thresh)

Reading Images:  1  of  1 Frames
Elapsed time is 7.709206 seconds.
```
If the segmentation time is less use `for loop` to process the entire dataset file by file
```matlab

myfiles = dir('/PathToDataset/*R.czi');
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox'; 
microscope = '780';
thresh = 4;

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session

for i = 1:numel(myfiles)
filename = fullfile(myfiles(i).folder, myfiles(i).name);
segmentation(filename,toolbox,microscope,thresh)
disp(['Completed: file',num2str(i)])
end
```
If the segmentation time is more batch run all the files using the [segmentation.sh](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Bash_scripts/segmentation.sh) bash script like below on jhpce.

``` bash
[jhpce01 /dcl01/lieber/ajaffe/Maddy]$ qrsh /dcl01/lieber/ajaffe/Maddy/Ca_Img/code_pipeline/segmentation.sh
```
The bash script needs path to user created `logs` folder to store function progress and any errors. Line 6 and 7 in [segmentation.sh](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Bash_scripts/store_mat.sh)


