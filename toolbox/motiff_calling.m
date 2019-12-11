function motiff_calling(filename,toolbox,thr,W)
	
%myfiles = dir(fullfile(corrMaps,'*corr.mat'));
%disp(['total files :', num2str(numel(myfiles))])

S = fullfile(toolbox,'spikes.mat');
load(S)


W1 = 1:23;
disp('motifs 1 to 23 are used')	

fprintf('\n') 
disp(['Correlation cutoff = ', num2str(thr), ', Width threshold = ', num2str(W)])
	
	 
fprintf('\n') 
disp(filename)

tic
	load(filename,'dff1','Ca')
[m,T] = size(dff1);       

for i = 1:m, Caa(i,:) = max(Ca{i}(W1,:)); end
 A = zeros(size(Caa));
 A(Caa>thr) = 1;
 
 for ii = 1:m
     
 x = A(ii,:);
 
 B = (find(x));
 C = find(diff(B)<W/2 & diff(B)>1);
 for i = 1:numel(C)
     x(B(C(i)):B(C(i)+1)) = 1;
 end
 clear B C
 C = regionprops(bwlabeln(x));
 idx = find([C.Area]<W);
 x(ismember(bwlabeln(x),idx)) = 0;
 clear C idx
   
 C = regionprops(bwlabeln(x)); B1 = cat(1,C(:).BoundingBox); 
 if isempty(B1)||max(dff1(ii,:))<0.05, spks = []; else spks(1,:) = round(B1(:,1)); spks(diff(spks)<10) = []; end
 
 events{ii}.Location = spks;
 if isempty(spks)
 events{ii}.Width = [];
 else
 events{ii}.Width = cell2mat({C.Area});
 end
 
  A(ii,:) = x;
 
Call = Ca{ii}(W1,spks);
[r,~] = arrayfun(@(x) find(Call == max(Call(:,x))), 1:numel(spks), 'UniformOutput', false);
r = cat(1,r{:});
H(ii,:) = arrayfun(@(x) numel(r(r==x)),W1);
  clear B1 tmp spks C
end

disp('Identified events, building figure')	 

h = figure;set(h, 'Visible', 'off');
	  set(h,'Position',[1          41        1680         932])

	  subplot('Position',[0.050    0.1100    0.250    0.8150])

	  imagesc(flipud(A))
	  yticks(1:1:m)
	  yticklabels(sort((1:1:m),'descend'))
	  set(gca,'Fontsize',10) 
	  title(['corr of ', num2str(numel(spikes)),' motifs >',num2str(thr)], 'Fontsize', 20)

	  subplot('Position',[0.3000    0.1100    0.2500    0.8150])

	  plot_counter = 0;
	  for ii = 1:m
	    plot(1:T,dff1(ii,:)+plot_counter)
	    hold on
	    spks = events{ii}.Location;
	    plot([spks; spks],[repmat(min(dff1(:))+plot_counter,1,numel(spks)); repmat(max(dff1(:))+plot_counter,1,numel(spks))],'r')
	    plot_counter = plot_counter+max(max(dff1))-min(min(dff1));
	  end

	  ylim([min(min(dff1)) plot_counter])
	  ticc = max(max(dff1))-min(min(dff1));
	  yticks(max(max(dff1)):ticc:ticc*m)
	  yticklabels(1:1:m)
	  xlim([1 size(dff1,2)])
	  set(gca,'Fontsize',10) 
	  title(['Width threshold: ',num2str(W),'frames'], 'Fontsize', 20)% ,height: ', num2str(height)])


	  subplot('Position',[0.7000  0.5500    0.2500    0.3700])
	  bar(sum(H))
	  xticks(W1)
	  xticklabels(1:1:numel(W1))
	  title('histogram of motifs','Fontsize', 20)

	  subplot('Position',[0.7000    0.1100    0.2500    0.3700])
	  H2 = H./repmat(sum(H,2),1,numel(W1));
	  hb = bar(H2,'Stacked');
	  A = colorcube(numel(W1));
	  for k=1:numel(W1)
	    set(hb(k),'facecolor',A(k,:))
	  end
	  motif = compose('%d',(numel(W1):-1:1));
	  leg = legend(fliplr(hb),motif, 'Position',[0.95 0.20 0.04 0.200]);
	  title(leg,'motif')
	  xticks(1:m)
	  xticklabels(1:1:m)
	  ylim([0 1])

 
	  c=1:1:23;
	  s = 0;
	  for i = 1:numel(spikes)
	      subplot('Position',[0.5700    0.1100+s    0.1000    0.0354])
	      plot(spikes{c(i)})
	      xlim([0 max(250,length(spikes{c(i)}))+100])
	      ylim([min(spikes{c(i)}) max(spikes{c(i)})])
	      ylabel(num2str(c(i)))
	      set(gca, 'YTickLabel',[],'XTickLabel',[],'Box','off')
	      s = s+0.0354;
	  end
	  %set(gcf,'visible', 'on')
		  
	  %set(gcf,'Position',1.0e+03 *[0.0010    0.0410    2.5600    1.3273])
	  set(gcf,'InvertHardCopy', 'off')
	  %set(gcf,'PaperPosition',[0 0 80 m])

		  
save([filename(1:end-4),'_',num2str(W),'f_',num2str(thr),'C_events.mat'],'events','H')
saveas(gcf,[filename(1:end-4),'_',num2str(W),'f_',num2str(thr),'C_events','.jpg'])	

close all
fprintf('\n') 
toc
		
end

