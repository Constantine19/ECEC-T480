function y = optim_random(func, bond, max_iter)
% Finds the location and maximum value of a two-dimensional function
% using the random search approach. The inputs are the two-dimensional
% function(anonymous), bounds for each dimension, and the number of trials.
% The outputs are the location of the maximum and the maximum value.

dim=1;
popsize=100;
max_error=0.01;
output =[];
for i=0:max_iter
    candidate=10*rand(dim,popsize)-bond;
    best=min(feval(func,candidate));
    output = [output; best, func(best)];
    if best <= max_error
        break;
    end
end
output = [output; best, func(best)];
display(best)

%fprintf('Maximum | Maximum Value')
%fprintf('\n%f %f\n',output.')
end