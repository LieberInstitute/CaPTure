# Calculate global synchronicity of events in a image

Matlab function [synchronicity](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/synchronicity.m)
in the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox) directory is used. 
Inputs to the [synchronicity](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/synchronicity.m) function are\
path to the events mat file `*events.mat`, ext - substring from the filename that describes thresholds used to detect events, analysis_type - 'correlation'. 

```matlab
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox';
filename = '/LieberInstitute/dotdotdot/tree/master/images/SS1803_50_Lime_A1_DIV42_1G_1corr_10f_0.6C_events.mat';
ext = '_10f_0.6C_events';
analysis_type = 'correlation';
synchronicity(filename, ext, analysis_type, toolbox)

Elapsed time is 10.036780 seconds.
```
