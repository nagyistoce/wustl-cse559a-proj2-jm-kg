% Mean Face Recognition
% Kurt Glastetter and Josh Mason

subjects = keys(get_subjects('orl_faces'));

mean_faces = zeros(112*92, size(subjects,2));

for ix=1:size(subjects,2)

    %% read in faces
    subject = subjects(ix);
    subject = subject{1};
    [fmatrix,names] = get_faces(sprintf('orl_faces/%s', subject));

    % get mean face (grrr)
    fmean = mean(fmatrix,2);

    %% show mean face
    %meanim = reshape(fmean,112,92);
    %imshow(uint8(meanim));

    %% save the mean faces for later
    mean_faces(:, ix) = fmean;

end

%% read in test faces
[tfmatrix,tnames] = get_faces('test_faces');

rmatrix = zeros(size(subjects,2),2);

for ix=1:size(tfmatrix,2)

    test_face = tfmatrix(:,ix);

    distancesSquared = sum((mean_faces - ...
                            repmat(test_face, [1 size(mean_faces,2)])).^2);

    [c index] = min(distancesSquared);

    rmatrix(ix,:) = [subjects(ix) subjects(index)];

end

%% calculate results
[results right wrong] = calc_results(rmatrix);

% dump num right/wrong to screen
[right wrong]
