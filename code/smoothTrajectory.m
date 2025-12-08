function [smoothed] = smoothTrajectory(traj,windowSize)
    smoothed = zeros(size(traj));
    for d = 1:size(traj,1)
        smoothed(d,:) = smooth(traj(d,:), windowSize, 'moving');
    end

end


