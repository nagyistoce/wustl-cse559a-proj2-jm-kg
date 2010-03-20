% PCA Face Recognition
% Kurt Glastetter and Josh Mason

%% read in face database from disk
% numimages is used when recursively calling this function, don't pass
% it as a param.
function [images,filenames] = get_faces(directory,preprocess)
numimages = 0;
images    = [];
filenames = {};

files = dir(directory);
sz    = size(files,1);

if (nargin == 1)
   preprocess = 0; 
end

for i=1 : 1:sz
    if (files(i).isdir && ~(strcmp(files(i).name,'.') || ...
            strcmp(files(i).name,'..') || ...
            strcmp(files(i).name,'.svn')))
        newdir = sprintf('%s/%s', directory, files(i).name);
        % recurse into directory and get additional images and add columns
        % to end
        [newimages,newfilenames] = get_faces(newdir,preprocess);
        images = [images,newimages];
        filenames = [filenames,newfilenames];
    else
        if (~isempty(strfind(files(i).name, '.pgm')) || ...
                ~isempty(strfind(files(i).name, '.jpg')))
            file = sprintf('%s/%s', directory, files(i).name);
            numimages = numimages + 1;            
            im = imread(file);
            
            % check if pre-processing needs to occur
            if (preprocess == 1)
               % instead of just using an edge map, we overlay the edge
               % map onto the original image.
               %em = edge(im,'canny');
               %im(em) = 255;
               
               % regular edge detection..
               %im = edge(im,'canny');
               
               % gaussian blur
               %h = fspecial('gaussian',10,10);
               %im = imfilter(im,h);
               
               %h = fspecial('log');
               %im = imfilter(im,h);
               
               % histogram equalization
               im = histeq(im);
               
              %imshow(im)
              %pause
            end
            
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
