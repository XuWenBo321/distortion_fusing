function PMMTM = get_pmmtm(img)
img = double(logical(img));
val = 1;
PMMTM = ones(size(img));
for ii = 10:3:247
    for jj = 10:3:247
        [f_cover,F_cover,P_cover] = PPCM(img(ii-val:ii+val,jj-val:jj+val));
        for i = 1:3 %逐个翻转子块内像素，计算每一个像素翻转后的PMMTM
            for j = 1:3
                %img2 = img(ii-val:ii+val,jj-val:jj+val);
                img(ii-2+i,jj-2+j) = ~img(ii-2+i,jj-2+j);
                [f_stego,F_stego,P_stego] = PPCM(img(ii-val:ii+val,jj-val:jj+val));
                X = [f_cover;f_stego];
                PMMTM(ii-2+i,jj-2+j) = pdist(X,'euclidean');
                img(ii-2+i,jj-2+j) = ~img(ii-2+i,jj-2+j);
            end
        end        
    end
end
end