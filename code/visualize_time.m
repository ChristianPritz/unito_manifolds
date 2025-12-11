function visualize_time(latent_i,c,states,fps,varargin)
    existingAxes = false;
    for i=1:numel(varargin)
        if strcmp(varargin{i},'axes')
            existingAxes = true;
            exFig = varargin{i+1}{1};
            exAx = varargin{i+1}{2};
        end
    end
    

    hold_time = 1/fps;
    cmap = jet(max(c));  
    
    if existingAxes
        fig = exFig;
        ax = exAx;
        axes(ax)
        plot([]) %lazy work around
        hold on 
    else
        fig = figure('WindowStyle','normal');
        fig.Position = [499   265   733   600];
        hold on
        plot([]) %lazy work around
        ax = gca;
    end

    % Define colormap (adjust if your c values differ)
    

    % Plot initial point
    
    h2 = scatter3(ax,latent_i(1,1), latent_i(2,1), latent_i(3,1), 500, '.', 'CData', [1 0 0]);
    % Set axis limits
    
    axis equal;
   
    ax.XLim = [min(latent_i(1,:)), max(latent_i(1,:))];
    ax.YLim = [min(latent_i(2,:)), max(latent_i(2,:))];
    ax.ZLim = [min(latent_i(3,:)), max(latent_i(3,:))];
    % 
    % xl = xlim;
    % yl = ylim;
    % zl = zlim;
    % 
    % plot3([xl(1) xl(2)], [0 0], [0 0], 'k', 'LineWidth',1.5) % X-axis
    % plot3([0 0], [yl(1) yl(2)], [0 0], 'k', 'LineWidth',1.5) % Y-axis
    % plot3([0 0], [0 0], [zl(1) zl(2)], 'k', 'LineWidth',1.5) % Z-axis

    % Animate trajectory
    xlabel('latent 1');
    ylabel('latent 2');
    zlabel('latent 3');
    for i = 2:size(latent_i,2)-1
        if hold_time > 0.0001
            axes(ax)
            pause(hold_time);
        end
        % Draw line segment with color from c(i-1)
        %disp(c(i-1))
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

end