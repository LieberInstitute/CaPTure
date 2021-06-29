# Installation steps

The pipeline is availble at (https://https://github.com/LieberInstitute/CaPTure) which can be download to your system from the Github website directly or the main repository can be cloned to your system using the following command on terminal/command prompt.

    `git clone https://github.com/LieberInstitute/CaPTure.git`

All the code exists in the [toolbox](https://github.com/LieberInstitute/CaPTure/tree/master/toolbox) directory inside the main [CaPTure](https://github.com/LieberInstitute/CaPTure/) directory. 
The user's working directory on `MATLAB` should be the path to the `toolbox` directory in the downloaded repository, to run any functions this pipeline provides. 

Once the repository is downloaded, the user can run either of the following code to change his/her working directory on MATLAB to the `toolbox` directory.

1. `cd /path_to_the_downloaded_repository/CaPTure/toolbox/`

2. `addpath(genpath('/path_to_the_downloaded_repository/CaPTure/toolbox/'))`


# Software
The pipeline was developed under the following software configuration.
\centering
![](images/Software_Configuration.png)
`CaPTure` has been tested on Linux, Windows and MacOS.

1. `MATLAB` 

MATLAB version R2017a 64-bit or later is required to run CaPTure pipeline with the [Image Processing Toolbox](https://www.mathworks.com/products/image.html) preloaded. 

2. `Memory` 

Minimum RAM required 8GB (thrice the size of the raw file, ~3GB) 
