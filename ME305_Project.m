%Defining given constants
P=30000;
T=2500;
L1=0.180;
L2=0.120;
L=L1+L2;

%Defining Max Values
twist_max=0.05;
delta_tot= 0.002;

%Material specific calculations
G=27*10^9;
E=71.*10^9;
density=[2780];
stress_max=315*10^6;

ro1=[in2m(1.5)];
ri1=[in2m(1.35)];

ro2=[in2m(1.25)];
ri2=[in2m(1.10)];

save('Variables_AL-7016-T5_Test1.mat','G','E','density','stress_max','ro1','ri1','ro2','ri2')

disp('Results for AL-7016-T5, Test1')

[weight, twist, delta, effect_stress] = bar_params(ro1,ri1,ro2,ri2,P,T,G,E,L1,L2,density);


if twist<(twist_max./2)
    disp('Twist passed')
else
<<<<<<< HEAD
    disp('fail')
=======
    disp('Twist failed')
>>>>>>> c5a44bdfa3d35a5d603e3ea3df176c11fd4c7d68
end

if delta<(delta_tot./2)
    disp('Delta passed')
else
    disp('Delta failed')
end

if effect_stress<(stress_max./2)
    disp('Stress passed')
else
    disp('Stress failed')
end
