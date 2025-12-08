function plot_coeffs(coeffs,num_comps,nrns)
    
    for i=1:num_comps
        disp(i);
        fig = figure();
        hold on 
        cffs = coeffs(:,i);
        disp(cffs(1))
        [cffs,idx] = sort(cffs);
        nrns_i = nrns(idx);
        
        for j=1:numel(cffs)
            cffs(j);
            

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
        title(['Loadings on PC ',num2str(i)])
        hold off
    
    end
    



end