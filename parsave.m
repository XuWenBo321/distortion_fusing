function [] = parsave(dir,dmap)
%save x,y in dir
% so I can save in parfor loop
save(dir,'dmap');
end