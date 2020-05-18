function [fvec,F,P] = PPCM(im)
%PPCM Summary of this function goes here
%   Detailed explanation goes here

im=double(im);
im=1-im;
MAR=1;
[M,N]=size(im);
vmap=zeros(M,N);
% nearest padarrary
for i=1:MAR
    im=[im(1,1),im(1,:),im(1,end); ...
        im(:,1),im,im(:,end); ...
        im(end,1),im(end,:),im(end,end)];
end

masklist={[-inf,1,4; -inf,2,5; -inf,3,6], ...     % horizontal 1
    [6,3,-inf; 5,2,-inf; 4,1,-inf], ...     % horizontal 2
    [-inf,-inf,-inf; 3,2,1; 6,5,4], ...    % vertical 1
    [4,5,6; 1,2,3; -inf,-inf,-inf], ...    % vertical 2
    [-inf,1,-inf; 3,2,4; -inf,6,5], ...    % diagonal 1
    [5,6,-inf; 4,2,3; -inf,1,-inf], ...    % diagonal 2
    [-inf,3,-inf; 6,2,1; 5,4,-inf], ...    % minor diagonal 1
    [-inf,4,5; 1,2,6; -inf,3,-inf]};       % minor diagonal 2


%% step 1
% 1) features in horizontal 1 direction →
mask=2.^(masklist{1}-1);
for m=1:M
    for n=1:N
        subim=im(m:2*MAR+m,n:2*MAR+n);
        vmap(m,n)=sum(sum(subim.*mask));%状态号以左上角的像素为标准的3*3块
    end
end
T1=2^6;
F1=cell(1,8);
P1=cell(1,8);
[F1{1},P1{1}]=cooc(vmap,[0,0],[0,1],N-2,M,T1);
% features in horizontal 2 direction ←
mask=2.^(masklist{2}-1);
for m=1:M
    for n=1:N
        subim=im(m:2*MAR+m,n:2*MAR+n);
        vmap(m,n)=sum(sum(subim.*mask));
    end
end
[F1{2},P1{2}]=cooc(vmap,[0,1],[0,0],N-2,M,T1);
% 2) features in vertical 1 direction ↓
mask=2.^(masklist{3}-1);
for m=1:M
    for n=1:N
        subim=im(m:2*MAR+m,n:2*MAR+n);
        vmap(m,n)=sum(sum(subim.*mask));
    end
end
[F1{3},P1{3}]=cooc(vmap,[0,0],[1,0],N,M-2,T1);
% features in vertical 2 direction ↑
mask=2.^(masklist{4}-1);
for m=1:M
    for n=1:N
        subim=im(m:2*MAR+m,n:2*MAR+n);
        vmap(m,n)=sum(sum(subim.*mask));
    end
end
[F1{4},P1{4}]=cooc(vmap,[1,0],[0,0],N,M-2,T1);
% 3) features along main diagonal 1 ↘
mask=2.^(masklist{5}-1);
for m=1:M
    for n=1:N
        subim=im(m:2*MAR+m,n:2*MAR+n);
        vmap(m,n)=sum(sum(subim.*mask));
    end
end
[F1{5},P1{5}]=cooc(vmap,[0,0],[1,1],N-2,M-2,T1);
% features along main diagonal 2 ↖
mask=2.^(masklist{6}-1);
for m=1:M
    for n=1:N
        subim=im(m:2*MAR+m,n:2*MAR+n);
        vmap(m,n)=sum(sum(subim.*mask));
    end
end
[F1{6},P1{6}]=cooc(vmap,[1,1],[0,0],N-2,M-2,T1);
% 4) features along minor diagonal 1 ↙
mask=2.^(masklist{7}-1);
for m=1:M
    for n=1:N
        subim=im(m:2*MAR+m,n:2*MAR+n);
        vmap(m,n)=sum(sum(subim.*mask));
    end
