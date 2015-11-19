############################################################
### Basic model of HIV dynamics before and during treatment
############################################################

# This is the starting script to the module "Within-host HIV dynamics: the emergence of drug resistance".

# Note: the 'deSolve' library is not part of the basic distribution of R and must be installed separately

###################################
# FUNCTION DEFINITIONS
###################################

###
# hiv(t,x,parms) 
# Use:  Function to calculate derivative of equations in the basic HIV model.
#       Note that this is a variant with no explicit variable for the virus level.
# Input:
# 	t: time (not used here, because there is no explicit time dependence)
# 	x: vector of the current values of all variables
# 	parms: 	dummy variable, which is not used here (normally used to pass on 
#		parameter values, but not needed here because parameters are defined globally)
# Output:
#	der: vector of derivatives

hiv <- function(t,x,parms){
  with(as.list(c(x)),{                # this structure allows us to refer to the elements of x directly
    dt <- lambda - d*T - (1-eps)*b*T*I
    di <- (1-eps)*b*T*I - a*I     
    der <- c(dt,di)
    list(der)
  })    
}

###
# n.integrate(start,end,intstep,init.x,model)
# Use:	Numerical integration of model. Generates a vector of time points for the integration
#       and uses function lsoda (from library odesolve) to integrate the model
# Input:
# 	start: 	start point of integration
# 	end: 	endpoint of integration
#       intstep: the number of integration time points per unit time
#		 a default value is provided
# 	init.x: vector of initial values (at time = start) of all variables
# 	model: 	name of the function to integrate
# Output:
#	data frame with n+1 columns. The first column contains the time points at which
#	x is evaluated. The next n columns are the values of the n variables at these
#	time points

n.integrate <- function(start,end,intstep=10,init.x,model){
  t.out <- seq(start,end,length=(end-start)*intstep+1)
  as.data.frame(lsoda(init.x,t.out,model,parms=parms))
}

###########################
# MAIN PROGRAM
###########################

### LOAD LIBRARIES
#load R library for ordinary differential equation solvers
library(deSolve)

### INITIALIZE PARAMETER SETTINGS

## Model parameters (defined on the time scale of days)
#  I define parameters globally to be able to change them between runs easily

lambda=5
d=0.5
b=0.25
a=1
eps=0

parms <- c() # dummy variable needed for lsoda

# Initial conditions (i.e. the values of all variables at time = start)
I0 <- 1   # to model initial infection
T0 <- lambda/d   # to start from uninfected steady state

init.x <- c(T=T0,I=I0)

### Simulation of initial infection

simlength <- 20
out <- n.integrate(start=0,end=simlength,init.x=init.x,model=hiv)
attach(out)  # this allows us to refer to data columns in out directly

# Plot time course
plot(c(0,simlength),c(0,T0),type="n",main="Initial infection",xlab="time (days)",ylab="")
lines(time,T,lwd=2)
lines(time,I,col="red",lwd=2)
legend(simlength*0.7,T0*0.8,c("T","I"),lwd=c(2,2),col=c("black","red"))

# save endpoint and remove out from search path
init.x <- c(T=T[length(T)],I=I[length(I)])  # save endpoint into init.x
detach(out)

### Simulation of drug treatment with no resistance

# weak drug

eps=0.5
out <- n.integrate(start=0,end=simlength,init.x=init.x,model=hiv)

attach(out)  # this allows us to refer to data columns in out directly
plot(c(0,simlength),c(0,T0),type="n",main="Treatment with weak drug",xlab="time (days)",ylab="")
lines(time,T,lwd=2)
lines(time,I,col="red",lwd=2)
legend(simlength*0.7,T0*0.6,c("T","I"),lwd=c(2,2),col=c("black","red"))
detach(out)

# strong drug

eps=0.9
out <- n.integrate(start=0,end=simlength,init.x=init.x,model=hiv)

# Plot time course
attach(out)  # this allows us to refer to data columns in out directly
plot(c(0,simlength),c(0,T0),type="n",main="Treatment with strong drug",xlab="time (days)",ylab="")
lines(time,T,lwd=2)
lines(time,I,col="red",lwd=2)
legend(simlength*0.7,T0*0.8,c("T","I"),lwd=c(2,2),col=c("black","red"))
detach(out)