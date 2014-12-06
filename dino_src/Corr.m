function corr = Corr(Cv)
    if size(Cv,2)==0,
        corr = 0;
    else
        corr = mean(Cv);
    end
end