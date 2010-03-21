% PCA Face Recognition
% Kurt Glastetter and Josh Mason
clear;

faces_dir = 'lfw_faces';
test_faces_dir = 'lfw_test';
image_height = 130;
image_width = 110;
preprocess_func = @(im)(crop_approx_face_rectangle(im, image_height, ...
                                                   image_width));

%% read in faces
[fmatrix,names] = get_faces(faces_dir, preprocess_func);

%% perform PCA
[fmean U S V] = gm_pca(fmatrix,2);

% show mean face
%meanim = reshape(fmean,image_height,image_width);
%imshow(uint8(meanim));

%% read in test faces
[tfmatrix,tnames] = get_faces(test_faces_dir, preprocess_func);

%% do recognition and get back recognition matrix
% the last number specifies the k value for knn
[rmatrix nn] = gm_recognition(tfmatrix, fmean, U, V, tnames, names, 3);

%% calculate results
[results right wrong] = calc_results(rmatrix);

% dump num right/wrong to screen
[right wrong]
