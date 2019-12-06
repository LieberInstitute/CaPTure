# To mark event location from the motiff*trace correlation heat maps

Matlab function [motiff_calling](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/motiff_calling.m)
in the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox) directory is used. 
Inputs to the [motiff_calling](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/motiff_calling.m) function are\
path to the correlation mat file `*corr.mat`, thr - correlation threshold to detect events, W - width threshold for event in frames (note the traces are interpolated to 10 frames/sec). 

```matlab
toolbox = '/Users/madhavitippani/Creative Cloud Files/toolbox';
filename = '/Users/madhavitippani/Creative Cloud Files/SS1803_50_Lime_A1_DIV42_1G_1corr.mat';
thr = 0.6;
W = 10;
motiff_calling(filename,toolbox,thr,W)

motifs 1 to 23 are used
Correlation cutoff = 0.6, Width threshold = 10
/Users/madhavitippani/Creative Cloud Files/SS1803_50_Lime_A1_DIV42_1G_1corr.mat
Identified events, building figure

Elapsed time is 10.036780 seconds.
```
