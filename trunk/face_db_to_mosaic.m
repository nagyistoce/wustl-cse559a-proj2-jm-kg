function mosaic = face_db_to_mosaic(face_db)

[ num_faces, num_images_per_face, image_height, image_width ] = ...
    size(face_db);

mosaic = uint8(zeros(num_faces * image_height, ...
                     num_images_per_face * image_width));

for ix=1:num_faces
    for jx=1:num_images_per_face
        mosaic(((ix - 1) * image_height + 1) : (ix * image_height), ...
               ((jx - 1) * image_width + 1) : (jx * image_width)) = ...
            face_db(ix, jx, :, :);
    end
end
