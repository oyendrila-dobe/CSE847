function newmat = sigmoid(mat)
    newmat = 1.0 ./(1 + exp(-mat));
end

