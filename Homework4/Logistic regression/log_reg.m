data = importdata('data.txt');
[rows, cols] = size(data);
data_extra_col = [data ones(rows,1)];

labels = importdata('labels.txt');
 
% epsilon = 1e-5;
epsilon = input("Enter value for epsilon:" );

% maxiter = 1000;
maxiter = input("Enter maximum number of iterations:" );


n_arr = [200,500,800,1000,1500,2000];
error = zeros(size(n_arr));
test_data = data_extra_col(2001: 4601, :);
test_labels = labels(2001:4601, :);


k = 1;
% i = no. of rows of training data to be considered
for i = n_arr
    train_data = data_extra_col(1:i, :);
    train_labels = labels(1:i, :);
    weights = logistic_train(train_data, train_labels, epsilon, maxiter);
    y = test_data * weights;
    error(k) = norm(y - test_labels)/height(test_labels);
    k = k+1;
end

%plotting graph
figure()
p = plot(n_arr, error);
title('Plot for MSE vs Training samples');
ylabel('MSE');
xlabel('No. of training samples');
hold on;

%[0.0703295222151991,0.0435749148885583,0.0335967805073312,0.0281404824341349,0.0189131153717001,0.0136565583387275]1e-5 1000

%
%
