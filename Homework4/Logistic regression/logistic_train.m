function [weights] = logistic_train(data, labels, epsilon, maxiter)
%
% INPUTS:
% data = n * (d+1) matrix withn samples and d features, where
% column d+1 is all ones (corresponding to the intercept term)
% labels = n * 1 vector of class labels (taking values 0 or 1)
% epsilon = optional argument specifying the convergence
% criterion - if the change in the absolute difference in
% predictions, from one iteration to the next, averaged across
% input features, is less than epsilon, then halt
% (if unspecified, use a default value of 1e-5)
% maxiter = optional argument that specifies the maximum number of
% iterations to execute (useful when debugging in case your
% code is not converging correctly!)
% (if unspecified can be set to 1000)
%
% OUTPUT:
% weights = (d+1) * 1 vector of weights where the weights correspond to
% the columns of "data"
%

eta = 0.1;
weights = zeros(width(data),1);

for i= 1:maxiter
    sig = sigmoid(data * weights);
    b = (sig - labels);
    gradient = (1/height(data)) * transpose(data) * b;
    weights_1 = weights + eta*(-gradient);
    norm_weights = norm(weights - weights_1);
    val = norm_weights/height(labels);
    if val <= epsilon
        break
    else
        weights = weights_1;
    end
%     
end

end

