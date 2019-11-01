function store_mat(filename,bftools)

addpath(genpath(bftools))
out1 = ReadImage6D(filename);
image6d1 = out1{1}; %dims = series,time, z, c, x, y
rawImg = permute(squeeze(image6d1),[2,3,1]);
name4 =fullfile(greenfiles, [name,'.mat']);
save(filename(1:end-4),'rawImg','-v7.3');

end
