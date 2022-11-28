%% Simple Pendulum Euler %%
clc
clear
cla()
%State Variables
g=9.81; %accerleration due to gravity
string_length=2; %string length
mass=1; %Mass of ball on string
roh=1;%Fluid density
Drag_coeff=1;%Drag Coefficient
mass_radius=.5;%Radius of ball
cross_sec_area=(mass_radius^2)*pi;

%Initial conditions
init_theta=[pi/2 pi/4 pi/6 pi/8];%initial angular position
angular_velocity=0; %angular velocity
vel_G=((1.5*roh*Drag_coeff*mass_radius)/(mass));
theta_H=(3*g)/(2*string_length);

%Period from calculations
freq=sqrt((4*theta_H)-(vel_G^2))/2;
period=(2*pi)/freq

%Time step and total time
dt_array=[ .0001 ]; %various timesteps
plt=figure(1);
legend_names=[];
hold on
mult=3;
total_time=mult*period;
for theta=init_theta
    for dt=dt_array
        %Arrays for plotting and string concatenation for building labels
        adj_time=floor(total_time/dt);
        t_array=zeros(adj_time,1);
        theta_array=zeros(adj_time,1);
        angular_velocity_array=zeros(adj_time,1);
        angular_acc_array=zeros(adj_time,1);
        
        angular_acceleration=((vel_G*angular_velocity)-((theta_H*theta)));

        theta_array(1)=theta;
        angular_acc_array(1)=angular_acceleration;
        angular_velocity_array(1)=angular_velocity;
        
        theta_label='Theta: \pi';
        theta_string=string(rats(theta/pi));
        new_label=strcat(theta_label,theta_string);
        legend_names=[legend_names ; new_label];
        %Forward Euler's Method
        for k=1:(adj_time)
            angular_acc_array(k+1)=-(angular_velocity_array(k)*vel_G)-((theta_H*(theta_array(k))));
            angular_velocity_array(k+1)=angular_velocity_array(k)+(angular_acc_array(k))*dt; %k+1th angular velocity
            theta_array(k+1)=theta_array(k)+(angular_velocity_array(k+1)*dt)+(.5*(angular_acc_array(k+1)*dt*dt)); %k+1th angular position
            t_array(k+1)=t_array(k)+dt; %time
        end
        plot(t_array,theta_array)
        %Numerically confirm the period
        max_logical=islocalmax(theta_array);
        max_index=find(max_logical==1);
        numerically_derived_period=t_array(max_index(2))-t_array(max_index(1))
        iter_length=length(max_index);
        differences=[];
        for k=2:iter_length
            diff=t_array(max_index(k))-t_array(max_index(k-1));
            differences=[differences diff];
        end
    end
end
%Plot data
title('Angular Position of Simple Pendulum (with Air Resistance)','FontSize',14)
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
    differences=[differences diff];
end
avg_period=mean(differences)