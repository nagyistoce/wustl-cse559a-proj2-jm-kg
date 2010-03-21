function im = preprocess_image(input_im)

im = input_im;

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

end
