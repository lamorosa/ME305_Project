%Defining given constants
P=30000;
T=2500;
L1=0.180;
L2=0.120;
L=L1+L2;

%Defining Max Values
twist_max=0.05;
delta_tot= 0.002;

ro1=[in2m(1.5)];
ri1=[in2m(1:.125:1.4)];

ro2=[in2m(1.25)];
ri2=[in2m(.75:.125:1.15)];

% Struct with best performing configuration
optimal_beam = struct('Material','','Weight',100000000,'ro1',1.5,'ri1',0,'ro2',1.25,'ri2',0);

% Loop through bar geometries and materials to find best performance
for i = 1:length(ri1)
    for j = 1:length(ri2)
        for k = 1:length(materials)
            [weight,twist,delta,effect_stress] = bar_params(ro1,ri1(i),ro2,ri2(j),P,T,materials(k).G,...
                materials(k).E,L1,L2,materials(k).density);
            
            % If bar configuration passes strength requirements
            if (twist<(twist_max./2)) && (delta<(delta_tot./2)) && (effect_stress<(stress_max./2))
                % Write current bar configurations to the struct of optimal design
                if weight < optimal beam.Weight
                    optimal_beam.Material = material(k).Material;
                    optimal_beam.Weight = weight;
                    optimal_beam.ri1 = material(k).ri1;
                    optimal_beam.ri2 = material(k).ri2;
                end
                iter = i * j * k;
                fprintf('Optimal Updated with %s, iteration %d',material(k).Material,iter)
            else
                fprintf('Failed...')
            end
        end
    end
end





% %Material specific calculations
% G=27*10^9;
% E=71.*10^9;
% density=[2780];
% stress_max=315*10^6;

% save('Variables_AL-7016-T5_Test1.mat','G','E','density','stress_max','ro1','ri1','ro2','ri2')
% 
% disp('Results for AL-7016-T5, Test1')
