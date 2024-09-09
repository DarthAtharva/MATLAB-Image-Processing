function res = Connected_comp(img)
    
    str_ele = ones(3, 3);
    present = img;
    last = zeros(size(img, 1), size(img, 2));
    x = 0;

    while ~isequal(last, present)
        
        last = present;
        present = dilate_img(last, str_ele);
        present = present & last;
        x = x + 1;

    end
    res = present;
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