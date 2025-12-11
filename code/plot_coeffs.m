function plot_coeffs(coeffs,num_comps,nrns)
    
    for i=1:num_comps
        fig = figure('WindowStyle','normal');
        hold on 
        cffs = coeffs(:,i);
        [cffs,idx] = sort(cffs);
        nrns_i = nrns(idx);
        
        for j=1:numel(cffs)
            if cffs(j) > 0
                color = [.05 .3 .92];
            else
                color = [.92 .42 .2];
            end
            h = barh(j,cffs(j),'FaceColor',color);
            h.LineStyle='none';
        end
        
        ax = gca;
        ax.YTick = 1:numel(nrns_i);
        ax.YTickLabel = nrns_i;
        ax.XAxis.Visible = 'off';
        title(['Loadings on latent activity ',num2str(i)])
        hold off
    
    end
    



end