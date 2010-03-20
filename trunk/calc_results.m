% PCA Face Recognition
% Kurt Glastetter and Josh Mason

function [results right wrong] = calc_results(rmatrix)
    % we make the assumption that the subject of the image is
    % the directory above where the image is.

    % get total number of results
    sz = size(rmatrix,1);
    results = zeros(1,sz);
    
    for i=1:1:sz
       sub1 = char(rmatrix(i,1));
       sub2 = char(rmatrix(i,2));
       
       % check if subject is in file2.  if the result of strfind is empty
       % then there was no match.
       results(i) = strcmp(sub1,sub2);
    end
    
    results = results';
    
    % find finds non-zero elements
    right = size(find(results),1);
    wrong = sz - right;
end
