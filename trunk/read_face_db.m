function face_db = read_face_db()

num_subjects = 40;
num_images_per_subject = 10;
image_height = 112;
image_width = 92;

face_db = uint8(zeros(num_subjects, num_images_per_subject, ...
                      image_height, image_width));

for ix=1:num_subjects
    for jx=1:num_images_per_subject
        face_db(ix, jx, :, :) = imread(strcat('./orl_faces/s', int2str(ix), ...
                                              '/', int2str(jx), '.pgm'));
    end
end
