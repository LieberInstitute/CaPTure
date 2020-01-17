function synchronicity(filename, ext, analysis_type, toolbox)	
addpath(genpath(toolbox))
	tic
load(filename)
spnks = cellfun(@(x) x.Location, events, 'UniformOutput',false);

filename1 = strrep(filename,ext,"");
disp(filename)
disp(filename1)

load(filename1,'dff1')

[m,T] = size(dff1);

dff1(isnan(dff1)) = 0;
		
s.phase = [];
s.F_cell = dff1;
s.Spikes_cell = spnks;
s.fps = 10;

S = SCA(s,analysis_type);

f = figure('units','normalized','outerposition',[0 0 1 1],'Visible','off');
h = subplot(2,2,1);
imagesc(S.C,[0 1]); axis square; colorbar;
h0 = subplot(2,2,3);
[~,pos] = max(S.PI,[],2);
[~,IDX] = sort(pos);
imagesc(S.C(IDX,IDX),[0 1]); axis square; colorbar;
yticks(h0,1:1:(size(S.C,1)*1))
yticklabels(h0,IDX)
xticks(h0,1:1:(size(S.C,1)*1))
xticklabels(h0,IDX)

h1 = subplot(2,2,[2,4]);
plot_counter = 0;

[m,T] = size(dff1);

for ploti = 1:m
    plot(1:T,dff1(ploti,:)+plot_counter,'linewidth',1);   
    axis tight
    hold on
    spks = events{ploti}.Location;
    plot([spks; spks],[repmat(min(dff1(:))+plot_counter,1,numel(spks)); repmat(max(dff1(:))+plot_counter,1,numel(spks))],'r')
    plot_counter = plot_counter+max(max(dff1))-min(min(dff1));
end

ylim([min(min(dff1)) plot_counter])
ticc = max(max(dff1))-min(min(dff1));
yticks(max(max(dff1)):ticc:ticc*m)
yticklabels(1:1:m)
xlim([1 size(dff1,2)])
set(gca,'Fontsize',10) 

title(h0,sprintf("Global Synchronicity Index = %.2f", max(S.SI)))
title(h1,sprintf("Number of clusters = %d", S.Num))
set(gcf,'InvertHardCopy', 'off')
box off
set(gca,'TickDir','out');

save([filename,'_SCA.mat'],'S')	
saveas(gcf,[filename,'_SCA.mat'])

close all
toc

end

		