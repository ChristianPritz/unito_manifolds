function [data_out,int_time,states,state_vec,nrns] = getData(obj,index,sttngs)
    
    eval(['data = obj(index).',sttngs.property,';'])
    data = data';
    nrns = clean_neurons(obj(index).NeuronNames);
    fps = obj(index).fps;
    time = (1:size(data,2))/fps;
    int_time = min(time):1/sttngs.frameRate:max(time);
    data_out = nan(size(data,1),size(int_time,2));
    for i=1:size(data,1)
        data_out(i,:) = interp1(time,data(i,:),int_time);
    end
    [states,state_vec] = getStates(obj,index);
    state_vec = round(interp1(time,state_vec,int_time));
    %consistency check 
    length = size(data_out,2) == size(state_vec,2);
    nrns_check = numel(nrns) == size(data_out,1);
    %disp(['CONSISTENCY: data size ', num2str(length),' Nrns ', num2str(nrns_check)]);
    if sum(isnan(sttngs.interval)) ~= numel(sttngs.interval)
        data_out = data_out(:,sttngs.interval);
        state_vec = state_vec(:,sttngs.interval);
        int_time = int_time(:,sttngs.interval);
    end

end

function [fields,state_vec] = getStates(obj,index)

    fields = fieldnames(obj(index).States);
    eval(['st1 = obj(index).States.',fields{1},';'])
    state_vec = nan(size(st1));
    
    for i=1:numel(fields)
        eval(['stx = obj(index).States.',fields{i},';']);
        state_vec(stx==1) = i;
    end


end

