function v = Find_window_vector(p, image, m)
%untested!
%will not include colors outsdie the image
[row, col]=size(image);

    if mod(m,2)==0, %even
        left = floor(m/2)-1;
        right = floor(m/2);
    else
        left = floor(m/2);
        right = floor(m/2);
    end

    start_row = max(1,p(1)-left);
    end_row  = min(row,p(1)+right);
    start_col = max(1,p(2)-left);
    end_col = min(col, p(2)+right);
    [X,Y] = meshgrid(start_row:end_row,start_col:end_col);
    %check this!
    v = image((X,Y,:));
end