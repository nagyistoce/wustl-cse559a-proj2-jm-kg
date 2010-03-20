% PCA Face Recognition
% Kurt Glastetter and Josh Mason

%% do face recognition (old, was calculating coeffs, but don't need to)
% first calculate the coefficients for all our faces by projecting them
% onto U.
% v = U'W
%sz = size(fmatrix,2);
%coeffs = [];
%for i=1:1:sz
%    coeffs(:,i) = U'*fmatrix(:,i);
%end

function rmatrix = gm_recognition(tfmatrix, fmean, U, V, tfiles, origfiles)

% get number of faces to recognize
sz = size(tfmatrix,2);

% for each test face
for i=1:1:sz
    % subtract mean image from test image
    W = tfmatrix(:,i) - fmean;
    
    % project test image onto U matrix
    v = U'*W;
    
    % calculate euclidian distance W's coeffs (v) to "orig" image's coeffs (V)
    d = sqrt(sum(abs(V' - repmat(v, [1 size(V,1)])).^2, 1));
    [c index] = min(d);
    
    % fill in the recognition matrix with the name of the file which was
    % tested in column 1 and the name of the file we think it is most similar to
    % in column 2
    rmatrix(i,:) = [tfiles(i) origfiles(index)];
end

end
