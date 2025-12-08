function out = squashRepeats(vec)
    out = vec([true, diff(vec) ~= 0]);
end