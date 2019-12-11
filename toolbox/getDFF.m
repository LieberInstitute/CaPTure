function getDFF(filename, tau, metric)
   tic
   load(filename);
     ROI = table2array(ROI);
     ROI = ROI(:,2:end);
    [T,m] = size(ROI);
    
    Fbar = ROI';
    for t = 1:T
       if strcmp(metric, 'mean')
          Fbar(:,t) = mean(Fbar(:,max(1,t-tau(1)/2):min(T,t+tau(1)/2)),2);
       elseif strcmp(metric, 'median')
          Fbar(:,t) = median(Fbar(:,max(1,t-tau(1)/2):min(T,t+tau(1)/2)),2);
       end
    end
    F0 = Fbar;
    for t =  1:T
       F0(:,t) = min(Fbar(:,max(1,t-tau(2)):t),[],2);
    end
    smoothTraces = (Fbar-F0)./F0;
    clear Fbar F0;
    
    dff = smoothTraces;
 
    figure('Visible','off')
 subplot('position',[0.03 0.02 0.95 0.95]);
 plot_counter = 0;
for i = 1:m
 plot(1:T,dff(i,:)+plot_counter,'r',[1 T], [plot_counter plot_counter] ,'k--')
 axis tight
 hold on
 plot_counter = plot_counter+max(max(dff))-min(min(dff));
end
 
str = ['Scale: ',num2str(min(min(dff))),' - ',num2str(max(max(dff)))];
title(str)
ylim([min(min(dff)) plot_counter])
ticc = max(max(dff))-min(min(dff));
yticks(max(max(dff)):ticc:ticc*m)
yticklabels(1:1:m)

set(gcf,'InvertHardCopy', 'off')
set(gcf,'Position',1.0e+03 *[0.0010    0.0410    2.5600    1.3273])
set(gcf,'PaperPosition',[0 0 10 m])

   saveas(gcf, [filename(1:end-10),'dff.jpg']);
   close all
   save([filename(1:end-10),'dff.mat'], 'dff', '-v7.3');
toc
end
