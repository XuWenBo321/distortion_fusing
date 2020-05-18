clear
clc

LENGTH=4000;
% msglist=[512, 1024, 1536, 2048, 3072, 4096, 5120, 6144];
% msglist=[512, 1536, 3072, 5120];
msglist=[256, 512]; %secret message
for i=1:length(msglist)
    gen_imset_stego(LENGTH,msglist(i));%Use stc embed the message
    gen_fea_cover(LENGTH,msglist(i));
    gen_fea_stego(LENGTH,msglist(i));
end