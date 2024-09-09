function res = Otsu(image)
    
    [counts, bins] = imhist(image);
    totalPixels = size(image, 1) * size(image, 2);
    
    x = 0;
    for i = 1 : length(bins)
        x = x + bins(i) * counts(i);
    end
    
    sum_b = 0;
    b = 0;
    threshold = 0;
    max_sigma = 0;

    for i = 1 : length(bins)
        sum_b = sum_b + counts(i);
        sum_f = totalPixels - sum_b;

        avg_count_b = sum_b / totalPixels;
        avg_count_f = 1 - avg_count_b;
        
        b = b + counts(i) * bins(i);
        f = x - b;

        mean_b = b / sum_b;
        mean_f = f / sum_f;

        sigma = avg_count_f * avg_count_b * (mean_b - mean_f) ^ 2;

        if sigma > max_sigma
            max_sigma = sigma;
            threshold = bins(i);
        end
        
    end

    res = image > threshold;
end