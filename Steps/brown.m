path1 = '/dcl01/lieber/ajaffe/Maddy/Ca_Img/Stephanie/SCZ/Brown/';
ext = '*_1corr_10f_0.6C_events.mat';
ext1 = 'R_ROI_info_4.mat';
myfiles = dir(fullfile(path1,ext));	  
	
		b = 0;
		for F  = 1:numel(myfiles)
    
		man(F).name =  myfiles(F).name(1:end-numel(ext));
		x = strsplit(man(F).name,'_');
		man(F).maker =  x{1}(1:2); 
		man(F).batch = x{2};
		man(F).Line = x{3};
		man(F).Well = x{4};
		man(F).Field = x{6};
		man(F).DIV = x{5}(4:5);

		clear x

		filename = fullfile(myfiles(F).folder,myfiles(F).name);
		    load(filename)
		man(F).num_ROI = numel(events);
		man(F).num_active_ROI = nnz(cellfun(@(x) numel(x.Location), events));
		man(F).prop_active_ROI = man(F).num_active_ROI/man(F).num_ROI;
		man(F).events_ROI = sum(cellfun(@(x) numel(x.Location), events))/man(F).num_ROI;
		man(F).events_active_ROI = sum(cellfun(@(x) numel(x.Location), events))/man(F).num_active_ROI;
		man(F).events_width = nanmean(cellfun(@(x) nanmean(x.Width), events));
		man(F).motif = sum(H);

		filename = fullfile(myfiles(F).folder,[myfiles(F).name(1:end-4),'_corrSYN.mat']);
		load(filename)
		man(F).corrSYN = max(S.SI);

		filename = fullfile(path1,[man(F).name,ext1]);
		load(filename)

		for i = 1+b:numel(events)+b
		long_dat(i).name = man(F).name;
		long_dat(i).maker = man(F).maker; 
		long_dat(i).batch = man(F).batch;
		long_dat(i).Line = man(F).Line;
		long_dat(i).Well = man(F).Well;
		long_dat(i).Field = man(F).Field;
		long_dat(i).DIV = man(F).DIV;
		long_dat(i).events_ROI = numel(events{i-b}.Location);
		long_dat(i).avg_width = mean(events{i-b}.Width);
		long_dat(i).Volume = ROI_info.Area(i-b);
		long_dat(i).Eccentricity = ROI_info.Eccentricity(i-b);
		long_dat(i).motif = H(i-b,:);
		end

		b=b+numel(events);
		clearex  path1 myfiles F b long_dat man ext ext1
		end

	   	writetable(struct2table(man),fullfile(path1,'man_brown.csv'))
	   	writetable(struct2table(long_dat),fullfile(path1,'long_dat_brown.csv'))

	   	save(fullfile(path1,'man_brown.mat'),'long_dat','man')	 
	 
