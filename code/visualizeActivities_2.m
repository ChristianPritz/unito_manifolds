function visualizeActivities_2(data,nrns,fps,varargin)

    time = (1:size(data,2))/fps;

    fig = figure();
    imagesc(data)
    ax = gca;
    ax.YTick = 1:size(data,1);
    ax.YTickLabel = nrns;
    t_points = round(min(time):100:max(time));
    x_points = t_points*fps;
    ax.XTick = x_points;
    ax.XTickLabel = t_points;
    ylabel('Neurons');
    xlabel('time (s)');
    ax.TickDir = 'out';
    ax.LineWidth = 2;
    fig.Position = [318    13   860   862];
    colormap jet
    colorbar eastoutside
    ax.FontSize = 14;

    if numel(varargin) > 0
        fig = figure();
        ax = gca;
        plot(time,data(varargin{1},:))
        ylabel('Activity δF/F');
        xlabel('time (s)');
        title(['Activity of neuron: ',nrns{varargin{1}}])
        xlim([min(time),max(time)])
        ax.TickDir = 'out';
        ax.LineWidth = 2;
        ax.FontSize = 14;
        fig.Position = [316   532   851   246];
    end


end

