% Project 2
% Konstantin Zelmanovich
% Jayden Chen

clear all
clc
clf

% Initial values
L = 10;
e = 0.25/1000;
p = 1000;
u = 0.001;
D1 = 0.2;
g = 9.81;
A1 = ((D1/2)^2)*pi();
RR1 = e/(D1);
data1 = [];
data2 = [];
d_steps = linspace(0.03, 0.5, 60);
m_steps = linspace(0,5,500);

% Mass flow rate, Friction factor, Reynolds number, Head loss
for j = 1:length(d_steps)
    D2 = d_steps(j);
    RR2 = e/D2;
    A2 = ((D2/2)^2)*pi;
    HL1_Diff = intmax;
    m1_perm = 0;
    for i = 1:length(m_steps)
        m1 = m_steps(i);
        m2 = 5-m1;

        % Calculating Mass flow rate
        v1 = m1/(p*A1);
        v2 = m2/(p*A2);

        % Calculating Reynolds number
        Re1 = p*v1*D1/u;
        Re2 = p*v2*D2/u;

        % Calculating Friction factor
        y1 = @(f) 1/(f).^(1/2) + 2 * log10((e/D1)) * 3.7 + 2.51 / (Re1 * (f).^(1/2)));
        dy1 = @(f) ((f).^(1/2) * ((-1/2) * RR1 * Re1 - 4.03329) - 4.6435) / (RR1 * f.^2 * Re1 + 9.287 * f.^(3/2));
        
        y2 = @(f) 1 / (f).^1/2 + 2 * log10((e/D2)/3.7 + 2.51/(Re2 * (f).^(1/2)));
        dy2 = @(f) ((f).^1/2 * ((-1/2) * RR2 * Re2 - 4.03329) - 4.6435)/( RR2 * f.^2 * Re2 + 9.287 * f^(3/2));
        
        fy1 = newton_rhapson(y1, dy1, 0.04, 5, 0.001);
        a = size(fy1);
        
        fy1_num = fy1(a(1),2);
        fy2 = newton_rhapson(y2, dy2, 0.04, 5, 0.001);
        
        b = size(fy2);
        fy2_num = fy2(b(1),2);
        
        % Calculating Head Loss
        HL1 = fy1_num * L * (v1.^2)/(D1 * 2 * g);
        HL2 = fy2_num * L * (v2.^2)/(D2 * 2 * g);
        if abs(HL1-HL2) < HL1_Diff
            m1_perm = m1;
            m2_perm = m2;
            HL1_perm = HL2;
            HL2_perm = HL1;
            HL1_Diff = abs(HL1-HL2);
            Re1_perm = Re2;
            Re2_perm = Re1;
            f1_perm = fy2_num;
            f2_perm = fy1_num;
        end 
    end
    
    data1 = [data1; D1 m1_perm f2_perm Re2_perm HL2_perm];
    data2 = [data2;D2 m2_perm f1_perm Re1_perm HL1_perm];

end
figure(1)
subplot(2, 2, [1 2]);
grid on
semilogx(data2(:,1),data2(:,2))
hold on
semilogx(data2(:,1),data1(:,2))
title('Mass Flow Rate')
xlabel('Diameter of Pipe 2 (m)')
ylabel('Mass Flow Rate (kg/s)')
legend('Pipe 2','Pipe 1')
hold off


subplot(2, 2, [3 4]);
grid on
semilogx(data2(:,1),data2(:,3))
hold on
semilogx(data2(:,1),data1(:,3))
title('Friction Factors')
xlabel('Diameter of Pipe 2 (m)')
ylabel('Friction Factor')
legend('Pipe 2','Pipe 1')

hold off

figure(2)
subplot(2, 2, [1 2]);
grid on
semilogx(data2(:,1),data2(:,4))
hold on
semilogx(data2(:,1),data1(:,4))
title('Reynold Numbers')
xlabel('Diameter of Pipe 2 (m)')
ylabel('Reynolds Numbers')
legend('Pipe 2','Pipe 1')
hold off

subplot(2, 2, [3 4]);
grid on
semilogx(data2(:,1),data2(:,5))
hold on
semilogx(data2(:,1),data1(:,5))
title('Head Loss')
xlabel('Diameter of Pipe 2 (m)')
ylabel('Head Loss  (m*s)')
legend('Pipe 2','Pipe 1')
hold off

figure(3)
grid on
semilogx(data2(:,3),data2(:,4))
hold on
semilogx(data1(:,3),data1(:,4))
title('Friction Factor vs Reynolds Number')
xlabel('Friction Factor')
ylabel('Reynolds Number')
legend('Pipe 2','Pipe 1')
hold off


