function [] = gen_fea_stego(LENGTH, msglist)

% stegoalldir = 'E:\研一\halftone亮哥\隐写方案Halftone_05_交换黑白（纵向)_修改(SSIM)\test\result\';
stegoalldir ='./GMSD_SSIM_result/';

outpathlist={'fea\chg_phdif\','fea\chg_RLGL\','fea\chg_RLCM\','feaGSM\chg_PPCM\',...
    'fea\LP\','fea\PPCM+LP\'};
for i=4
    if ~exist(outpathlist{i},'dir')
        mkdir(outpathlist{i});
    end
end

% msg=cell(LENGTH,1);
names=cell(LENGTH,1);%return a LENGTH×1 array

for msgl=msglist
    tag=['msgl',num2str(msgl)];
    stegodir=[stegoalldir,tag];
%     dmapdir=[dmapalldir,'dmap_',tag];
%     F1=single(zeros(LENGTH,512));
%     F2=single(zeros(LENGTH,170));
%     F3=single(zeros(LENGTH,100));
    F4=single(zeros(LENGTH,320));
%     F5=single(zeros(LENGTH,32));
%     F6=single(zeros(LENGTH,352));
    cnt=1;
    for i=1:LENGTH
		try
        
        stego=imread(fullfile(stegodir,[num2str(i,'%d'),'.bmp']));
        stego = single(logical(stego));
        names{cnt}=[num2str(i,'%d'),'.bmp'];
%         load(fullfile(dmapdir,[num2str(i),'.mat']));
        tStart=tic;
%         msg{i}=randi([0,1],[1,msgl]);
%         refim=embed(stego,msg{i},dmap);
%         F1(i,:)=chg_phdif(stego,refim);
%         F2(i,:)=chg_RLGL(stego,refim);
%         F3(i,:)=onetimeRLCMC(stego);
        F4(cnt,:)=PPCMC(single(stego));
%         F5(i,:)=L_histC_d(double(stego));
%         F6(i,:)=[F4(i,:),F5(i,:)];
        [names{cnt},' T:',num2str(toc(tStart))]
        if mod(cnt,500)==0
%             F=F1;
%             save(fullfile(outpathlist{1},[tag,'_stegofea.mat']),'F','names','i')
%             F=F2;
%             save(fullfile(outpathlist{2},[tag,'_stegofea.mat']),'F','names','i')
%             F=F3;
%             save(fullfile(outpathlist{3},[tag,'_stegofea.mat']),'F','names','i')
            F=F4;
            save(fullfile(outpathlist{4},[tag,'_stegofea.mat']),'F','names','cnt')
%             F=F5;
%             save(fullfile(outpathlist{5},[tag,'_stegofea.mat']),'F','names','i')
%             F=F6;
%             save(fullfile(outpathlist{6},[tag,'_stegofea.mat']),'F','names','i')
        end
        cnt=cnt+1;
		catch
		end
    end
    % record stego feature
%     F=F1;
%     save(fullfile(outpathlist{1},[tag,'_stegofea.mat']),'F','names')
%     F=F2;
%     save(fullfile(outpathlist{2},[tag,'_stegofea.mat']),'F','names')
%     F=F3;
%     save(fullfile(outpathlist{3},[tag,'_stegofea.mat']),'F','names')
    F=F4;
    save(fullfile(outpathlist{4},[tag,'_stegofea.mat']),'F','names')
    cnt
%     F=F5;
%     save(fullfile(outpathlist{5},[tag,'_stegofea.mat']),'F','names')
%     F=F6;
%     save(fullfile(outpathlist{6},[tag,'_stegofea.mat']),'F','names')
end
end