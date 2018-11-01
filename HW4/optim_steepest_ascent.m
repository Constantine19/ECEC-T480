function [location, max] = optim_steepest_ascent(f, gf, init_step_size, max_iter, tolerance)

x_0 = gf(1);
y_0 = gf(2);

%Initiliazation
iter = 0;
while (norm(grad) >= tolerance && iter < max_iter)
    x_new = x_0 - init_step_size * gf(1); 
    y_new = y_0 - init_step_size * gf(2); 
    x_0 = x_new; %Update old solution
    y_0 = y_new;
    gf = f(x_0, y_0);
    iter = iter + 1;
end
max = gf;
location = [x_0, y_0];
end
