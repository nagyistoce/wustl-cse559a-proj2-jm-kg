% PCA Face Recognition
% Kurt Glastetter and Josh Mason

function outIm = crop_approx_face_rectangle(im)
    outIm = im((125-65+1):(125+65), (125-55+1):(125+55));
end
