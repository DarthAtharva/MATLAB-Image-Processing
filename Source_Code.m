rgbImage = imread("DIP_PROJECT/dip_image.jpg");

% Get the dimensions of the image
[rows, cols, ~] = size(rgbImage);

% Initialize the grayscale image matrix
grayImage = zeros(rows, cols, 'uint8');

% Convert RGB to grayscale
for i = 1:rows
    for j = 1:cols
        % Extract RGB values
        R = double(rgbImage(i, j, 1));
        G = double(rgbImage(i, j, 2));
        B = double(rgbImage(i, j, 3));
        
        % Convert to grayscale using luminosity method (weighted average)
        grayValue = uint8(0.2989 * R + 0.5870 * G + 0.1140 * B);
        
        % Assign the grayscale value to the corresponding pixel in the output matrix
        grayImage(i, j) = grayValue;
    end
end


%ADDING SALT AND PEPPER NOISE TO THE GRAY SCALE IMAGE
salt_limit = 0.15;
pepper_limit = 0.85;

salt_pepper = zeros(rows, cols, 'uint8');

for i = 1:rows
    for j = 1:cols
        randValue = rand(1,1);
        if randValue <= salt_limit
           salt_pepper(i, j) = 0;
        elseif randValue >= pepper_limit
           salt_pepper(i, j) = 255;
        else
           salt_pepper(i, j) = grayImage(i, j);
        end
    end
end


% Display the original and grayscale images
figure;
subplot(2, 4, 1);
imshow(rgbImage);
title('OriginalRGB ');
subplot(2, 4, 2);
imshow(grayImage);
title('Grayscale');
subplot(2, 4, 3);
imshow(salt_pepper);
title('Salt Pepper');


filtered_img = Amf(salt_pepper, rows, cols);
subplot(2, 4, 4);
imshow(filtered_img);
title('Filtered');

otsu_img = Otsu(filtered_img);
subplot(2, 4, 5);
imshow(otsu_img);
title('Otsu img');

str_ele = ones(5, 5, "uint8");
opened_img = Opening(otsu_img, str_ele);
subplot(2, 4, 6);
imshow(opened_img);
title('Opened ');

connected_img = Connected_comp(opened_img);
subplot(2, 4, 7);
imshow(connected_img);
title('Connected');

Largest_connected(connected_img);
