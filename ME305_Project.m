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

ro1=[0.0254];
ri1=[0.02262187];

ro2=[0.01984375];
ri2=[0.01706563];

[weight, twist, delta, effect_stress] = bar_params(ro1,ri1,ro2,ri2,P,T,G,E,L1,L2,density);


if condition
    disp('pass')
else
    disp('fail')
end

%Prop. of AL 7016-T5
%G=27*10^9;
%E=71.*10^9;
%density=[2780];
%stress_max=315*10^6;
