% Mean Face Recognition
% Kurt Glastetter and Josh Mason

subjects = keys(get_subjects('lfw_faces'));

mean_faces = zeros(130*110, size(subjects,2));

for ix=1:size(subjects,2)

    %% read in faces
    subject = subjects(ix);
    subject = subject{1};
    [fmatrix,names] = get_faces_lfw(sprintf('lfw_faces/%s', subject));

    % get mean face (grrr)
    fmean = mean(fmatrix,2);

    %% show mean face
    %meanim = reshape(fmean,130,110);
    %imshow(uint8(meanim));

    %% save the mean faces for later
    mean_faces(:, ix) = fmean;

end

%% read in test faces
[tfmatrix,tnames] = get_faces_lfw('lfw_test');

rmatrix = [];

for ix=1:size(tfmatrix,2)

    test_face = tfmatrix(:,ix);

    distancesSquared = sum((mean_faces - ...
                            repmat(test_face, [1 size(mean_faces,2)])).^2);

    [c index] = min(distancesSquared);

    true_subject = subjects(ix);
    found_subject = subjects(index);

    rmatrix = [rmatrix; {true_subject{1}, found_subject{1}}];

end

%% calculate results
[results right wrong] = calc_results(rmatrix);

% dump num right/wrong to screen
[right wrong]
