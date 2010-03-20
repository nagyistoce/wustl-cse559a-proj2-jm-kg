% PCA Face Recognition
% Kurt Glastetter and Josh Mason

%% returns a cell array containing the paths to all the image files in the
%% specified directory
function image_filepaths = get_image_filepaths(directory)

image_filepaths = {};

files = dir(directory);

for i=1:size(files,1)
    if ~files(i).isdir && ~strcmp(files(i).name(1),'.') && ...
            (~isempty(regexpi(files(i).name, '\.pgm$')) || ...
             ~isempty(regexpi(files(i).name, '\.jpg$')))

        filepath = sprintf('%s/%s', directory, files(i).name);
        image_filepaths{size(image_filepaths,2) + 1} = filepath;

    end
end

end
