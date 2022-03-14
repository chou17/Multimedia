clear,clc;

% 讀取圖像
Img = imread('柴犬飛飛.jpg');
imwrite(Img,'./result/柴犬飛飛.jpg');
%擴充3*3
img = double(Img);
img_add = img(2,:,:);
img_arr = [img_add;img];
img_add = img(639,:,:);
img_arr = [img_arr;img_add];

img_add = [img(1,1,:);img(:,2,:)];
img_add = [img_add;img(640,1,:)];
img_arr = [img_add img_arr];
img_add = [img(1,640,:);img(:,639,:)];
img_add = [img_add;img(640,640,:)];
img_arr = [img_arr img_add];

% 創建濾波器
W = fspecial('gaussian',[3,3]); 

for i=1:3
    for j=1:640
        for k=1:640
            matrix = img_arr(j:j+2,k:k+2,i);
            pixel_matrix = matrix .* W;
            img(j,k,i) = sum(pixel_matrix,'all');
        end
    end
end
imwrite(uint8(img),'./result/a_1.jpg');
[peaksnr, snr] = psnr(uint8(img), Img);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);

%擴充7*7
img_add = img(2:4,:,:);
img_arr = [img_add;img];
img_add = img(637:639,:,:);
img_arr = [img_arr;img_add];

img_add = [img(1:3,1:3,:);img(:,2:4,:)];
img_add = [img_add;img(638:640,1:3,:)];
img_arr = [img_add img_arr];
img_add = [img(1:3,638:640,:);img(:,637:639,:)];
img_add = [img_add;img(638:640,638:640,:)];
img_arr = [img_arr img_add];

% 創建濾波器
W = fspecial('gaussian',[7,7]); 

for i=1:3
    for j=1:640
        for k=1:640
            matrix = img_arr(j:j+6,k:k+6,i);
            pixel_matrix = matrix .* W;
            img(j,k,i) = sum(pixel_matrix,'all');
        end
    end
end
imwrite(uint8(img),'./result/a_2.jpg');
[peaksnr, snr] = psnr(uint8(img), Img);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);



%擴充13*13
img_add = img(2:7,:,:);
img_arr = [img_add;img];
img_add = img(634:639,:,:);
img_arr = [img_arr;img_add];

img_add = [img(1:6,1:6,:);img(:,2:7,:)];
img_add = [img_add;img(635:640,1:6,:)];
img_arr = [img_add img_arr];
img_add = [img(1:6,635:640,:);img(:,634:639,:)];
img_add = [img_add;img(635:640,635:640,:)];
img_arr = [img_arr img_add];

% 創建濾波器
W = fspecial('gaussian',[13,13]); 

for i=1:3
    for j=1:640
        for k=1:640
            matrix = img_arr(j:j+12,k:k+12,i);
            pixel_matrix = matrix .* W;
            img(j,k,i) = sum(pixel_matrix,'all');
        end
    end
end
imwrite(uint8(img),'./result/a_3.jpg');
[peaksnr, snr] = psnr(uint8(img), Img);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);

%b擴充3*3
img_arr = img_arr(6:647,6:647,:);


% 創建濾波器
W = fspecial('gaussian',[3,3],1); 

for i=1:3
    for j=1:640
        for k=1:640
            matrix = img_arr(j:j+2,k:k+2,i);
            pixel_matrix = matrix .* W;
            img(j,k,i) = sum(pixel_matrix,'all');
        end
    end
end
imwrite(uint8(img),'./result/b_1.jpg');
[peaksnr, snr] = psnr(uint8(img), Img);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);

% 創建濾波器
W = fspecial('gaussian',[3,3],30); 

for i=1:3
    for j=1:640
        for k=1:640
            matrix = img_arr(j:j+2,k:k+2,i);
            pixel_matrix = matrix .* W;
            img(j,k,i) = sum(pixel_matrix,'all');
        end
    end
end
imwrite(uint8(img),'./result/b_2.jpg');
[peaksnr, snr] = psnr(uint8(img), Img);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);

% 創建濾波器
W = fspecial('gaussian',[3,3],100); 

for i=1:3
    for j=1:640
        for k=1:640
            matrix = img_arr(j:j+2,k:k+2,i);
            pixel_matrix = matrix .* W;
            img(j,k,i) = sum(pixel_matrix,'all');
        end
    end
end
imwrite(uint8(img),'./result/b_3.jpg');
[peaksnr, snr] = psnr(uint8(img), Img);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);

%unsharp
img_blur = img;
img = 2*double(Img);
img_sharp = img-img_blur;
imwrite(uint8(img_sharp),'./result/d_unsharp.jpg');

Edge = [1,1,1;0,0,0;-1,-1,-1];
for i=1:3
    for j=1:640
        for k=1:640
            matrix = img_arr(j:j+2,k:k+2,i);
            pixel_matrix = matrix .* Edge;
            img(j,k,i) = sum(pixel_matrix,'all');
        end
    end
end
imwrite(uint8(img),'./result/d_edge.jpg');