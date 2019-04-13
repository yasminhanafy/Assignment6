clc
clear 
close all
m = xlsread('E:\Semester10\Machine Learning\house_prices_data_training_data.csv');
y=m(2:end,3);
x1=( m(2:end,4:21));
[m,n]=size(x1);
%xtest=[-1.45921345551529,-1.39947623363815,-1.02118527807975,-0.0767682961942529,-0.849941408011425,-0.0888573263697845,-0.311309156141569,0.826700437807186,-0.506532314980202,-0.769486363941977,-0.672147929852379,-0.511186649544223,-0.217632715914464,-0.426159091941977,-0.779201258823044,0.202022967767398,-1.04468714571241,-0.0908377247510713]

for w=1:n
    if max(abs(x1(:,w)))~=0
    x1(:,w)=(x1(:,w)-mean((x1(:,w))))./std(x1(:,w));
    end
end
x=x1(1:10000,:);
xtest=x1(10001:end,:);
[m,n]=size(x);

% 18 feature 
% mean
store=0;
mean_vector= zeros(1,n);
for i=1:1:n
        for j=1:1:m
        store=store+x(j,i);    
        end
        mean_vector(1,i)=(1/m)*store;
end

% for i=1:1:n
%         
%         mean_test(1,i)=mean(x(:,i));
% end

% variance 
store_variance=0;
for i=1:1:n  
        for j=1:1:m
        store_variance=store_variance+(x(j,i)-mean_vector(1,i))^2;    
        end
        variance_vector(1,i)=(1/m)*store_variance;
end

%model 



prop=1;
for i=1:1:n
    
        num=(1/(sqrt(2*pi)*variance_vector(1,i)));
        num2=exp(-(xtest(1,i)-mean_vector(1,i))^2/(2*variance_vector(1,i)^2));
        prop=prop*num*num2

end 

ee=0.03;
if(prop>ee) 
    y=0;
else 
    y=1;
end