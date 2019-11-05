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

Additional Notes\
#To start command line matlab on jhpce follow these steps

```bash
Madhavis-MacBook-Pro:~ madhavitippan$ ssh -Y mtippani@jhpce01.jhsph.edu
Enter passphrase for key '/Users/madhavitippani/.ssh/id_rsa': Enter your password or SSH Key
Last login: Tue Nov  5 12:10:11 2019 from 10.194.129.92
JHPCE Centos 7 cluster
---
Use of this system constitutes agreement to adhere to all
applicable JHU and JHSPH network and computer use policies.
---
The shared queue is currently at 43% core occupancy and 32% RAM occupancy.
--------------------------------------
     Your Home Directory Usage        
Username    Space Used        Quota     
mtippani    5.85G             100G      
--------------------------------------
[jhpce01 /dcl01/lieber/ajaffe/Maddy]$ qrsh -l bluejay,mf=50G,h_vmem=50G
Last login: Mon Oct 21 12:50:11 2019 from jhpce01.cm.cluster
[compute-098 /dcl01/lieber/ajaffe/Maddy]$ matlab -nodesktop -softwareopengl -nosplash 
MATLAB is selecting SOFTWARE OPENGL rendering.

                                               < M A T L A B (R) >
                                     Copyright 1984-2019 The MathWorks, Inc.
                                     R2019a (9.6.0.1072779) 64-bit (glnxa64)
                                                  March 8, 2019

 
To get started, type doc.
For product information, visit www.mathworks.com.
 
>> 
```
Setting X11 Forwarding for GUI Applications https://www.hoffman2.idre.ucla.edu/access/x11_forwarding/
