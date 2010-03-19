function mosaic = face_db_to_mosaic(face_db)

[ num_subjects, num_images_per_subject, image_height, image_width ] = ...
    size(face_db);

mosaic = uint8(zeros(num_subjects * image_height, ...
                     num_images_per_subject * image_width));

for ix=1:num_subjects
    for jx=1:num_images_per_subject
        mosaic(((ix - 1) * image_height + 1) : (ix * image_height), ...
               ((jx - 1) * image_width + 1) : (jx * image_width)) = ...
            face_db(ix, jx, :, :);
    end
end
