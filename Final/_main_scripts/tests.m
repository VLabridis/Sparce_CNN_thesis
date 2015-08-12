S = load('small_cnn');
[train_x, train_y, test_x, test_y] = get_mnist_data();
sample = test_x(:,:,1:4);

dim_impls = {@DIM_MaskSplitting, @DIM_sigmoids};
masks = S.cnn.layers{2}.k.';

for i =1:numel(dim_impls)
    out_batch{i} = dim_impls{i}({sample},masks,{},30);
    out_ser{i} = {};
    for j = 1:size(sample, 3);
        res = dim_impls{i}({sample(:,:,j)},masks,{},30);
        for k = 1:size(masks,1)
            out_ser{i}{k}(:,:,j) = res{k};
        end        
    end
end
for i =1:numel(dim_impls)
    for j =1:size(masks,1)
        diff =  out_batch{i}{j} - out_ser{i}{j};
        disp(['i =: ', num2str(i)])
        disp(['sum of diff: ', num2str( sum(diff(:)))])
    end
end