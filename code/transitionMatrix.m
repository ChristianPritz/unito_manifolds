function [P,seqElements,rowMax] = transitionMatrix(vec)
    % vec = input vector of integers
    % P   = transition probability matrix (rows = from, cols = to)
    
    % find unique integers
    u = unique(vec);
    n = numel(u);
    
    % map vector to indices in u
    [~, idx] = ismember(vec, u);
    
    % initialize count matrix
    counts = zeros(n);
    
    % count transitions
    for k = 1:length(idx)-1
        counts(idx(k), idx(k+1)) = counts(idx(k), idx(k+1)) + 1;
    end
    
    % convert counts to probabilities
    P = counts ./ sum(counts,2);  % divide by row sum
    P(isnan(P)) = 0;              % handle rows with zero transitions

    % get the number most likely follow up. 
    rowMax = max(P,[],2);
    seqElements = nan(size(P,1),1);
    for i = 1:size(P,1)
        [~,seqElements(i)] = ismember(rowMax(i),P(i,:));
    end
    
end