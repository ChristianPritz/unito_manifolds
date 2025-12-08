function [reducedVec, lengths, startIdx, endIdx, nextValue] = compressStretches(vec)
    % vec = input vector
    if isempty(vec)
        reducedVec = [];
        lengths = [];
        startIdx = [];
        endIdx = [];
        nextValue = [];
        return;
    end

    % find where value changes
    changeIdx = [1, find(diff(vec) ~= 0) + 1, numel(vec)+1];
    
    nStretch = numel(changeIdx)-1;
    
    reducedVec = zeros(1,nStretch);
    lengths = zeros(1,nStretch);
    startIdx = zeros(1,nStretch);
    endIdx = zeros(1,nStretch);
    nextValue = nan(1,nStretch); % nan for last stretch
    
    for i = 1:nStretch
        startI = changeIdx(i);
        endI = changeIdx(i+1)-1;
        reducedVec(i) = vec(startI);
        lengths(i) = endI - startI + 1;
        startIdx(i) = startI;
        endIdx(i) = endI;
        
        if i < nStretch
            nextValue(i) = vec(changeIdx(i+1)); % value of next stretch
        end
    end
end
