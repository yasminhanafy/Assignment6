
% function [centroids,cost]=k_cluster(X,K)
 m = xlsread('E:\Semester10\Machine Learning\house_prices_data_training_data.csv');
 y=m(2:end,3);
 X=( m(2:end,4:21));
for kk=1:1:m/4 
K=kk
centroids = zeros(K,size(X,2)); 
randidx = randperm(size(X,1)); %returns a row vector containing a random permutation of the integers from 1 to n inclusive.
centroids=X(randidx(1:K), :);

K = size(centroids, 1);
indices = zeros(size(X,1), 1);
m = size(X,1);


    
for i=1:1:10
  for i=1:m   % all the training examples
    k = 1;
    min_dist = sum((X(i,:) - centroids(1,:)) .^ 2);
    for j=2:K
        dist = sum((X(i,:) - centroids(j,:)) .^ 2);
        if(dist < min_dist)
          min_dist = dist;
          k = j;
        end
        
    end
    indices(i) = k;
  end
  
  %recompute centroids
   
  [m n] = size(X);
  centroids = zeros(K, n);
  
  for i=1:1:K
    xi = X(indices==i,:); 
    ck = size(xi,1);
    
    centroids(i, :) = mean(xi);
  end
end

    cost=0;
    for j=1:1:K
        
        yj = X(indices==j,:); 
        dist = sum((yj(j,:) - centroids(j,:)) .^ 2);`   
        
  cost=cost+dist;
  
  
  
    end
    
    costd(kk,:)=cost;
    [val, idx] = min(costd);
    
end 

