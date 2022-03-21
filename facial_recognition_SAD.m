test='test\';
test_list = dir('test\*.bmp');%get all the data in dir
test_img=cell(99,13);%to store image data

training='training\';
training_list = dir('training\*.bmp');
training_img=cell(99,13);

for i= 1:99 %read image
    for j=1:13
        if i==1
            te_image_name =  [test test_list(j).name]; 
            tr_image_name =  [training training_list(j).name];
        else
            te_image_name =  [test test_list(j+13*(i-1)).name]; 
            tr_image_name =  [training training_list(j+13*(i-1)).name];        
        end
       test_img{i,j}= double(imread(te_image_name));
       training_img{i,j}= double(imread(tr_image_name));
    end
end

result = zeros(99,13,1287);
a = zeros(99,13);
for i=1:99
    for j=1:13
        for k=1:99
            for m=1:13
                diff_matrix = imabsdiff(test_img{k,m},training_img{i,j}); %Difference between the 2 numbers
                S=sum(diff_matrix,'all'); %sum
                if i==1
                    result(k,m,j) = S;
                else
                    result(k,m,j+13*(i-1)) = S;
                end
            end
         end
    end
end
corr = 0;
for i=1:99
    for j=1:13
        val = min(result,[],[1 2]);%find the minimum value
        if i==1
            [r,c] = find(result(:,:,j)==val(1,1,j));
        else
            [r,c] = find(result(:,:,j+13*(i-1))==val(1,1,j+13*(i-1)));
        end%find the location of minimum value(row is the result)
        a(i,j) = r(1);%store the result
        if a(i,j)==i
            corr = corr+1;%count the correct number
        end
    end
end

corr_rate = corr/1287;%Calculate the correct rate
fprintf('The correct rate of this program is %.2f%%\n',corr_rate*100);
