function res = Opening(image, str_ele)
  
    res = erode_img( image, str_ele);
    res = dilate_img( res, str_ele);

end

function res = erode_img( img, str_ele)
    
    padded_img = padarray(img, [floor(size(str_ele, 1) / 2 ), floor(size(str_ele, 2) /2)]);
    res = zeros(size(img, 1), size(img, 2));

    for i = 1 : size(padded_img, 1) - size(str_ele, 1) + 1
        for j = 1 : size(padded_img, 2) - size(str_ele, 2) + 1
            
            window = padded_img(i : i + size(str_ele, 1) - 1, j : j + size(str_ele, 2) - 1);

            if isequal(window, str_ele)
                res(i, j) = 1;
            else
                res(i, j) = 0;
            end
                
        end
    end
end

function res = dilate_img(img, str_ele)
    
    padded_img = padarray(img, [floor(size(str_ele, 1) / 2 ), floor(size(str_ele, 2) /2)]);
    res = zeros(size(img, 1), size(img, 2));
    
    for i = 1 : size(padded_img, 1) - size(str_ele, 1) + 1
        for j = 1 : size(padded_img, 2) - size(str_ele, 2) + 1
            
            window = padded_img(i : i + size(str_ele, 1) - 1, j : j + size(str_ele, 2) - 1);
            
            flag = false;

            for x = 1 : size(str_ele, 1)
                for y = 1 : size(str_ele, 2)
                    if str_ele(x, y) == window(x, y)
                        flag = true;
                        break;
                    end
                end
            end

            if flag == true
                res(i, j) = 1;
            else
                res(i, j) = 0;
            end
                
        end
    end
end