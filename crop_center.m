% PCA Face Recognition
% Kurt Glastetter and Josh Mason

function outIm = crop_center(im, desired_height, desired_width)
    center_y = size(im,1)/2;
    center_x = size(im,2)/2;

    half_desired_height = desired_height/2;
    half_desired_width  = desired_width/2;

    top    = center_y - half_desired_height + 1;
    bottom = center_y + half_desired_height;
    left   = center_x - half_desired_width + 1;
    right  = center_x + half_desired_width;

    outIm = im(top:bottom, left:right);
end
