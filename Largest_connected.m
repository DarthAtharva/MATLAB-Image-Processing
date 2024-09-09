
function res = Largest_connected(img)
    
    no_of_components = 0;
    highest = 0;
    used = zeros(size(img, 1), size(img, 2));

    for i = 1 : size(img, 1)
        for j = 1 : size(img, 2)
            
            if used(i, j) == 0 && img(i, j) == 1 
                [x, used] = dfs(i, j, img, used);
                if x > highest
                    highest = x;
                end
                no_of_components = no_of_components + 1;
            end
        end
    end
    
    no_of_components
    res = highest
end

function [res, used] = dfs(x, y, img, used)
    sum = 1;
    
    if  x > size(img, 1) || y > size(img, 2) || y < 1 || x < 1 || used(x, y) == 1 || img(x, y) == 0
        res = 0;
    else
        used(x,y) = 1;

        [res, used] = dfs(x + 1, y, img, used);
        sum = sum + res;
        
        [res, used] = dfs(x, y + 1, img, used);
        sum = sum + res;

        [res, used] = dfs(x - 1, y, img, used);
        sum = sum + res;

        [res, used] = dfs(x, y - 1, img, used);
        sum = sum + res;
        
    end

    res = sum;
end
