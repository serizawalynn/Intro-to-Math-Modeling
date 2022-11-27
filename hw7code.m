 %% HW 7 Code %%

%Clean workspace
clear
clc

%Perturbation method
hold on %Allow graphing multiple lines on a single figure
t_pert=0:pi/200:(20*pi); %Array for times
y=-cos(t_pert)+2+(.05*((sin(3*t_pert)/12)+(.75*sin(t_pert))-((3*sin(2*t_pert))/2)+(3*t_pert))); %Perturbation function
plot(t_pert,y) %Plot the perturbation line

%Euler's method
timestep=.01*2*pi; %Timestep
total_time=20*pi; %Total time for simulation

%Arrays for time and v_tilde
t_array=zeros(1,1000);
v_array=zeros(1,1000);
dv_tilde_dt_tilde=zeros(1,1000);

%The first entry for the dv_tilde_dt_tilde array
dv_tilde_dt_tilde(1)=sin(t_array(1))-.05*v_array(1);

%Euler's method iterations
for k=1:1000
    t_array(k+1)=t_array(k)+timestep;
    dv_tilde_dt_tilde(k+1)=sin(t_array(k))-.05*(v_array(k)^3);
    v_array(k+1)=v_array(k)+dv_tilde_dt_tilde(k+1)*timestep;
end

%Plot the results of the Euler method
plot(t_array,v_array)
hold off %No more plotting
legend('Perturbation',"Euler's") %Legend for readability

