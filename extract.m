function [msg]=extract(stegoimg,m,pidx)

h=10;
stego=uint8(single(logical(stegoimg)));
stego=stego(:);
stego(pidx)=stego;

msg=stc_extract(stego, m, h);
end