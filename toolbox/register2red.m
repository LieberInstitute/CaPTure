function register2red(greenmat, redczi, toolbox)
addpath(genpath(toolbox))

    Mobj = matfile(greenmat);
    [x,y,t] = size(Mobj.rawImg);

    [optimizer, metric] = imregconfig('monomodal');
    regcorr = zeros(3,3,t);
    regcorr(:,:,1) = eye(3);
    
    disp('Resgistering video')
    tic
    parfor ii = 2:t
        lastFrame = Mobj.rawImg(:,:, ii-1);
        nextFrame = Mobj.rawImg(:,:, ii);
        tform = imregtform(nextFrame, lastFrame, 'translation', optimizer, metric);
        regcorr(:,:,ii) = tform.T;
    end
    
    regcorrComposed = zeros(size(regcorr));
    regcorrComposed(:,:,1) = eye(3);
    
    for ii = 2:t
        regcorrComposed(:,:,ii) = regcorrComposed(:,:,ii-1)*regcorr(:,:,ii);
    end
    
    regSeries = zeros(x, y, t);
    regSeries(:,:,1) = Mobj.rawImg(:,:, 1);
    rfixed = imref2d([x y]);
    
    parfor ii = 2:t
        frame = Mobj.rawImg(:,:, ii);
        mn = min(frame(:));
        tform = affine2d(regcorrComposed(:,:,ii));
        frame = imwarp(frame, tform, 'OutputView', rfixed);
        frame(frame<mn) = mn;
        regSeries(:,:,ii) = frame;
    end
    toc
    
    disp('Resgistering video to red image')
    tic
    seriesMed = median(regSeries, 3);
    [optimizer, metric] = imregconfig('multimodal');
    
    out1 = ReadImage6D(redczi);
    image6d1 = out1{1}; %dims = series,time, z, c, x, y
    im = squeeze(image6d1);
    tform = imregtform(seriesMed, im, 'translation', optimizer, metric);
    
    parfor ii = 1:t
        frame = regSeries(:,:,ii);
        mn = min(frame(:));
        frame = imwarp(regSeries(:,:,ii), tform, 'OutputView', rfixed);
        frame(frame<mn) = mn;
        regSeries(:,:,ii) = frame;
    end
    
    regSeries = uint16(regSeries);
    toc 
    
    rawIMG = max(Mobj.rawImg,[],3);
    save([greenmat(1:end-4), '_registered.mat'], 'regSeries', '-v7.3');
    GreenReg = regcorr;
    RedReg = tform.T;
    save([greenmat(1:end-4), '_TranslationMatrices.mat'], 'GreenReg', 'RedReg', '-v7.3');
    
 B = imfuse(im,rawIMG,'ColorChannels',[1 2 0]);             
 A = imfuse(im,max(regSeries,[],3),'ColorChannels',[1 2 0]);

 imwrite([B;ones(10,y,3)*2000;A],[greenmat(1:end-4),'_registered2red.png']);
end
