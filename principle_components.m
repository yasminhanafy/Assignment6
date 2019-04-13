clc
clear 
close all
m = xlsread('E:\Semester10\Machine Learning\house_prices_data_training_data.csv');
y=m(2:end,3);
x=( m(2:end,4:21));
[m,n]=size(x);
Corr_x = corrcoef(x); % This function calculate the correlation between each pair column even with its self. 
 
                    % Thats why the diagonal=1 
relationship=zeros(2,n); 
% to remove 0
for  i =1:1:n
    for j=1:1:n
  if (Corr_x(j,i)==1) 
  Corr_x(j,i)=0;
  end;
      
 
    end 
end

for  i =1:1:n
[val, idx] = max(Corr_x(:,i));
 relationship(1,i)=idx; 
 relationship(2,i)=val; 
end 

x_cov=cov(x) ; 

[U,S,V] =  svd(x_cov);

accuracy=0;
s_den=0;

for i=1:1:n
s_den=s_den+S(i,i);   
end 

s_num=0;

k=0;
for i=1:1:n
    k=i;
s_num=s_num+S(i,i);
accuracy=s_num/s_den;
if(accuracy>=0.99)
    break;
end 

end 

error=0;
t=0;
s1_num=0;
for i=1:1:n
    t=i;
s1_num=s1_num+S(i,i);
error=1-(s1_num/s_den);
if(error<=0.001)
    break;
end 

end 

ureduce=U(:,1:k);
z=(ureduce'*x')';


 for i=1:1:m
 xapprox(i,:)=ureduce*z(i,:)';
 end 

 %error1
 error1=0;
 for i=1:1:m
 error1=error1+sum((x(i,:) - xapprox(i,:)));
 end 
 %linear regression
 z=[ones(m,1), z];
 theta1=inv(transpose(z)*z);
theta2=transpose(z)*y;
theta=theta1*theta2;

[centroids cost] =k_cluster(z,1);
cost_ref=cost;
k_new=1;
for i=2:1:m/4
    
[centroids cost] =k_cluster(z,i);

if(cost_ref<cost)
    
    
    break
else 
    k_new=i;
end 
end 
fprintf('done')
