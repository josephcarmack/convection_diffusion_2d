%% this is a octave program for modeling 2D convection
%% diffusion flow problems in cartesian coordinates

%% GRID PARAMETERS
nx = 3;						% number of u vel CVs in x
ny = 3;						% number of u vel CVs in y
H = 0.1;					% slit height in meters
L = 1;						% length of slit in meters

%% u,v velocity and presure arrays for the nodes
u = zeros(nx*ny,1);			% m/s
v = zeros(nx*ny,1);
p = zeros((nx+1)*(ny+1),1);

%% fluid parameters (glycerin)
rho = 1264;					% density in kg/m^3
dyn_vis = 1.519;			% dynamic viscosity in kg/(m*s)
kin_vis = dyn_vis/rho;		% kinematic viscosity in m^2/s

%% u velocity boundary condition
ub = ones(ny);

%% initial relaxation of the velocity field

