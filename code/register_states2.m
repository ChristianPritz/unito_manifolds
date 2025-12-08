function [regist_latents,regist_states,state_stats] = register_states2(state_vecs,latent,allStates,tol)
    
    %Gathering statistics on the overall states ...........................

    overallStates = [];
    for i = 1:numel(state_vecs)
        overallStates = horzcat(overallStates,state_vecs{i});
    end


    [reducedVec, lengths, startIdx, endIdx, nextValue] = compressStretches(overallStates);
    
    state_stats = nan(numel(allStates,1),3);
    for i=1:numel(allStates)
        idx = reducedVec == allStates(i); 
        state_stats(i,1) = nanmean(lengths(idx));
        state_stats(i,2) = nanstd(lengths(idx));
        if state_stats(i,2)  == 0
            disp('stop')
        end
        state_stats(i,3) = nansum(idx);


    end

    
    regist_latents = {};
    regist_states = {};
    for i = 1:numel(state_vecs)
        nu_latent = [];
        nu_states = [];
        [reducedVec, lengths, startIdx, endIdx, nextValue] = compressStretches(state_vecs{i});
        for j=1:numel(allStates)
            currentState = allStates(j);
            latent_patch = [];
            
            idx = reducedVec == currentState;
            idcs = find(idx==1);
            counter = 1;
            for k=idcs
                if lengths(k) > state_stats(j,1)-tol*state_stats(j,2) && lengths(k) < state_stats(j,1)+tol*state_stats(j,2) && ...
                    lengths(k) > 1
                    len = round(state_stats(j,1));
                    qDur = 1:len;
                    dur = len/lengths(k):len/lengths(k):len;

                    %interpolating the path segment
                    seg = latent{i}(:,startIdx(k):endIdx(k));
                    intSeg = nan(3,len);
                    intSeg(1,:) = interp1(dur,seg(1,:),qDur);
                    intSeg(2,:) = interp1(dur,seg(2,:),qDur);
                    intSeg(3,:) = interp1(dur,seg(3,:),qDur);
                    latent_patch(:,:,counter) = [intSeg,[nan;nan;nan]];
                    counter = counter+1;
                    
                end
                
                
            end
            state_k = repmat(currentState,1,size(latent_patch,2));
            latent_patch = nanmean(latent_patch,3);
            nu_states = horzcat(nu_states,state_k);
            nu_latent = horzcat(nu_latent,latent_patch);
            regist_latents{i} = nu_latent;
            regist_states{i} = nu_states;
        end


    end


end



