function segmentation_spectral(filename,microscope,T)

toolbox = '/dcl01/lieber/ajaffe/Stephanie/CaImg_cellcultures-master/toolbox';
addpath(genpath(toolbox))

tic

	warning('off','all')
out = ReadImage6D(filename);
	warning('on','all')

X = out{2}.SizeX;
Y = out{2}.SizeY;
Z = out{2}.SizeZ;
%voxelSizeX = out{2}.ScaleX;
%voxelSizeY = out{2}.ScaleY;
%voxelSizeZ = out{2}.ScaleZ;
image6d = out{1}; %dims = series,time, z, c, x, y 
%list channels in spectral image, then define which should be used as
%segmentation
out{1,2}.Dyes = {'mRuby','cherry','residuals',};
d = find(cellfun(@(x) contains(x,"mRuby"), out{2}.Dyes), 1);

imgruby = squeeze(image6d(:,:,:,d,:,:))
imgruby1 = imgruby; 
imgruby = imhmin(imgruby,2*std2(imgruby));
ROIsize = 2;
    imgruby1 = mat2gray(imresize(imgruby1,[256,256]));
    imgruby = mat2gray(imresize(imgruby,[256,256]));
T = 4; 

disp('segmenting ruby')

thresh = [num2str(T), '*std2(imgruby)'];
[r,c] = find(imgruby == min(imgruby(:))); %find the coordinates of the seed
J = regiongrowing(imgruby,r(1),c(1),eval(thresh));
D = -bwdist(J);
mask = watershed(D);
mask(J) = 0;

stats = regionprops(bwlabeln(mask),'Area','Centroid','Eccentricity','BoundingBox','MajorAxisLength','MinorAxisLength');
m = length(stats);

h = figure('visible','off');
subplot(2,3,1)
imshow(imgruby1)
caxis([min(imgruby1(:)) max(imgruby1(:))/3])
title('Raw')
 
subplot(2,3,2)
imshow(imgruby)
caxis([min(imgruby(:)) max(imgruby(:))/3])
title('supress background')

subplot(2,3,3)
imshow(~J)
title(['threshold at ',thresh])

subplot(2,3,4)
imshow(label2rgb(bwlabeln(mask),'hsv','k', 'shuffle'))
if m==1
    ROI_info = stats; %#ok<*NASGU>
else 
    ROI_info = struct2table(stats);
end
for k = 1:m
    text(ROI_info.BoundingBox(k,1)+ROI_info.BoundingBox(k,3),ROI_info.BoundingBox(k,2)+ROI_info.BoundingBox(k,4),num2str(k), 'Color', 'white', 'Fontsize',7); 
end
title('watershed')

idx = find([stats.Area]>ROIsize);
BW2 = ismember(bwlabeln(mask),idx);
[l,m] = bwlabel(BW2);
stats = regionprops(l,'Area','Centroid','Eccentricity','BoundingBox','MajorAxisLength','MinorAxisLength');

subplot(2,3,5)
imshow(label2rgb(l,'hsv','k', 'shuffle'))
if m==1
    ROI_info = stats; %#ok<*NASGU>
else 
    ROI_info = struct2table(stats);
end
for k = 1:m
    text(ROI_info.BoundingBox(k,1)+ROI_info.BoundingBox(k,3),ROI_info.BoundingBox(k,2)+ROI_info.BoundingBox(k,4),num2str(k), 'Color', 'white', 'Fontsize',7); 
end
title('removed ROI<2 pixel volume')

idx = find([stats.Eccentricity]<0.99);
BW2 = ismember(bwlabeln(l),idx);
BW2 = imclearborder(BW2,8);

[l,m] = bwlabel(BW2);
stats = regionprops(l,'Area','Centroid','Eccentricity','BoundingBox','MajorAxisLength','MinorAxisLength','PixelList','PixelIdxList');

if m==1
    ROI_info = stats; %#ok<*NASGU>
else 
    ROI_info = struct2table(stats);
end

subplot(2,3,6)
imshow(label2rgb(l,'hsv','k', 'shuffle'))
for k = 1:m
    text(ROI_info.BoundingBox(k,1)+ROI_info.BoundingBox(k,3),ROI_info.BoundingBox(k,2)+ROI_info.BoundingBox(k,4),num2str(k), 'Color', 'white', 'Fontsize',7); 
end
title('removed eccentricity(ROI)>0.99 and cleared border ROIs')


name = filename(1:end-4); 
save([name,'_ROI_info_',num2str(T),'.mat'],'ROI_info')
set(gcf,'InvertHardCopy', 'off')
set(gcf,'Position', 1.0e+03 *[0.0010    0.0410    2.5600    1.3273])
saveas(gcf,[name,num2str(T),'.jpeg'])

clear out X Y Z image6d
