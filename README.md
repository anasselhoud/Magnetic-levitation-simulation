# Magnetic-levitation-simulation
Simulation of a non-linear system for magnetic levitation used for MagLev trains. The simulation was done using Matlab and Simulink. 

The idea was to model the system using three dependent blocks. The first was a voltage converter, in which we convert a constant voltage to a current flowing in a coil. The second block was an automatic controller for the position and the current. While the third block is used to calculate the force needed to move the magnet (we used both a non linear and a linear calculation).

We started by precalculating the parameters of the problem, specially the ones related to the magnetic circuit and auto-control the current variation. The current injected is related to the position of the magnet. We have an equilibrium position where the magnetic force is equal to the weight of the magnet. This position corresponds to the steady state position of our system.

# Screenshots from the projects - Results


