function extract_traces(filename,old,new)
tic
Dfilename = filename;
for df= 1:numel(old)
filename1 = strrep(Dfilename,old{df},new{df});
Dfilename = filename1;
end

if isfile(filename1)

load(filename, 'rawImg')
load(filename1, 'ROI_info')

m = size(ROI_info,1);
[~,~,T]= size(rawImg);
ROI = (zeros(T,m));

indices = ROI_info.PixelIdxList;

for M = 1:m
 for z = 1:T
  x = rawImg(:,:,z);
  ROI(z,M) = mean(x(indices{M}),'native');
 end
end


 figure('Visible','off')
 subplot('position',[0.03 0.02 0.95 0.95]);
 plot_counter = 0;
 ticc = max(ROI(:))-min(ROI(:));

for ploti = 1:m
    plot(ROI(:,ploti)+plot_counter);
    axis tight
    hold on
    plot_counter = plot_counter+ticc;
end
str = ['Scale ',num2str(min(ROI(:))),'-',num2str(max(ROI(:)))];
title(str)
YAxis.FontSize = 5;
ylim([min(ROI(:)) plot_counter+max(ROI(:))])
yticks(max(ROI(:)):ticc:ticc*m)
yticklabels(1:1:m)

% set(gca,'TickDir', 'out')
set(gcf,'InvertHardCopy', 'off')
set(gcf,'Position',1.0e+03 *[0.0010    0.0410    2.5600    1.3273])
set(gcf,'PaperPosition',[0 0 10 m])

figname = [filename(1:end-4),'_traces.jpg'];
print(figname,'-djpeg')
close all

ROI = [table((1:1:T)','VariableNames',{'timepoint'}) array2table(ROI)];
save([filename(1:end-4),'_traces.mat'],'ROI');

  else
    disp(['Red image for file ',filename(1:end-4),' does not exist'])
end

toc
end
