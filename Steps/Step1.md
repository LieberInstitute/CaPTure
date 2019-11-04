#To convert `.czi` time series to `.mat` files

Matlab function used to convert the file is [store_mat](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Scripts/store_mat.m)

Download the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox) directory to run the command. Inputs to the [store_mat](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Scripts/store_mat.m) function are paths to the [.czi](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/test_data/SS1803_50_Lime_A1_DIV42_1R.czi) file and the [bftools](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox/bfmatlab) package stored in the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox). 

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

If the conversion time is more batch run them using the [store_mat.sh]( bash script like below on jhpce

``` bash
[jhpce01 /dcl01/lieber/ajaffe/Maddy]$ qrsh /dcl01/lieber/ajaffe/Maddy/Ca_Img/code_pipeline/store_mat.sh
```

