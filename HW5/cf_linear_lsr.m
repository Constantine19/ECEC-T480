function [a0, a1, r2] = cf_linear_lsr(ord, fit)
n = length(ord);
sumX1 = 0;
sumY1 = 0;
sumX2 = 0;
sumY2 = 0;
sumXY = 0;

if strcmp(fit, 'linear')
    for i = 1:n
        x0 = ord(i, 1);
        y0 = ord(i, 2);
        sumX1 = sumX1 + x0;
        sumY1 = sumY1 + y0;
        sumX2 = sumX2 + x0^2;
        sumY2 = sumY2 + y0^2;
        sumXY = sumXY + x0*y0;
    end
    
    x_bar = sumX1/n;
    y_bar = sumY1/n;
    a1 = (n * sumXY - sumX1 * sumY1) / (n*sumX2 - sumX1^2);
    a0 =  y_bar - a1 * x_bar;
    st = 0;
    sr = 0;
    for i = 1:n
        x0 = ord(i, 1);
        y0 = ord(i, 2);
        st = st + (y0 - y_bar)^2;
        sr = sr + (y0 - a0 - a1*x0)^2;
    end
    r2 = (st - sr) / sr;
elseif strcmp(fit, 'exponential')
    ord(:, 2) = log(ord(:,2));
    for i = 1:n
        x0 = ord(i, 1);
        y0 = ord(i, 2);
        sumX1 = sumX1 + x0;
        sumY1 = sumY1 + y0;
        sumX2 = sumX2 + x0^2;
        sumY2 = sumY2 + y0^2;
        sumXY = sumXY + x0*y0;
    end
    
    x_bar = sumX1/n;
    y_bar = sumY1/n;
    a1 = (n * sumXY - sumX1 * sumY1) / (n*sumX2 - sumX1^2);
    a0 =  y_bar - a1 * x_bar;
    a0 = exp(a0);
    st = 0;
    sr = 0;
    for i = 1:n
        x0 = ord(i, 1);
        y0 = ord(i, 2);
        st = st + (y0 - y_bar)^2;
        sr = sr + (y0 - a0 - a1*x0)^2;
    end
    r2 = (st - sr) / sr;
elseif strcmp(fit, 'power')
    ord = log10(ord);
    for i = 1:n
        x0 = ord(i, 1);
        y0 = ord(i, 2);
        sumX1 = sumX1 + x0;
        sumY1 = sumY1 + y0;
        sumX2 = sumX2 + x0^2;
        sumY2 = sumY2 + y0^2;
        sumXY = sumXY + x0*y0;
    end
    
    x_bar = sumX1/n;
    y_bar = sumY1/n;
    a1 = (n * sumXY - sumX1 * sumY1) / (n*sumX2 - sumX1^2);
    a0 =  y_bar - a1 * x_bar;
    a0 = 10^a0;
    st = 0;
    sr = 0;
    for i = 1:n
        x0 = ord(i, 1);
        y0 = ord(i, 2);
        st = st + (y0 - y_bar)^2;
        sr = sr + (y0 - a0 - a1*x0)^2;
    end
    r2 = (st - sr) / sr;
elseif strcmp(fit, 'saturation')
    ord = 1./ord;
    for i = 1:n
        x0 = ord(i, 1);
        y0 = ord(i, 2);
        sumX1 = sumX1 + x0;
        sumY1 = sumY1 + y0;
        sumX2 = sumX2 + x0^2;
        sumY2 = sumY2 + y0^2;
        sumXY = sumXY + x0*y0;
    end
    
    x_bar = sumX1/n;
    y_bar = sumY1/n;
    a1 = (n * sumXY - sumX1 * sumY1) / (n*sumX2 - sumX1^2);
    a0 =  y_bar - a1 * x_bar;
    a0 = 1/a0;
    a1 = a0*a1;
    st = 0;
    sr = 0;
    for i = 1:n
        x0 = ord(i, 1);
        y0 = ord(i, 2);
        st = st + (y0 - y_bar)^2;
        sr = sr + (y0 - a0 - a1*x0)^2;
    end
    r2 = (st - sr) / sr;
end

end