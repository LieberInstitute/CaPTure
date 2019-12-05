# To generate correlation heat maps of motiffs across traces

Matlab function [corrMaps](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/corrMaps.m)
in the [toolbox](https://github.com/LieberInstitute/CaImg_cellcultures/tree/master/toolbox) directory is used. 
Inputs to the [corrMaps](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/toolbox/corrMaps.m) function are\
path to the dff mat file `*dff.mat`, fps (frame rate), height (background intensity). 

```matlab
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox';
filename = '/Users/madhavitippani/Creative Cloud Files/SS1803_50_Lime_A1_DIV42_1G_dff.mat';
height  = 1;
fps =  4;

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session

corrMaps(filename, fps, height, toolbox)
Original frame rate is 4frames/sec. Interpolating to 10frames/sec.
Constructing motiff*trace correlation maps, height threshold on dff = 1
Starting parallel pool (parpool) using the 'local' profile ...

connected to 2 workers.
Elapsed time is 53.418726 seconds.
```
```matlab
myfiles = dir('/PathToDataset/*dff.mat');
toolbox = '/LieberInstitute/CaImg_cellcultures/tree/master/toolbox'; 
height  = 1;
fps =  4;

addpath(genpath(toolbox)) %Add the toolbox to the matlab working directory when ever you begin a new session

for i = 1:numel(myfiles)
filename = fullfile(myfiles(i).folder, myfiles(i).name);
corrMaps(filename, fps, height, toolbox)
disp(['Completed: file',num2str(i)])
end
```
