# mpc-hoverRocket

Hover rocket using model predictive control (MPC). 

## Hover rocket

A rocket uses its thruster to produce thrust against its gravity, which is launched and maintain itself as a given altitude.

![rocket](/img/rocket.png)

Kinetics: 

![Kinetics](/img/Kinetics.gif)

Dynamics:

![Dynamics](/img/Dynamics.gif)

State-space (continue time):

Let ![xu](/img/xu.gif)

![State-space](/img/State-space.gif)

State-space (discrete time):

![State-space](/img/State-space-d.gif)

## MPC-based controller

The Model predictive Control Toolbox(R).

## Simulation

Simulink model:

![simulink](/img/simulink.jpg)

Simulation result:

![plot](/img/plot.png)