%coverDir = 'D:\QQMusicCache\课程资源\信息隐藏实验\信息隐藏\实验\cover9000\';
hssimDir = 'F:\lwten\SSIM_PSNR\dmapSSIM\result\';
hgmsdDir = 'F:\lwten\SSIM_PSNR\dmapGMSD\result\';
pmmtmDir = 'F:\lwten\分数融合\PMMTM\';

LENGTH = 4000;
outDir = './dmap';
if ~exist(outDir,'dir')
    mkdir(outDir);
end

parfor i = 1:LENGTH
    tStart = tic;
    imgname = [num2str(i),'.bmp'];
    matname = [num2str(i),'.mat'];
    if ~exist(fullfile(outDir,matname),'file')
        %img = imread(fullfile(coverDir,imgname));
        inPath_PMMTM = fullfile(pmmtmDir,matname);
        PMMTM = load(inPath_PMMTM);
        PMMTM = PMMTM.dmap;
        
        inPath_HSSIM = fullfile(hssimDir,matname);
        HSSIM = load(inPath_HSSIM);
        HSSIM = HSSIM.dmap;
        
        inPath_HGMSD = fullfile(hgmsdDir,matname);
        HGMSD = load(inPath_HGMSD);
        HGMSD = HGMSD.dmap;
        
        dmap = get_dmap(PMMTM,HSSIM,HGMSD);
        parsave(fullfile(outDir,matname),dmap);
        [imgname,'T:',num2str(toc(tStart))]
    end
end
