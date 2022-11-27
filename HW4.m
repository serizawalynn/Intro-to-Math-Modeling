%%%   HW4   %%%
% By Lynn Serizawa

%% Reset Workspace
clear
clc

%% Define constants:
roh=1000; % Density kg/(m^3)
Cp=4184; % Cp J/(kg*K)
Tinf=275.15; % Ambient temp in Kelvins
h=20; % Heat transfer coefficient W/((m^2)*k)
a=.05; % Radius of Orange in m
sigma=5.7*(10^-8); %The sigma coefficient
epsilon=1; % Emissivity
Tinit=283.15; %Initial temperature in K
tau=((7*roh*a*Cp)/(3*h)); % Tau: Timescale as stated in problem
timestep=.01*tau; %Timestep
Sky_temps=[-5 -10 -20]+273.15; % The various Sky temperatures we will plot/test

%% Initialize arrays for Data Collection
results=[];

%% Initialize plotting space
plt=figure();

%% Forward Euler's Method
hold on %Allow plotting multiple lines on figure.
for i=Sky_temps %For each sky temperature...
    y=zeros(1,701); %Set the arrays for the y-points
    x=zeros(1,701); %Set the arrays for the x-points
    y(1)=Tinit; %Set first point as the initial temperature
    x(1)=0; %Zeroth timestep
    for k=1:700
        x(k+1)=x(k)+timestep; %State the time for the next timestep
        convection=3*h*(y(k)-Tinf); %Loss in heat due to convection
        SB=3*sigma*epsilon*((y(k)^4)-(i^4)); %Loss in heat due to radiation using Stefan-Boltzmann
        y(k+1)=y(k)-timestep*((convection+SB)/(roh*a*Cp)); %Forward Euler's method that subtracts loss in heat using our ODE from the kth temperature reading to get to the k+1th temperature
    end
    plot(x,y) %Plot the temperature line for all time
    results=[results y(1,701)]; %Collect the resulting temperature the specific case converges to.
end
yline(273.15) %Plot a line for 0 Degrees celsius (273.15 K)
yline(Tinf,LineStyle="--") %Plot the Ambient temperature
yline(Tinit,LineStyle=":") %Plot the initial temperature
legend("-5 Degrees celsius (268.15 K)", ... %Make a legend for readability
    "-10 Degrees celsius (263.15 K)", ...
    "-20 Degrees celsius (253.15 K)", ...
    "0 Degrees celsius (273.15 K)", ...
    "2 Degrees celsius: Ambient Temperature (275.15 K)", ...
    "10 Degrees celsius: Initial Temperature (283.15 K)")
hold off %Stop plotting lines on same plot
xlabel("Time (Seconds)")
ylabel("Temperature in K")
axis([x(1,1)-2 x(1,701)+2 y(1,701)-2 y(1,1)+2]) %Set the viewing axes so that we can see the x axis for all time and the y axis for all temperatures
grid on
