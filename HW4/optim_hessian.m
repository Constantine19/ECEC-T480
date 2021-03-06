function f=optim_hessian(func, a)

l=length(a); %Hessian would be lxl matrix
ep=0.0001; % step size for numerical diffrentiation
valf=func(a); % value of obj function at a
ep2=ep*ep;
ep3=4*ep*ep;
for i=1:length(a)
    x1=a;
    x1(i)=a(i)-ep; %Change ith element in x1
    x2=a;
    x2(i)=a(i)+ep; %Change ith element in x2
    hf(i,i)=(func(x2)-2*valf+func(x1))/ep2; % diagonal entries
    j=i+1;
    while j<=length(a) % Loop computes the rest of the elements of the Hessian matrix
        x1(j)=a(j)-ep; % Lower the value of step size
        x2(j)=a(j)+ep; % Increment the value of step size
        v4=func(x1); % compute the respective values
        v1=func(x2); % compute the respective values
        x1(j)=x1(j)+2*ep; 
        x2(j)=x2(j)-2*ep;
        v2=func(x1);
        v3=func(x2);
        hf(i,j)=(v1+v4-v2-v3)/ep3;
        hf(j,i)=hf(i,j); % d2f/dxdy is same as that of d2f/dydx
        x1(j)=a(j);
        x2(j)=a(j);
        j=j+1;
    end
end
f=hf; % return Hessian matrix
return;
end