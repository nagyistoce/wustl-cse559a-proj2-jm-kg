function face_db = read_face_db()

num_faces = 40;
num_images_per_face = 10;
image_height = 112;
image_width = 92;

face_db = uint8(zeros(num_faces, num_images_per_face, ...
                      image_height, image_width));

for ix=1:num_faces
    for jx=1:num_images_per_face
        face_db(ix, jx, :, :) = imread(strcat('./orl_faces/s', int2str(ix), ...
                                              '/', int2str(jx), '.pgm'));
    end
end
