function [weight, twist, delta, effect_stress] = bar_params(ro1,ri1,ro2,ri2,P,T,G,E,L1,L2,density)
% Compute the area of the straight portion
A2=pi.*(ro2.^2-ri2.^2);
% Compute the polar moment of inertia
Ip2=(pi/2)*(ro2.^4-ri2.^4);

% Values for integrating, the linear slopes of the inner and outer wall
a=(ro2-ro1)/L1;
b=ro1;
c=(ri2-ri1)/L1;
d=ri1;

% Compute the integral for angular twist
syms x
twist= eval(int((1/((a*x+b)^4-(c*x+d)^4)),x,0,L1));
twist=(2*T/(pi*G)).*twist;

% Compute the integral for elongation
syms x
delta_1=eval(int(1/((a*x+b)^2-(c*x+d)^2),x,0,L1));
delta_1=(P/(pi.*E)).*delta_1;
delta_2=(P.*L2)/(A2.*E);
delta=delta_1+delta_2;

% Superposition for the stress values
norm_stress_x = P/A2;
shear_stress_yz=(T.*ro2)/Ip2;
effect_stress = (1/sqrt(2)).*sqrt(2.*(norm_stress_x.^2)+6.*(shear_stress_yz^.2));

% Compute the volume integral and corresponding weight
syms x
volume1=eval(pi.*(int((a*x+b)^2-(c*x+d)^2,x,0,L1)));
volume2=L2.*A2;
volume=volume1+volume2;
weight=density*volume;
end

