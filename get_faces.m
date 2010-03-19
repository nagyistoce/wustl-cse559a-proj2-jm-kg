% PCA Face Recognition
% Kurt Glastetter and Josh Mason

%% read in face database from disk
% numimages is used when recursively calling this function, don't pass
% it as a param.
function [images,filenames] = get_faces(directory)
numimages = 0;
images    = [];
filenames = {};

files = dir(directory);
sz    = size(files,1);

for i=1 : 1:sz
    if (files(i).isdir && ~(strcmp(files(i).name,'.') || strcmp(files(i).name,'..')))
        newdir = sprintf('%s/%s', directory, files(i).name);
        % recurse into directory and get additional images and add columns
        % to end
        [newimages,newfilenames] = get_faces(newdir);
        images = [images,newimages];
        filenames = [filenames,newfilenames];
    else
        if (strfind(files(i).name, '.pgm'))
            file = sprintf('%s/%s', directory, files(i).name);
            numimages = numimages + 1;
            im = imread(file);
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
