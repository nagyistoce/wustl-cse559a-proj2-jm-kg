% PCA Face Recognition
% Kurt Glastetter and Josh Mason
clear;

%% read in faces
[fmatrix,names] = get_faces('lfw_faces');

%% perform PCA
[fmean U S V] = gm_pca(fmatrix,2);

% show mean face
%meanim = reshape(fmean,130,110);
%imshow(uint8(meanim));

%% read in test faces
[tfmatrix,tnames] = get_faces('lfw_test');

%% do recognition and get back recognition matrix
% the last number specifies the k value for knn
[rmatrix nn] = gm_recognition(tfmatrix, fmean, U, V, tnames, names, 3);

%% calculate results
[results right wrong] = calc_results(rmatrix);

% dump num right/wrong to screen
[right wrong]
