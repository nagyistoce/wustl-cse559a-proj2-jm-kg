% PCA Face Recognition
% Kurt Glastetter and Josh Mason

function [fmean U S V] = gm_pca(fmatrix, num_coeffs)

% get mean face (grrr)
fmean = mean(fmatrix,2);

% subtract mean face from each face
fmatrix2 = fmatrix - repmat(fmean,1,size(fmatrix,2));

% perform SVD, num_coeffs is number of coefficients to find, and num of basis
% images to create, this is arbitray...use more for better results
% D = USV
[U S V] = svds(fmatrix2,num_coeffs);

end

