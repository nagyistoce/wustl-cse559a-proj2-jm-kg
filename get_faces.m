% PCA Face Recognition
% Kurt Glastetter and Josh Mason

%% read in face database from disk
function [images,filenames] = get_faces(directory,image_adjust_func)
numimages = 0;
images    = [];
filenames = {};

files = dir(directory);
sz    = size(files,1);

if (nargin == 1)
    image_adjust_func = @(im)(im); % do nothing
end

for i=1 : 1:sz
    if (files(i).isdir && ~(strcmp(files(i).name,'.') || ...
            strcmp(files(i).name,'..') || ...
            strcmp(files(i).name,'.svn')))
        newdir = sprintf('%s/%s', directory, files(i).name);
        % recurse into directory and get additional images and add columns
        % to end
        [newimages,newfilenames] = get_faces(newdir,image_adjust_func);
        images = [images,newimages];
        filenames = [filenames,newfilenames];
    else
        if (~isempty(strfind(files(i).name, '.pgm')) || ...
                ~isempty(strfind(files(i).name, '.jpg')))
            file = sprintf('%s/%s', directory, files(i).name);
            numimages = numimages + 1;
            im = imread(file);
            im = image_adjust_func(im);

            % add new image to new column in images
            images(:,numimages) = im(:);
            filenames(numimages) = {file};
            %imshow(file);
            %pause
        end
    end
end

end

% test code
% [images,names] = get_faces('att_faces');
% im301 = imread(char(names(301)));
% im301 = im301(:);
% isequal(im301,images(301)) % better be true
