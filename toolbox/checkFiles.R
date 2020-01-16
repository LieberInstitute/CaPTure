###### check for green versus red files ###########

path1 = "/dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown"
listOFgreen = list.files(path1,pattern = glob2rx("*G.czi"),full.names=TRUE, recursive = FALSE)#recursive TRUE for subdirectories
listOFred = list.files(path1,pattern = glob2rx("*R.czi"),full.names=TRUE, recursive = FALSE)#recursive TRUE for subdirectories

listOFgreen = gsub("G.czi", "", listOFgreen)
listOFred = gsub("R.czi", "", listOFred)

# list of green files without red files #
missingRed = setdiff(listOFgreen, listOFred)
# list of red files without green files #
missingGreen = setdiff(listOFred, listOFgreen)

# cross check if files really dont exist # observed pattern = files ending with DIV63 followed by 3 or 4#
listOFmissinggreen = list.files(path1,pattern = "*DIV63_[3|4]G",full.names=TRUE, recursive = FALSE)

######## check if all red are processed ###########

listOFredProc = list.files(path1,pattern = glob2rx("*ROI_info_4.mat"),full.names=TRUE, recursive = FALSE)#recursive TRUE for subdirectories
listOFredProc = gsub("R_ROI_info_4.mat", "", listOFredProc)

missingProcRed = setdiff(listOFred, listOFredProc)

######## check if all green are processed ###########

listOFgreenProc = list.files(path1,pattern = glob2rx("*G.mat"),full.names=TRUE, recursive = FALSE)#recursive TRUE for subdirectories
listOFgreenProc = gsub("G.mat", "", listOFgreenProc)

missingProcGreen = setdiff(listOFgreen, listOFgreenProc)

######## final check if all green have events extracted ###########

listOFEvents = list.files(path1,pattern = glob2rx("*G_1corr_10f_0.6C_events.mat"),full.names=TRUE, recursive = FALSE)#recursive TRUE for subdirectories
listOFEvents = gsub("G_1corr_10f_0.6C_events.mat", "", listOFEvents)

missingEvents = setdiff(listOFgreen, listOFEvents)