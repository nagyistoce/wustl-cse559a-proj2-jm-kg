% PCA Face Recognition
% Kurt Glastetter and Josh Mason

% gets the subjects name from the path
function name = get_subjectname(path)
    % this is a pretty (very) lazy algorithm...start at end of file1 and walk
    % backwards.  when we get to the first forward slash we record
    % the directory name until the next forward slash, then we look to
    % see if that name appears in file2.
    pathsz = size(path,2);
    record = 0;
    name = '';
    for j=pathsz:-1:1        
        if (path(j) == '/')
            if (record)
               break;
            else
               record = 1;   
            end
        end
        
        if (record)
            name = sprintf('%c%s',path(j),name);
        end
    end
    
    % strip off ending /
    name = name(1:size(name,2)-1);
end
