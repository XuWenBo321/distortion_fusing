function dmap = get_dmap(PMMTM,HSSIM,HGMSD)

dmap = ones(size(PMMTM));
val = 1;

for ii = 10:3:247
    for jj = 10:3:247
        tmp_pmmtm = PMMTM(ii-val:ii+val,jj-val:jj+val); %取3×3子块
        tmp_pmmtm = tmp_pmmtm(:)';
        [B1,I1] = sort(tmp_pmmtm);
        [~,pmmtm_order] = sort(I1);%将失真分数排序，返回排序号后的序号。
        
        tmp_hssim = HSSIM(ii-val:ii+val,jj-val:jj+val);
        tmp_hssim = tmp_hssim(:)';
        [B2,I2] = sort(tmp_hssim);
        [~,hssim_order] = sort(I2);
        
        tmp_hgmsd = HGMSD(ii-val:ii+val,jj-val:jj+val);
        tmp_hgmsd = tmp_hgmsd(:)';
        [B3,I3] = sort(tmp_hgmsd);
        [~,hgmsd_order] = sort(I3);
        
        w1 = pdist2(pmmtm_order,hssim_order,'euclidean');
        w2 = pdist2(pmmtm_order,hgmsd_order,'euclidean');
        %total = w1 + w2; %每种方案的融合的比例，如w1 / (w1 + w2),为方案1融合时所占的比例。
        %dmap(ii,jj) = (w1/total)*HSSIM(ii,jj) + (w2/total)*HGMSD(ii,jj); %逐像素的进行融合
        dmap(ii-val:ii+val,jj-val:jj+val) = (w1)*HSSIM(ii-val:ii+val,jj-val:jj+val) + (w2)*HGMSD(ii-val:ii+val,jj-val:jj+val); %逐子块进行融合
    end
end