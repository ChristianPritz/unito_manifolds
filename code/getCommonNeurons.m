function [commonNrns] = getCommonNeurons(data)
%COMMON_NEURONS Summary of this function goes here
%   Detailed explanation goes here
    common_neurons = data(1).NeuronNames;


    for i=2:numel(data)
        disp('###########################################################')
        disp(i)
        disp('--------------------------------------------------------')
        disp(numel(common_neurons))
        
        disp(numel(common_neurons))
        
        disp(numel(data(i).NeuronNames))
        nrns = clean_neurons(data(i).NeuronNames);
        if i == 4
            disp('stop')
        end
        common_neurons = intersect(nrns,common_neurons);
        
    end
    commonNrns = {};
    for i=1:numel(common_neurons)
        if isempty(regexp(common_neurons{i}, '^\d+$', 'once'))
            commonNrns{end+1} = common_neurons{i};

        end
    end

end



