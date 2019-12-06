# To generate dff from raw traces

Matlab function [getDFF](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/getDFF.m)
in the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox) directory is used. 
Inputs to the [getDFF](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/getDFF.m) function are\
path to the extracted trace mat file `*trace.mat`, tau (rolling window length for dff calculation), metric (either 'mean' or 'median'). 

```matlab
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox';
filename = '/Users/madhavitippani/⁨Creative Cloud Files/SS1803_50_Lime_A1_DIV42_1G_traces.mat';
tau = [4 250];
metric = 'mean';

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session

getDFF(filename, tau, metric)
Elapsed time is 1.259078 seconds.
```

```matlab

myfiles = dir('/PathToDataset/*traces.mat');
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox'; 
tau = [4 250];
metric = 'mean';

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session

for i = 1:numel(myfiles)
filename = fullfile(myfiles(i).folder, myfiles(i).name);
getDFF(filename, tau, metric)
disp(['Completed: file',num2str(i)])
end
```
