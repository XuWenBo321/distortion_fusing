function [] = gen_fea_cover(LENGTH,msglist)

coverdir = 'F:\lwten\cover9000\';
% stegoalldir = 'E:\研一\halftone亮哥\隐写方案Halftone_05_交换黑白（纵向)_修改(SSIM)\test\result\';
% stegoalldir = './resultGSM/';

outpathlist={'fea\chg_phdif\','fea\chg_RLGL\','fea\chg_RLCM\','feaGSM\chg_PPCM\',...
    'fea\LP\','fea\PPCM+LP\'};
for i=4
    if ~exist(outpathlist{i},'dir')
        mkdir(outpathlist{i});
    end
end

names=cell(LENGTH,1);
% names=cell(3040,1);

for msgl=msglist
    tag=['msgl',num2str(msgl)];
%     stegodir=[stegoalldir,tag];
%     F1=single(zeros(LENGTH,512));
%     F2=single(zeros(LENGTH,170));
%     F3=single(zeros(LENGTH,100));
    F4=single(zeros(LENGTH,320));
%     F5=single(zeros(LENGTH,32));
%     F6=single(zeros(LENGTH,352));
	cnt=1;
    for i=1:LENGTH
		try
        
%         stego=imread(fullfile(stegodir,[num2str(i,'%d'),'.bmp']));
        names{cnt}=[num2str(i,'%d'),'.bmp'];
        impath=[coverdir,num2str(i),'.bmp'];
        img = imread(impath);
        img = single(logical(img));
%         imshow(img);
%         dmappath=[dmapdir,num2str(i),'.mat'];
%         load(dmappath);
        tStart=tic;
%         msg{i}=randi([0,1],[1,msgl]);
%         refim=embed(img,msg{i},dmap);
%         F1(i,:)=chg_phdif(img,refim);
%         F2(i,:)=chg_RLGL(img,refim);
%         F3(i,:)=onetimeRLCMC(img);
        F4(cnt,:)=PPCMC(single(img));
%         F5(i,:)=L_histC_d(double(img));
%         F6(i,:)=[F4(i,:),F5(i,:)];
        [names{cnt},' T:',num2str(toc(tStart))]
        if mod(cnt,500)==0
%             F=F1;
%             save(fullfile(outpathlist{1},[tag,'_coverfea.mat']),'F','names','i')
%             F=F2;
%             save(fullfile(outpathlist{2},[tag,'_coverfea.mat']),'F','names','i')
%             F=F3;
%             save(fullfile(outpathlist{3},[tag,'_coverfea.mat']),'F','names','i')
            F=F4;
            save(fullfile(outpathlist{4},[tag,'_coverfea.mat']),'F','names','cnt')
%             F=F5;
%             save(fullfile(outpathlist{5},[tag,'_coverfea.mat']),'F','names','i')
%             F=F6;
%             save(fullfile(outpathlist{6},[tag,'_coverfea.mat']),'F','names','i')
        end
        cnt=cnt+1;
		catch
		end
    end
    % record stego feature
%     F=F1;
%     save(fullfile(outpathlist{1},[tag,'_coverfea.mat']),'F','names')
%     F=F2;
%     save(fullfile(outpathlist{2},[tag,'_coverfea.mat']),'F','names')
%     F=F3;
%     save(fullfile(outpathlist{3},[tag,'_coverfea.mat']),'F','names')
    F=F4;
    save(fullfile(outpathlist{4},[tag,'_coverfea.mat']),'F','names')
    cnt
%     F=F5;
%     save(fullfile(outpathlist{5},[tag,'_coverfea.mat']),'F','names')
%     F=F6;
%     save(fullfile(outpathlist{6},[tag,'_coverfea.mat']),'F','names')
end
end