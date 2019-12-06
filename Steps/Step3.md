# To extract traces from green time series using masks from red images

Matlab function [extract_traces](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/extract_traces.m)
in the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox) directory is used. 
Inputs to the [extract_traces](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/extract_traces.m) function are path to the green video mat file `*G.mat` file, sub strings in the red and green mat filenames that make them distinct. 

The output of this function produces a jpeg and a matfile with the same filename ending with `*traces` in the same directory as the input file. Jpeg shows traces of all the ROIs in the image while the matfile consists of a table named `ROI` with rows being timepoint and columns being the avergae intensity of all pixels of given ROI at a given timepoint.

For example if your green mat file is `SS1803_50_Lime_A1_DIV42_1G.mat` and the corresponding red mask file is [SS1803_50_Lime_A1_DIV42_1R_ROI_info_4.mat](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/test_data/SS1803_50_Lime_A1_DIV42_1R_ROI_info_4.mat). The resulting output files are [SS1803_50_Lime_A1_DIV42_1G_traces.mat](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/test_data/SS1803_50_Lime_A1_DIV42_1G_traces.mat) and [SS1803_50_Lime_A1_DIV42_1G_traces.jpg](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/test_data/SS1803_50_Lime_A1_DIV42_1G_traces.jpg).

To run a single file on matlab
```matlab
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox';
filename = '/LieberInstitute/CaImg_cellcultures/blob/master/test_data/SS1803_50_Lime_A1_DIV42_1G.mat';
green = 'G.mat';
red = 'R_ROI_info_4.mat';

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session

extract_traces(filename,green,red)
Elapsed time is 8.451488 seconds.
```

If the extraction time is less use `for loop` to process the entire dataset file by file
```matlab

myfiles = dir('/PathToDataset/*G.mat');
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox'; 
green = 'G.mat';
red = 'R_ROI_info_4.mat';

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session

for i = 1:numel(myfiles)
filename = fullfile(myfiles(i).folder, myfiles(i).name);
extract_traces(filename,green,red)
disp(['Completed: file',num2str(i)])
end
```
If the extraction time is more batch run all the files using the [extract_traces.sh](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Bash_scripts/extract_traces.sh) bash script like below on jhpce.

``` bash
[jhpce01 /dcl01/lieber/ajaffe/Maddy]$ qrsh /dcl01/lieber/ajaffe/Maddy/Ca_Img/code_pipeline/extract_traces.sh
```
The bash script needs path to user created `extract_logs` folder to store function progress and any errors. Line 6 and 7 in [extract_traces.sh](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Bash_scripts/extract_traces.sh)

```bash
#$ -o /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/extract_logs/$TASK_ID.txt
#$ -e /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/extract_logs/$TASK_ID.txt
```
It also needs a text file with list of all files to batch run. Line 22 and 27 in [extract_traces.sh](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Bash_scripts/extract_traces.sh)
```bash
echo "Sample id: $(cat /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/extract_traces_list.txt | awk '{print $NF}' | awk "NR==${SGE_TASK_ID}")"
FILE1=$(cat /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/extract_traces_list.txt | awk '{print $NF}' | awk "NR==${SGE_TASK_ID}")
```

You can manually make this text file or use the R code to make one.

```R
path1 = "/dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown"  #dont include forward slash at end
listOfFiles = list.files(path1,pattern = glob2rx("*G.mat"),full.names=TRUE, recursive = TRUE) #recursive TRUE for subdirectories
write.table(listOfFiles,file = paste0(path1,"/extract_traces_list.txt"), row.names = FALSE, col.names = FALSE, quote = FALSE)# stores the text file in the main data directory
```
