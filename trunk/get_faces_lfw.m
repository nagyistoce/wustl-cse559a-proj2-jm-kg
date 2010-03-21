% PCA Face Recognition
% Kurt Glastetter and Josh Mason

%% read in face database from disk
function [images,filenames] = get_faces_lfw(directory,image_adjust_func,preprocess)
numimages = 0;
images    = [];
filenames = {};

files = dir(directory);
sz    = size(files,1);

if (nargin == 2)
   preprocess = 0;
end

for i=1 : 1:sz
    if (files(i).isdir && ~(strcmp(files(i).name,'.') || ...
            strcmp(files(i).name,'..') || ...
            strcmp(files(i).name,'.svn')))
        newdir = sprintf('%s/%s', directory, files(i).name);
        % recurse into directory and get additional images and add columns
        % to end
        [newimages,newfilenames] = get_faces_lfw(newdir,image_adjust_func,preprocess);
        images = [images,newimages];
        filenames = [filenames,newfilenames];
    else
        if (~isempty(strfind(files(i).name, '.pgm')) || ...
                ~isempty(strfind(files(i).name, '.jpg')))
            file = sprintf('%s/%s', directory, files(i).name);
            numimages = numimages + 1;
            im = imread(file);
            im = image_adjust_func(im);

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
               %im = adapthisteq(im);
               %im = imadjust(im,stretchlim(im),[0 1]);

             % imshow(im)
             % pause
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
