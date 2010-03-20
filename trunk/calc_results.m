% PCA Face Recognition
% Kurt Glastetter and Josh Mason

function [results right wrong] = calc_results(rmatrix)
    % we make the assumption that the subject of the image is
    % the directory above where the image is.

    % get total number of results
    sz = size(rmatrix,1);
    results = zeros(1,sz);
    
    for i=1:1:sz
       file1 = char(rmatrix(i,1));
       file2 = char(rmatrix(i,2));
       
       % this is a pretty (very) lazy algorithm...start at end of file1 and walk
       % backwards.  when we get to the first forward slash we record
       % the directory name until the next forward slash, then we look to
       % see if that name appears in file2.
       pathsz = size(file1,2);
       record = 0;
       subject = '';
       for j=pathsz:-1:1
           if (file1(j) == '/')
               if (record)
                  break;
               else
                  record = 1;   
               end
           end
           
           if (record)
               subject = sprintf('%c%s',file1(j),subject);
           end
       end
       
       % check if subject is in file2.  if the result of strfind is empty
       % then there was no match.
       results(i) = ~isempty(strfind(file2,subject));
    end
    
    results = results';
    
    % find finds non-zero elements
    right = size(find(results),1);
    wrong = sz - right;
end
