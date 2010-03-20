% PCA Face Recognition
% Kurt Glastetter and Josh Mason

%% returns a cell array containing the names of all the image files in the
%% specified directory
function image_filenames = get_image_filenames(directory)

image_filenames = {};

files = dir(directory);

for i=1:size(files,1)
    if ~files(i).isdir && (~isempty(regexpi(files(i).name, '\.pgm$')) || ...
                           ~isempty(regexpi(files(i).name, '\.jpg$')))

        image_filenames{size(image_filenames,2) + 1} = files(i).name;

    end
end

end
