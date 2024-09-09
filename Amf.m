function y = Amf(noisy_img, rows, cols)
    
    max_filter_size = 9;
    padded_img = padarray(noisy_img, [floor(max_filter_size/2), floor(max_filter_size/2)]);
    
    filtered_img = zeros(rows, cols, 'uint8');
    
    for i = 1 : rows
        for j = 1 : cols
            x = i + floor(max_filter_size / 2) - 1;
            y = j + floor(max_filter_size / 2) - 1;
            for window_size = 3 : 2 : max_filter_size

                window = padded_img(x : x + window_size - 1, y : y + window_size - 1);
                window = reshape(window', 1, []);
                sorted_window = sort(window);

                res = lvl_a(sorted_window, window_size * window_size, noisy_img(i, j));
              
                x = x - 1;
                y = y - 1;
                
                if res ~= -1
                    filtered_img(i, j) = res;
                    break;
                end

                if window_size == max_filter_size
                   filtered_img(i, j) = noisy_img(i, j);
                end
            end

        end
    end

    y = filtered_img;
end
    
function res = lvl_a(window, size, val)
    
    med = floor(size / 2) + 1;
   
    if window(1) < window(med) && window(med) < window(size)
        res = lvl_b(window, size, val);
    else
        res = -1;
    end
end

function res = lvl_b(window, size, val)
    med = floor(size / 2) + 1;

    if window(1) < val && val < window(size)
        res = val;
    else
        res = window(med);
    end
end