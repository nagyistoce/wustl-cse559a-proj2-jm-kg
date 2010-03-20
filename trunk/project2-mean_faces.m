% PCA Face Recognition
% Kurt Glastetter and Josh Mason

subjects = keys(get_subjects('orl_faces'));

mean_faces = zeros(112*92, size(subjects,2));

for ix=1:size(subjects,2)

    %% read in faces
    subject = subjects(ix);
    subject = subject{1};
    [fmatrix,names] = get_faces(sprintf('orl_faces/%s', subject));

    %% perform PCA
    [fmean U S V] = gm_pca(fmatrix,30);

    %% show mean face
    %meanim = reshape(fmean,112,92);
    %imshow(uint8(meanim));

    %% save the mean faces for later
    mean_faces(:, ix) = fmean;

end

%% read in test faces
[tfmatrix,tnames] = get_faces('test_faces');

indexes = [];

for ix=1:size(tfmatrix,2)

    test_face = tfmatrix(:,ix);

    distancesSquared = sum((mean_faces - ...
                            repmat(test_face, [1 size(mean_faces,2)])).^2);

    [c index] = min(distancesSquared);

    indexes = [indexes; index];

end

indexes
