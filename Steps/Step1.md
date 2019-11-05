#To convert `.czi` time series to `.mat` files

Matlab function used to convert the file is [store_mat](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/store_mat.m)

Download the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox) directory to run the command. Inputs to the [store_mat](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/store_mat.m) function are paths to the [.czi](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/test_data/SS1803_50_Lime_A1_DIV42_1R.czi) file and the [bftools](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox/bfmatlab) package stored in the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox). 

To run a single file on matlab
```matlab
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox';
filename = '/LieberInstitute/CaImg_cellcultures/tree/master/test_data/SS1803_50_Lime_A1_DIV42_1G.czi';
bftools = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox/bfmatlab';

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session
store_mat(filename, bftools)
```

If the conversion time is less use for loop to convert the entire data set file by file

```matlab

myfiles = dir('/PathToDataset/*G.czi');
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox'; 
bftools = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox/bfmatlab';

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session

for i = 1:numel(myfiles)
filename = fullfile(myfiles(i).folder, myfiles(i).name);
store_mat(filename, bftools)
end
```

If the conversion time is more batch run all the files using the [store_mat.sh](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Bash_scripts/store_mat.sh) bash script like below on jhpce.

``` bash
[jhpce01 /dcl01/lieber/ajaffe/Maddy]$ qrsh /dcl01/lieber/ajaffe/Maddy/Ca_Img/code_pipeline/store_mat.sh
```
The bash script needs path to user created `logs` folder to store function progress and any errors. Line 6 and 7 in [store_mat.sh](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Bash_scripts/store_mat.sh)

``` bash
#$ -o /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/storemat_logs/$TASK_ID.txt
#$ -e /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/storemat_logs/$TASK_ID.txt
```
It also needs a text file with list of all files to batch run. Line 21 and 25 in [store_mat.sh](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Bash_scripts/store_mat.sh)
```bash
echo "Sample id: $(cat  /dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/Brownlist.txt | awk '{print $NF}' | awk "NR==${SGE_TASK_ID}")"
```
You can manually make this text file or use the following `R` code to make one.

``` R
path1 = "/dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown"  #dont include forward slash at end
listOfFiles = list.files(path1,pattern = glob2rx("*G.czi"),full.names=TRUE, recursive = TRUE) #recursive TRUE for subdirectories
write.table(listOfFiles,file = paste0(path1,"/store_mat_list.txt"), row.names = FALSE, col.names = FALSE, quote = FALSE)# stores the text file in the main data directory
```
