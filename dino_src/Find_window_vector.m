function v = Find_window_vector(p, image, m)

%will not include colors outside the image
[row, col, ~]=size(image);

%     if mod(m,2)==0, %even
%         left = floor(m/2)-1;
%         right = floor(m/2);
%     else
%         left = floor(m/2);
%         right = floor(m/2);
%     end
    left = floor(m/2)-1+mod(m,2);
    right = floor(m/2);
    row_range=min(row,max(1,floor(p(1))-left:floor(p(1))+right));
    col_range=min(col,max(1,floor(p(2))-left:floor(p(2))+right));
%     start_row = max(1,floor(p(1))-left);
%     end_row  = min(row,floor(p(1))+right);
%     start_col = max(1,floor(p(2))-left);
%     end_col = min(col, floor(p(2))+right);

    tmp=image(row_range,col_range,:);
    v=reshape(tmp,[],3);
%     v=zeros(m*m,3);
%     count=1;
%     for i=start_row:end_row,
%         for j=start_col:end_col,
%             v(count,:)=image(i,j,:);
%             count=count+1;
%         end
%     end
    
end