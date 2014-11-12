function conf = Conf(Cv_max, thresh, v_size)
    if size(Cv_max,2)==0,
        conf = 'NAN';
    else
        numerator = sum(Cv_max-thresh);
        denom = v_size*(1-thresh);
        conf = numerator/denom;
    end
end