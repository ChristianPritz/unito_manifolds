function  plot_trajectories(latent_i,c,states)

    cmap = jet(max(c));  
    
    
    fig = figure();
    fig.Position = [499   265   733   600];
    

    % Define colormap (adjust if your c values differ)
    

    % Plot initial point
    hold on
    h2 = scatter3(latent_i(1,1), latent_i(2,1), latent_i(3,1), 500, '.', 'CData', [1 0 0]);
    % Set axis limits
    ax = gca;
    axis equal;
    ax = gca;
    

    ax.XLim = [min(latent_i(1,:)), max(latent_i(1,:))];
    ax.YLim = [min(latent_i(2,:)), max(latent_i(2,:))];
    ax.ZLim = [min(latent_i(3,:)), max(latent_i(3,:))];
    xlabel('latent 1');
    ylabel('latent 2');
    zlabel('latent 3');

    % Animate trajectory
    for i = 2:size(latent_i,2)-1
        % Draw line segment with color from c(i-1)
        plot3(latent_i(1,i-1:i), latent_i(2,i-1:i), latent_i(3,i-1:i), ...
              'Color', cmap(c(i-1),:), 'LineWidth', 2);
 
        % Update moving spot
        h2.XData = latent_i(1,i);
        h2.YData = latent_i(2,i);
        h2.ZData = latent_i(3,i);

    end
    hold off
    
    fig1 = figure();
    fig1.Position = [1251         447         112         413];
    states_vals = 1:max(c);

    imagesc(states_vals');
    colormap(cmap);
    ax1 = gca;
    ax1.YTick = states_vals;
    ax1.YTickLabel= states;

    figure()

    

end

