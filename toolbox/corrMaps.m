function corrMaps(filename, fps, height, toolbox)

load(fullfile(toolbox,'spikes.mat'))
setenv('TZ','America/New_York')
disp(['Original frame rate is ', num2str(fps), 'frames/sec. Interpolating to 10frames/sec.'])		
disp(['Constructing motiff*trace correlation maps, height threshold on dff = ',num2str(height)])

	
tic
load(filename)
[m,T]=size(dff);

for ii = 1:m
    x = dff(ii,:);
    x = interp1(1:T,x,1:fps/10:T);
    dff1(ii,:) = x;
    x = dff1(ii,:);
    parfor i=1:length(spikes)
        snippet = spikes{i};
        L = length(snippet);
        C = zeros(size(x));       
                       
                
        for j=1:length(x)-(L-1)
            x_snippet = x(j:j+L-1);
            if(range(x_snippet)>height)
                R = corrcoef(x_snippet,snippet);
                C(j) = R(1,2);
                
                if j == length(x)-(L-1)
                    for j1 = length(x)-(L-2):length(x)-round(L/2)
                        x_snippet = x(j1:end);
                        R = corrcoef(x_snippet,snippet(1:length(x_snippet)));
                        C(j1) = R(1,2);
                    end
                end
            end
         end
     Call(i,:) = C;
    end
        
    Ca{ii} = Call;
end

[m,T]=size(dff1);

h = figure;set(h, 'Visible', 'off');
subplot(1,3,1)
plot_counter = 0;
for ii = 1:m
  plot(1:T,dff1(ii,:)+plot_counter)
  hold on
  plot_counter = plot_counter+max(max(dff1))-min(min(dff1));
end

ylim([min(min(dff1)) plot_counter])
ticc = max(max(dff1))-min(min(dff1));
yticks(max(max(dff1)):ticc:ticc*m)
yticklabels(1:1:m)
xlim([1 size(dff1,2)])
set(gca,'Fontsize',10) 
title(['height: ', num2str(height)], 'Fontsize', 20)

subplot(1,3,2)
imagesc(flipud(cat(1,Ca{:})))
tmp = flipud(cat(1,Ca{:}));
yticks(1:size(Ca{1},1):size(tmp,1))
yticklabels(sort((1:1:m),'descend'))
set(gca,'Fontsize',10) 
title([num2str(size(Ca{1},1)),' motifs'], 'Fontsize', 20)
h =colorbar;
t=get(h,'Limits');
colorbar off

subplot(1,3,3)
for i = 1:m, Caa(i,:) = max(Ca{i}); end
Caa(Caa<0.6) = 0;
imagesc(flipud(Caa))
yticks(1:1:m)
yticklabels(sort((1:1:m),'descend'))
set(gca,'Fontsize',10) 
title(['corr of ', num2str(numel(spikes)),' motifs >0.6'], 'Fontsize', 20)
%h = colorbar;
caxis([t(1) t(2)])
%colorbar

 set(gcf,'InvertHardCopy', 'off')
 set(gcf,'Position',1.0e+03 *[0.0010    0.0410    2.5600    1.3273])
 set(gcf,'PaperPosition',[0 0 20 m])

save([filename(1:end-7),num2str(height),'corr.mat'],'Ca','dff1');
saveas(gcf,[filename(1:end-7),num2str(height),'corr.jpg'])	
		
close all
toc
end
