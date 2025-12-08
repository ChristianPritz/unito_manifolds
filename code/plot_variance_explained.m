function plot_variance_explained(explained,varargin)
    
    figure();
    bar(explained);
    ylabel('Variance explained');
    xlabel('Principal components');
    hold on
    cs = cumsum(explained);
    plot(1:numel(explained),cs);
    yline(cs(3),'Color',[0 0 0]);
    hold off

    if numel(varargin) > 0
        xlim([0,varargin{1}])
    end

   


end