# CaPTure <img src="images/logo.png" align="right" width="150px"/>

Welcome to `CaPTure`! 

Calcium imaging is a popular tool among neuroscientists because of its capability to monitor large neural populations across weeks with single neuron and single spike resolution. 
The technique measures the calcium ions (proxy for neuronal activity) by imaging fluorescence intensity in neurons loaded with calcium-sensitive dye.
Calcium imaging allows us to measure activity in single cells and have a measure of network dynamics. 

This repository describes steps to run Calcium Image processing data of human iPSC cultures across development.

[Installation](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Installation.md): Software requirements and installation\
[Step0](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Step0.md): Upload data to JHPCE cluster\
[Step1](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Step1.md): Convert .czi time series files to .mat files\
[Step2](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Step2.md): Parallel with step 1 run segmentation of the red image to get the ROI masks by adjusting thresholds based on scope\
[Step3](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Step3.md): Extract traces from step1 using masks from step2\
[Step4](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Step4.md): Extract dff from step3\
[Step5](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Step5.md): Construct correlation maps of dff traces from step4 using the motiff library\
[Step6](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Step6.md): Adjust thresholds for motiff correlation and event duration on heat maps from step5 to extract event location and duration\
[Synchronicity](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Synchronicity.md): Quantify how synchronous are events between the ROIs of a given field\
[Step7](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/brown.m): Make custom matlab script to extract all the metrics for entire dataset into table format\
[Step8](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Step8.md): Make custom R script for further analysis\
[Registration](https://github.com/LieberInstitute/CaImg_cellcultures/blob/master/Steps/Registration.md): Register green videos from spinning disk microscope.

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


# Cite `CaPTure` {-}

We hope that [`CaPTure`] will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!
```
@article {Tippani2021,
	author = {Tippani, Madhavi and Pattie , Elizabeth A. and Davis, Brittany A. and Nguyen, Claudia V. and Wang, Yanhong and Sripathy, Srinidhi Rao and Maher, Brady J.      Martinowich, Keri and Jaffe, Andrew E. and Page, Stephanie C.},
	title = {CaPTure: Calcium Peak Toolbox for analysis of in vitro calcium imaging data},
	year = {2021},
	doi = {TODO},
	publisher = {Cold Spring Harbor Laboratory},
	URL = {TODO},
	journal = {bioRxiv}
}
```
Project lead: [Madhavi Tippani](https://twitter.com/MadhaviTippani), Staff Scientist I and [Stephanie C. Page], Staff Scientist II in the **Imaging Development Group** at the [Lieber Institute for Brain Development](https://www.libd.org/).
<center>
<img src="http://lcolladotor.github.io/img/LIBD_logo.jpg" width="250px">
</center>
