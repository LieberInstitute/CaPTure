# To register green dynamic video frame by frame and then to the red static image

Matlab function [register2red](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/register2red.m)
in the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox) directory is used. 
Inputs to the [register2red](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/register2red.m) function are\
path to the green mat file `*1G.mat`, path to red czi files `*1R.czi`, path to the toolbox. 

```matlab
toolbox = '/dcl01/lieber/ajaffe/Maddy/Ca_Img/vignette/CaImg_cellcultures/toolbox';toolbox = '/Users/madhavitippani/Creative Cloud Files/toolbox';
greenmat = '/dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/Spinning_Disk/SS1903_83_Coffee_CS2_DIV70_1G.mat';
redczi = '/dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/Spinning_Disk/SS1903_83_Coffee_CS2_DIV70_1R.czi'; 

register2red(greenmat, redczi, toolbox)
Resgistering video
Starting parallel pool (parpool) using the 'local' profile ...
Connected to the parallel pool (number of workers: 12).
Elapsed time is 469.098559 seconds.

Resgistering video to red image
Reading Images:  1  of  1 Frames
Elapsed time is 62.176802 seconds.
```
