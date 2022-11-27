%% HW 7 %%
% Lynn Serizawa %
clear
clc

epsilon=.05;

dt=.01*2*pi;
total_time=10*2*pi;
dims=total_time/dt;
v=zeros(1000,1);
t=zeros(1000,1);
x_pert=linspace(0,total_time);

for k=1:1001
    t(k+1)=t(k)+dt;
    v(k+1)=v(k)-epsilon*(v(k)^3)+1;
end
t=t/(2*pi);
plot(t,v)
