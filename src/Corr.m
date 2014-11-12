function corr = Corr(Cv)
    if size(Cv,2)==0,
        corr = 'NAN';
    else
        numerator = sum(Cv);
        denom = size(Cv,2);
        corr = numerator/denom;
    end
end