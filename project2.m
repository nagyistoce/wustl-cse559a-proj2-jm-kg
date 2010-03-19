% PCA Face Recognition
% Kurt Glastetter and Josh Mason
clear;

%% read in faces
[fmatrix,names] = get_faces('orl_faces');

%% perform PCA
[fmean U S V] = gm_pca(fmatrix);

% show mean face
%meanim = reshape(fmean,112,92);
%imshow(uint8(meanim));

%% read in test faces
[tfmatrix,tnames] = get_faces('test_faces');

%% do recognition and get back recognition matrix
rmatrix = gm_recognition(tfmatrix, fmean, U, V, tnames, names);
