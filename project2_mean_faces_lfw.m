% Mean Face Recognition
% Kurt Glastetter and Josh Mason

faces_dir = 'lfw_faces';
test_faces_dir = 'lfw_test';
image_height = 130;
image_width = 110;
preprocess_func = @(im)(crop_center(im, image_height, image_width));

subjects = keys(get_subjects(faces_dir));

mean_faces = zeros(image_height*image_width, size(subjects,2));

for ix=1:size(subjects,2)

    %% read in faces
    subject = subjects(ix);
    subject = subject{1};
    [fmatrix,names] = get_faces(sprintf('%s/%s', faces_dir, subject),...
                                preprocess_func);

    % get mean face (grrr)
    fmean = mean(fmatrix,2);

    %% show mean face
    %meanim = reshape(fmean,image_height,image_width);
    %imshow(uint8(meanim));

    %% save the mean faces for later
    mean_faces(:, ix) = fmean;

end

%% read in test faces
[tfmatrix,tnames] = get_faces(test_faces_dir, preprocess_func);

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
