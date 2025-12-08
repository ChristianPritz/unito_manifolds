function [alignedPC] = align_trajectories(smoothedPC,states_vec)
    numAnimals = numel(smoothedPC);
    % for i = 1:numAnimals
    %      sm = zscore(smoothedPC{i}, 0, 2); % z-score each dimension
    %      smoothedPC{i} = vertcat(sm,zscore(states_vec{i}));
    %  end
    
    % 3. Align other animals using Procrustes
    refTraj = smoothedPC{1};
    alignedPC = cell(1, numAnimals);
    alignedPC{1} = refTraj; % reference stays the same
    
    
    alignedPC{1} = refTraj(1:3,:);

    for i = 2:numAnimals
        fixed  = pointCloud(refTraj');
        moving = pointCloud(smoothedPC{i}');
        tform = pcregistericp(moving,fixed, 'Metric','pointToPoint', 'Extrapolate', true);
        
        % Transform moving cloud
        aligned = pctransform(moving, tform);

        % Project both into the shared canonical space
        alignedPC{i} = aligned.Location';
        % 
        % try
        % 
        %     [d, Z, transform] = procrustes(refTraj', smoothedPC{i}', 'Scaling', false, 'Reflection', false);
        %     alignedPC{i} = Z(:,1:3)'; % aligned trajectory
        % 
        % 
        % catch
        %     disp('ERROR')
        % end

    end
end

