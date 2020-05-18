clc
clear
coverDir = 'F:\lwten\cover9000\';

LENGTH = 9000;
outDir = './PMMTM';
if ~exist(outDir,'dir')
   mkdir(outDir); 
end

parfor i = 6501:LENGTH
    tStart = tic;
    imgname = [num2str(i),'.bmp'];
    matname = [num2str(i),'.mat'];  
    if ~exist(fullfile(outDir,matname),'file')
        img = imread(fullfile(coverDir,imgname));
        pmmtm = get_pmmtm(img);
        parsave(fullfile(outDir,matname),pmmtm);
        [imgname,'T:',num2str(toc(tStart))];
    end
end