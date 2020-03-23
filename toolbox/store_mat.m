function store_mat(filename,bftools)

tic
warning('off','all');
addpath(genpath(bftools))
out1 = ReadImage6D(filename);
image6d1 = out1{1}; %dims = series,time, z, c, x, y
rawImg = permute(squeeze(image6d1),[2,3,1]);
save([filename(1:end-4),'.mat'],'rawImg','-v7.3');
warning('on','all');
toc

end
