function corr = Corr(Cv)
    if size(Cv,2)==0,
        corr = NaN;
    else
        corr = mean(Cv);
    end
end