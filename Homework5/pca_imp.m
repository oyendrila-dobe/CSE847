function error = pca_imp()
    mat = load('USPS.mat');
    data =mat.A;
    
    mean_data = mean(data); 
    data_centered = bsxfun(@minus,data,mean_data);
    %cov_mat = (data_centered' * data_centered )/(height(data) - 1);
    [~,~,V_t] = svd(data_centered);
    p = [10, 50, 100, 200];
    error = zeros(width(p),1);
    k=1;
    for m = p
        new_data = data_centered * V_t(:,1:m);
        new_data = new_data * transpose(V_t(:,1:m));
        img0 = reshape(new_data(1,:), [16,16]);
        img1 = reshape(new_data(301,:), [16,16]);
        img2 = reshape(new_data(601,:), [16,16]);
        img3 = reshape(new_data(901,:), [16,16]);
        img4 = reshape(new_data(1201,:), [16,16]);
        img5 = reshape(new_data(1501,:), [16,16]);
        img6 = reshape(new_data(1801,:), [16,16]);
        img7 = reshape(new_data(2101,:), [16,16]);
        img8 = reshape(new_data(2401,:), [16,16]);
        img9 = reshape(new_data(2701,:), [16,16]);
        
        figure;
        subplot(1,10,1);
        imshow(img0');
        subplot(1,10,2);
        imshow(img1');
        subplot(1,10,3);
        imshow(img2');
        subplot(1,10,4);
        imshow(img3');
        subplot(1,10,5);
        imshow(img4');
        subplot(1,10,6);
        imshow(img5');
        subplot(1,10,7);
        imshow(img6');
        subplot(1,10,8);
        imshow(img7');
        subplot(1,10,9);
        imshow(img8');
        subplot(1,10,10);
        imshow(img9');
        
        error(k) = sqrt(immse(data,new_data));
        k = k+1;      
    end    
    
    
end