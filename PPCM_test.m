clc
clear

coverDir = 'F:\lwten\cover9000\';
outPath = './result_cover_PMMTM';
names = [num2str(1),'.bmp'];
if ~exist(outPath,'dir') 
    mkdir(outPath);
end
imPath = [coverDir,num2str(1),'.bmp'];
img = imread(imPath);
[f_cover,F_cover,P_cover] = PPCM(img);
%save(fullfile(outPath,[num2str(1),'_coverfea.mat']),'f_cover','names')