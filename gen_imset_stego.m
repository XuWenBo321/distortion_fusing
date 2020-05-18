function [] = gen_imset_stego(LENGTH, msglist)
% 模拟嵌入
coverdir= 'F:\lwten\cover9000\';
dmapDir=  'F:\lwten\分数融合\dmap';
outDir='./GMSD_SSIM_result/';

for msgl=msglist
    tag=['msgl',num2str(msgl)];
    outdir=[outDir,tag];
    if ~exist(outdir,'dir')
        mkdir(outdir)
    end
    
    chg_amount = zeros(1, LENGTH);
    for i=1:LENGTH
        imgname=[num2str(i,'%d'),'.bmp'];%cover image
        matname=[num2str(i,'%d'),'.mat'];%corresponding dmap
        inpath=fullfile(coverdir,imgname);
        outpath=fullfile(outdir,imgname);
        img=imread(inpath);
        img=single(logical(img));
        tStart=tic;
        load(fullfile(dmapDir,matname));
%         dmap = dmap/241*13;
        dmap = dmap.^(1/2)+1/2;
        msg=randi([0,1],[1,msgl]);
%         [wdimg]=get_stego(img, msg, dmap);
        [wdimg]=embed(img, msg, dmap);
        chg_amount(i) = sum(sum(abs(img - wdimg)));
        
        [imgname, ' T: ', num2str(toc(tStart)), ' chg_amount: ', num2str(chg_amount(i))]
        imwrite(logical(wdimg),outpath,'bmp');
        
    end
    save(fullfile(outdir,['data.mat']), 'chg_amount')
end
end
