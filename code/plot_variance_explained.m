function plot_variance_explained(explained,varargin)
    
    figure('WindowStyle','normal');
    bar(explained);
    ylabel('Variance explained');
    xlabel('Principal components (latent activities)');
    hold on
    cs = cumsum(explained);
    plot(1:numel(explained),cs);
    yline(cs(3),'Color',[0 0 0]);
    hold off
    title("How much of the population dynamics are encoded by each latent activity ")
    if numel(varargin) > 0
        xlim([0,varargin{1}])
    end

   


end