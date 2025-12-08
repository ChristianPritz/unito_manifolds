function nrns = clean_neurons(nrns)

    for i=1:numel(nrns)
        if iscell(nrns{i})
            nrns{i} = nrns{i}{1};
        end
    end
end