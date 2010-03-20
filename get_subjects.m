% PCA Face Recognition
% Kurt Glastetter and Josh Mason

%% returns a map object that maps subject names onto cell arrays of image
%% filenames in that subject's directory.
function subjects = get_subjects(root_dir)

subjects = containers.Map();

files = dir(root_dir);

for i=1:size(files,1)
    if files(i).isdir && ~strcmp(files(i).name(1),'.')
        subject = files(i).name;
        subject_path = sprintf('%s/%s', root_dir, subject);

        image_filenames = get_image_filenames(subject_path);

        subjects(subject) = image_filenames;
    end
end

end
