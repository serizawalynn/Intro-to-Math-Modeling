%% Simple Pendulum Euler %%
clc
clear
%State Variables
g=9.81; %accerleration due to gravity
string_length=2/2; %string length

%Initial conditions
init_theta=[pi/2 pi/4 pi/6 pi/8];%initial angular position
angular_velocity=0; %angular velocity

%Time step and total time
dt_array=[.0001]; %various timesteps
plt=figure(1);
legend_names=[];
hold on
timescale=2*pi*sqrt(string_length/g);
mult=3;
total_time=mult*timescale;
for theta=init_theta
    for dt=dt_array
        %Arrays for plotting and string concatenation for building labels
        adj_time=floor(total_time/dt);
        t_array=zeros(adj_time,1);
        angular_velocity_array=zeros(adj_time,1);
        angular_velocity_array(1)=angular_velocity;
        theta_array=zeros(adj_time,1);
        theta_array(1)=theta;
        theta_label='Theta:\pi';
        theta_string=string(rats(theta/pi));
        
        new_label=strcat(theta_label,theta_string);
        legend_names=[legend_names new_label];
        %Forward Euler's Method
        for k=1:total_time/dt
            angular_velocity_array(k+1)=angular_velocity_array(k)-((g*theta_array(k))/string_length)*dt; %k+1th angular velocity
            theta_array(k+1)=theta_array(k)+angular_velocity_array(k+1)*dt; %k+1th angular position
            t_array(k+1)=t_array(k)+dt; %time
        end
        plot(t_array,theta_array)
    end
end
%Plot data
title('Angular Position of Rod Pendulum (No Air Resistance)','FontSize',14)
%xlabel('Time/TimeScale','FontSize',14)
xlabel('$$\hat{t}$$','Interpreter','Latex','FontSize',14)
ylabel('Angular Position (\theta)','FontSize',14)
legend(legend_names)
grid on
hold off

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
