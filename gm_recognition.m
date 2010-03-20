% PCA Face Recognition
% Kurt Glastetter and Josh Mason

function rmatrix = gm_recognition(tfmatrix, fmean, U, V, tfiles, origfiles, k)

% get number of faces to recognize
sz = size(tfmatrix,2);

% for each test face
for i=1:1:sz
    % subtract mean image from test image
    W = tfmatrix(:,i) - fmean;
    
    % project test image onto U matrix
    v = U'*W;
    
    % calculate euclidian distance W's coeffs (v) to "orig" image's coeffs (V)
    d = sqrt(sum(abs(V' - repmat(v, [1 size(V,1)])).^2, 1));
    [c indices] = sort(d);
    
    % get the k nearest neighbors
    nn     = origfiles(indices(1:k));
    nnsize = size(nn,2);
    count  = containers.Map;
    curMax = 0;
    maxSubj = '';

    % count how many times each neighbor appears
    for j=1:nnsize
        subname = get_subjectname(char(nn(j)));
        if (~isKey(count, subname))
            count(subname) = 1;
        else
            count(subname) = count(subname) + 1;
        end
        
        % update subject who is the max
        % in cases where there is a tie, the first is used
        % which also corresponds to the subject with the lowest score.
        if (count(subname) > curMax)
           curMax = count(subname);
           maxSubj = subname;
        end
    end
    
    % fill in the recognition matrix with the name of the subject which was
    % tested in column 1 and the name of the subject we think it is most similar to
    % in column 2
    rmatrix(i,:) = [{get_subjectname(char(tfiles(i)))} {maxSubj}];
end

end
