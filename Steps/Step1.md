#To convert `.czi` time series to `.mat` files

Matlab function used to convert the file is [store_mat](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Scripts/store_mat.m)

Download the [toolbox] directory to run the command. Inputs to the [store_mat] function are paths to the `.czi` file and the [bftools] package stored in the [toolbox]. 

```matlab
toolbox = '/pathtotoolbox/toolbox';
filename = '/pathtofile/filename.czi';
bftools = '/pathtotoolbox/toolbox/bfmatlab';

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session

store_mat(filename, bftools)
```

