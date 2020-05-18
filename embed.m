function [stegoimg,pidx]=embed(coverimg,msg,dmap)

h=10;
cover=uint8(single(logical(coverimg)));
cover=cover(:);
dmap=double(dmap(:));
msg=uint8(msg(:));

pidx=randperm(numel(cover));
cover(pidx)=cover;
dmap(pidx)=dmap;

[~, stego] = stc_embed(cover, msg, dmap, h);
stego=stego(pidx);

[h,w]=size(coverimg);
stegoimg=single(logical(reshape(stego,h,w)));
end