end
[F1{7},P1{7}]=cooc(vmap,[0,1],[1,0],N-2,M-2,T1);
% features along minor diagonal 2 ↗
mask=2.^(masklist{8}-1);
for m=1:M
    for n=1:N
        subim=im(m:2*MAR+m,n:2*MAR+n);
        vmap(m,n)=sum(sum(subim.*mask));
    end
end
[F1{8},P1{8}]=cooc(vmap,[1,0],[0,1],N-2,M-2,T1);
F =F1; P = P1;
%% step 2
% 1) the 1st order features
cm=cell(1,2);
cm{1}=zeros(size(F1{1}));
cm{2}=cm{1};
for i=1:length(F1)
    P1{i}(P1{i}<1e-8)=inf;
    cm{ceil(i/4)} = cm{ceil(i/4)} + .25*F1{i}./repmat(P1{i},[1,size(F1{i},2)]);
end
% 2) eliminate zero entries 
% horizontal, vertical, diagonal and minor diagonal
%   y = floor(x/2^3)+e, e \in [0,7]*2^3
f=cell(1,length(cm));
for i=1:length(f)
    f{i}=zeros(size(cm{i})./[1,8]);
    for n=1:size(f{i},2)
        for m=1:size(f{i},1)
            f{i}(m,n)=cm{i}(m,8*(n-1)+ceil(m/8));
        end
    end
end
    
% % 2) merge similar pattern (mirror)
% horizontal and vertical
hlist=[0, 1, 2, 3, 5, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,21,23; ...
       0, 4, 2, 6, 5, 7,31,27,29,25,30,26,28,24,16,20,18,22,21,23];
fvec=cell(1,2);
for i=1:length(fvec)
    fvec{i}=zeros(size(hlist,2),size(f{i},2));
    for n=1:size(hlist,2)
        fvec{i}(n,:)=(f{i}(hlist(1,n)+1,:) + f{i}(63-hlist(1,n)+1,8:-1:1) + ...
            f{i}(hlist(2,n)+1,[1,5,3,7,2,6,4,8]) + f{i}(63-hlist(2,n)+1,9-[1,5,3,7,2,6,4,8]))/4;
    end
end

fvec=[fvec{1},fvec{2}];
fvec=fvec(:)';

end

function [F1,P1] = cooc(vmap, offx1, offy, cols, rows, T1)
%COOC Calculates number of 1st-order cooccurrences in the matrix DIFF
% [F1,P1] = cooc(vmap, offx1, offy, cols, rows, T1)
% ---------------------------------------
% IN
%   vmap - matrix within which x1 and y are calculated
%   offx1 - starting offset of sub-matrix of x1, offx1=[offx1_i,offx1_j]
%   offy - starting offset of sub-matrix of y, offy=[offy_i,offy_j]
%   cols - number of columns of submatrices x1 and y
%   rows - number of rows of submatrices x1 and y
%   T1 - range of DIFFerences in the 1st-order features
% OUT
%   F1 - probabilities of samples transition
%   P1 - probabilities of samples distribution
% ---------------------------------------
% *Calculates number of cooccurrences in the matrix vmap on the same offsets
% starting from offx1 and offy.
% Results are stored in F1 and P1

if rows+offx1(1)>size(vmap,1) || rows+offy(1)>size(vmap,1)  || ...
        cols+offx1(2)>size(vmap,2) || cols+offy(2)>size(vmap,2)
    error('offset overflows the vmap matrix')
end
    
% probabilities of samples transition
F1=zeros(T1,T1);
% probabilities of samples distribution
P1=zeros(T1,1);

for i=1:rows
    for j=1:cols
        dx1=vmap(offx1(1)+i,offx1(2)+j);
        P1(dx1+1) = P1(dx1+1)+1;
        dy=vmap(offy(1)+i,offy(2)+j);
        F1(dx1+1,dy+1)=F1(dx1+1,dy+1)+1;
    end
end

end

