# CaImg_cellcultures


Calcium imaging is a popular tool among neuroscientists because of its capability to monitor large neural populations across weeks with single neuron and single spike resolution. 
The technique measures the calcium ions (proxy for neuronal activity) by imaging fluorescence intensity in neurons loaded with calcium-sensitive dye.
Calcium imaging allows us to measure activity in single cells and have a measure of network dynamics. 

This repository describes steps to run Calcium Image processing data of human iPSC cultures across development.

[Step0](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Step0.md): Upload data to JHPCE cluster\
[Step1](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Step1.md): Convert .czi time series files to .mat files\
[Step2]: Parallel with step 1 run segmentation of the red image to get the ROI masks by adjusting thresholds based on scope\
[Step3]: Extract traces from step1 using masks from step2\
[Step4]: Extract dff from step3\
[Step5]: Construct correlation maps of dff traces from step4 using the motiff library\
[Step6]: Adjust correlation and intensity thresholds on heat maps from step5 to extract event location and duration\
[Step7]: Make custom matlab script to extract all the metrics foe entire dataset into table format\ 
[Step8]: Make custom R script for further analysis\

Additional scripts\
[Make a text file with list of czi files in the dataset]

