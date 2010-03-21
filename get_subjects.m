% PCA Face Recognition
% Kurt Glastetter and Josh Mason

%% returns a map object that is keyed on subject names.
function subjects = get_subjects(root_dir)

subjects = containers.Map();

files = dir(root_dir);

for i=1:size(files,1)
    if files(i).isdir && ~strcmp(files(i).name(1),'.')
        subject = files(i).name;
        subject_path = sprintf('%s/%s', root_dir, subject);

        subjects(subject) = 42; % the answer!
    end
end

end
