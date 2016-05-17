%% this is a octave program for modeling 2D convection
%% diffusion flow problems in cartesian coordinates

clear all

%% GRID PARAMETERS
nx = 4;					% number of ps CVs in x
ny = 5;					% number of ps CVs in y (MAKE IT ODD)
H = 0.1;					% slit height in meters
L = 0.08;						% length of slit in meters
dx = L/nx;					% ps CV length in x-dir
dy = H/ny;					% ps CV length in y-dir
x = (0:dx:L)';				% x position vector
y = (dy/2:dy:H-dy/2)';		% y postion vector
[xx,yy] = meshgrid(x,y);	% mesh os xy positions

%% u,v velocity and presure arrays for the nodes
us = zeros(ny,nx+1);		% us vel in m/s
vs = zeros(ny+1,nx+1);		% v vel in m/s
ps = zeros(ny,nx);			% pressure in pascals

%% fluid parameters (glycerin)
rho = 1264;					% density in kg/m^3
dyn_vis = 1.519;			% dynamic viscosity in kg/(m*s)
kin_vis = dyn_vis/rho;		% kinematic viscosity in m^2/s

%% u velocity boundary condition at inlet
U = 0.1;					% inlet velocity in m/s
us(:,1) = ones(ny,1)*U;
% make all middle section equal to U 
us(2:ny-1,1:nx)=U;

%% initial relaxation of the velocity/pressure fields
for iter=1:10
	for i=2:ny-1
		for j=2:nx
			us(i,j) = (us(i,j)+us(i-1,j)+us(i+1,j)+us(i,j-1)+us(i,j+1))/5;
		end
	end
	us(ceil(ny/2),:)=linspace(1*U,1.5*U,nx+1);
end
ps = 0.5*us(:,1:nx);

% plot initial u vel
%quiver(x,y,us,zeros(size(us)))
%rectangle('position',[0,0,L,H])

% calculate F,D, & P at all u nodes 
for i=2:ny-1
	for j=1:nx
		Fuij = rho*us(i,j);
		Dij = dyn_vis/dx;
		Pij = Fuij/Dij;
		fprintf(stdout,'At (%d,%d) Fu=%f & Du=%f & Pe=%f\n',i,j,Fuij,Dij,Pij)	
	end
end


