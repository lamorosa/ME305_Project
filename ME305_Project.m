%%% ---   ME305 Beam Design Project   --- %%%
% Kurt Dudek & Luca Amarosa
% 2018/12/07

clear
clc

% Test case
% materials = struct('Material','AL','G',2.7*10^10,'E',7.1*10^10,'Density',2780,'Y',315*10^6);
% materials(2) = struct('Material','Steel','G',3.1*10^10,'E',9.5*10^10,'Density',4300,'Y',415*10^6);

% Initialize materials struct
materials = struct_creation();

%Defining given constants
P=30000;
T=2500;
L1=0.180;
L2=0.120;
L=L1+L2;

%Defining Max Values
twist_max=0.05;
delta_tot= 0.002;

% Raius values at the fixed end
ro1=[in2m(1.75)]; %1.5
ri1=[in2m(1.5:.05:1.7)]; %1.05:.1:1.49

% Radius values at the end of the taper; torque is applied here
ro2=[in2m(1.25)];
ri2=[in2m(1.0:.05:1.2)];


% Struct with best performing configuration
optimal_beam = struct('Material','','Weight',100000000,'ro1',ro1,'ri1',0,'ro2',ro2,'ri2',0);

% Store all data from test
for mats = 1:6
    data(mats) = struct('Material','','Weight',[],'ro1',ro1,'ri1',[],'ro2',ro2,'ri2',[],'twist',[],...
        'delta',[],'effect_stress',[]);
end


% loop_val = 1;
% Loop through bar geometries and materials to find best performance
iter = 1;
for k = 1:length(materials)
    fprintf('\nTest runs for %s\n',materials(k).Material) 
    for i = 1:length(ri1)
        for j = 1:length(ri2)
            [weight,twist,delta,effect_stress] = bar_params(ro1,ri1(i),ro2,ri2(j),P,T,materials(k).G,...
                materials(k).E,L1,L2,materials(k).Density);
            data(k).Material = materials(k).Material;
            data(k).Weight(end+1) = weight;
            data(k).twist(end+1) = twist;
            data(k).delta(end+1) = delta;
            data(k).effect_stress(end+1) = effect_stress;
            data(k).ri1(end+1) = ri1(i);
            data(k).ri2(end+1) = ri2(j);
            
            % If bar configuration passes strength requirements
            if (twist<(twist_max./2)) && (delta<(delta_tot./2)) && (effect_stress<(materials(k).Y./2))
                % Write current bar configurations to the struct of optimal design
                if weight < optimal_beam.Weight
                    optimal_beam.Material = materials(k).Material;
                    optimal_beam.Weight = weight;
                    optimal_beam.ri1 = ri1(i);
                    optimal_beam.ri2 = ri2(j);
                    
                    fprintf('Optimal Updated with %s, iteration %d...\n',materials(k).Material,iter)
                    iter = iter+1;
                else
                    fprintf('%s, iteration %d, Passed but not optimal...\n',materials(k).Material,iter)
                    iter = iter+1;
                end
            else
                fprintf('Failed; Try harder...\n')
                iter = iter+1;
            end
%             disp(loop_val)
%             loop_val = loop_val+1;
        end
    end
end