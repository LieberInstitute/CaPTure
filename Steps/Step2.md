#To segment the ROIs from the red image.

Matlab function used to convert the file is [segmentation](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/segmentation.m)
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
``
