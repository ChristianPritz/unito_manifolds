function [acts] = purge_neurons(acts,nrns,c_nrns,varargin)
    

        
        [yn,loc]=ismember(c_nrns,nrns);
        acts = acts(loc,:);
        if numel(varargin) > 0
            visualizeActivities_2(acts,c_nrns,varargin{1});
        end

end

