%% Simple Pendulum Euler %%
clc
clear
%State Variables
g=9.81; %accerleration due to gravity
string_length=2; %string length

%Initial conditions
init_theta=[pi/6];%initial angular position
angular_velocity=0; %angular velocity

%Time step and total time
dt_array=[.5 .1 .01 .001 .0001]; %various timesteps
%total_time=10; %Total time
plt=figure(1);
legend_names=[];
hold on
timescale=2*pi*sqrt(string_length/g);
mult=3;
total_time=mult*timescale;
for theta=init_theta
    for dt=dt_array
        %Arrays for plotting and string concatenation for building labels
        t_array=zeros(ceil(total_time/dt),1);
        angular_velocity_array=zeros(ceil(total_time/dt),1);
        angular_velocity_array(1)=angular_velocity;
        theta_array=zeros(ceil(total_time/dt),1);
        theta_array(1)=theta;
        theta_label='Theta: ';
        theta_string=string(theta);
        dt_label=' Timestep: ';
        dt_string=string(dt);
        space=' ';
        new_label=strcat(dt_label,dt_string);
        legend_names=[legend_names new_label];
        %Forward Euler's Method
        for k=1:ceil(total_time/dt)
            angular_velocity_array(k+1)=angular_velocity_array(k)-((g*theta_array(k))/string_length)*dt; %k+1th angular velocity
            theta_array(k+1)=theta_array(k)+angular_velocity_array(k+1)*dt; %k+1th angular position
            t_array(k+1)=t_array(k)+dt; %time
        end
        plot(t_array,theta_array)
    end
end
%Plot data
title('Angular Position of Pendulum','FontSize',14)
xlabel('Time/TimeScale','FontSize',14)
ylabel('Theta (Init: \pi/6)','FontSize',14)
legend(legend_names)

%Numerically confirm the period
max_logical=islocalmax(theta_array);
max_index=find(max_logical==1);
numerically_derived_period=t_array(max_index(2))-t_array(max_index(1))
iter_length=length(max_index);
differences=[];
for k=2:iter_length
    diff=t_array(max_index(k))-t_array(max_index(k-1));
    differences=[differences diff]
end
