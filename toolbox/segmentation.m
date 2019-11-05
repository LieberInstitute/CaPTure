function segmentation(filename,toolbox,microscope,T)

% redfiles = 'Y:\Calcium Imaging\Spinning_Disk_images\GABA_Glutamate_Antagonists_PTHS_hNeurons';
% ext = '*red.czi';
% outputpath = 'C:\Users\MBF User\Desktop\new';
% microscope = 'SD'
tic

addpath(genpath(toolbox))

warning('off','all');
out = ReadImage6D(filename); %read the file using bioformats toolbox
warning('on','all');

image6d = out{1}; %dims = series,time, z, c, x, y 
imgcherry = squeeze(image6d); %convert 6D to 2D
%imagesc(imgcherry)
imgcherry1 = imgcherry;
imgcherry = imhmin(imgcherry,2*std2(imgcherry));

if strcmp(microscope,'SD')
    ROIsize = 50;
elseif strcmp(microscope,'780')
    ROIsize = 2;
    imgcherry1 = mat2gray(imresize(imgcherry1,[256,256]));
    imgcherry = mat2gray(imresize(imgcherry,[256,256]));
elseif strcmp(microscope,'Chronic')
    ROIsize = 4;
end

thresh = [num2str(T), '*std2(imgcherry)'];
[r,c] = find(imgcherry == min(imgcherry(:))); %find the coordinates of the seed
J = regiongrowing(imgcherry,r(1),c(1),eval(thresh));
% J = regiongrowing(imgcherry,(1),(1),4*std2(imgcherry));

D = -bwdist(J);
 
if strcmp(microscope,'SD')
D = imimposemin(D,imextendedmin(D,2));
end
 
mask = watershed(D);
mask(J) = 0;

stats = regionprops(bwlabeln(mask),'Area','Centroid','Eccentricity','BoundingBox','MajorAxisLength','MinorAxisLength');
m = length(stats);

h = figure('visible','off');
subplot(2,3,1)
imshow(imgcherry1)
caxis([min(imgcherry1(:)) max(imgcherry1(:))/3])
title('Raw')

subplot(2,3,2)
imshow(imgcherry)
caxis([min(imgcherry(:)) max(imgcherry(:))/3])
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

close all
%clear all %#ok<CLALL>

toc
 end
 
