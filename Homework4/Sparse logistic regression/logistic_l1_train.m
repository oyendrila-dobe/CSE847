
opts.rFlag = 1; % range of par within [0, 1].
opts.tol = 1e-6; % optimization precision
opts.tFlag = 4; % termination options.
opts.maxIter = 5000; % maximum iterations.

data_az = importdata('ad_data.mat');
train_data = data_az.X_train;
train_labels = data_az.y_train;

par = [0, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
non_zero = zeros(length(par), 1);
AUC_arr = zeros(length(par),1);
k=1;
for i = par
    [w, c] = LogisticR(train_data, train_labels, i, opts);
    non_zero(k) = nnz(w);
    y = data_az.X_test * w;
    [~,~,~,AUC_arr(k)] = perfcurve(data_az.y_test, y , 1);
    k = k+1;
end