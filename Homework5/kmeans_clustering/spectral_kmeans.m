function [centers,total_sum] = spectral_kmeans(data,k)
    %plotting initial data with initial cluster centers
    tiledlayout(3,2);
    data = transpose(data);
    
    [~,~,V] = svd(data);
    reduced_V = V(:,1:k);
    ort = orth(randn(k,k));
    y_star = reduced_V * ort;
    
    cluster = zeros(length(y_star),1);
    random_cen = randsample(1:height(y_star),k);
    centers  = y_star(random_cen,:);
    ax1 = nexttile;
    hold on
    plot(ax1,y_star(:,1),y_star(:,2),'o');
    plot(ax1,centers(:,1),centers(:,2),'o', 'MarkerFaceColor', 'red');
    title(ax1,'Initial cluster centers')
    hold off
    
    cen_diff = zeros(k,width(y_star)); 
    %running k-means until centers stabilize
    while 1
        new_centers = zeros(k,width(y_star));
        %calculating membership
        for i = 1:height(y_star)
            diff = zeros(k,1);
            for j = 1:k
                diff(j) = ((y_star(i,1) - centers(j,1))^2 + (y_star(i,2) - centers(j,2))^2);
            end
            [~,index] = min(diff);
            cluster(i) = index;
            for loop = 1:width(y_star)
                new_centers(index,loop) = new_centers(index,loop) + y_star(i,loop); 
            end
        end
    
        %calculating new cluster centers
        for lo = 1:k
            for lo1 = 1:width(y_star)
                new_centers(lo,lo1) = new_centers(lo,lo1) / sum(cluster(:) == lo);
            end
            cen_diff(lo) = ((new_centers(lo,1) - centers(lo,1))^2 + (new_centers(lo,2) - centers(lo,2))^2);
        end
        if max(cen_diff) < 1e-7
            break
        else
            centers = new_centers;
        end
    end 
    
    
    total_sum = 0;
    %calculating SSE
    for lo = 1:k
        for lo1 = 1:height(cluster)
            if cluster(lo1) == lo
                for lo2 = 1:k
                    total_sum = total_sum + (y_star(lo1,lo2) - centers(lo,lo2))^2;
                end
            end
        end
    end
    
    %plotting final cluster centers 
    ax2 = nexttile;
    hold on
    plot(y_star(:,1),y_star(:,2),'o');
    plot(centers(:,1),centers(:,2),'o', 'MarkerFaceColor', 'red');
    %axis([0 500 0 500]);
    title(ax2,'Final cluster centers')
    hold off


    %plotting final cluster 
    
    ax3 = nexttile([2,2]);
    
    gscatter(ax3,y_star(:,1),y_star(:,2),cluster,hsv(5), '.');
    %gscatter(ax3,data(:,1),data(:,2),cluster,hsv(5), '.');
    legend('Location','southeastoutside')
    title(ax3,'Final clusters');
 
end