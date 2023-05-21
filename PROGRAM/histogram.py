# -*- coding: utf-8 -*-
#!/usr/bin/env python
"""
Created on Tue Jun 23 01:55:33 2020

@author: asure
"""
import numpy as np
import matplotlib.pyplot as plt


vel_old = np.loadtxt('velocity_old.dat')
vel_new = np.loadtxt('velocity_new.dat')
vel_f90 = np.loadtxt('MB_velocityDistribution.dat')


#data3 = np.loadtxt('DTheta_vs_t.dat')

vx_old = vel_old[:, 0]
vy_old = vel_old[:, 1]
vz_old = vel_old[:, 2]
vx_new = vel_new[:, 0]
vy_new = vel_new[:, 1]
vz_new = vel_new[:, 2]
vel1 = (vx_old**2+vy_old**2+vz_old**2)**0.5
vel2 = (vx_new**2+vy_new**2+vz_new**2)**0.5
v_f90 = vel_f90[:, 0]
freq = vel_f90[:, 1]
# Histograma de distribucio uniforme velocitats principi de la simulacio
plt.hist(vel1, bins='auto', alpha=1, edgecolor = 'black',  linewidth=1, density=True)
plt.ylabel('freqüència')
plt.xlabel('valors velocitat')
plt.title('Histograma velocitats reescalades al principi de la simulació')
plt.show()

# Histograma de distribucio uniforme velocitats principi de la simulacio
plt.hist(vel2, bins='auto', alpha=1, edgecolor = 'black',  linewidth=1, density=True)
plt.ylabel('freqüència')
plt.xlabel('valors velocitat')
plt.title('Histograma velocitats reescalades al final de la simulació')
plt.show()
############################################
# Comparison with theoretical results
############################################
fig, ax = plt.subplots(figsize=(7.5,7.5))
# Compute histogram of velocities using the last half of the trajectory
# Flatten is equired to transform a 2d array into a 1d array
ax.hist(vx_old,bins='auto',normed=True,alpha=0.5,lw=0,label=r"$V_x$")
ax.hist(vy_old,bins='auto',normed=True,alpha=0.5,lw=0,label=r"$V_y$")
ax.hist(vz_old,bins='auto',normed=True,alpha=0.5,lw=0,label=r"$V_z$")

# Draw theoretical gaussian distribution 0:728.
ax.set_xlabel(r"$V_{\alpha}$",fontsize=20)
ax.set_ylabel(r"$P(V_{\alpha})$", fontsize=20)
ax.set_xlim(-5, 5)
ax.set_ylim(0, 1)
ax.legend(fontsize=10, loc=3,framealpha=0.9)
plt.savefig('Histograma_inicial_velocities.png', dpi=200)
plt.show()


############################################
# Comparison with theoretical results
############################################
fig, ax = plt.subplots(figsize=(7.5,7.5))
# Compute histogram of velocities using the last half of the trajectory
# Flatten is equired to transform a 2d array into a 1d array
ax.hist(vx_new,bins='auto',normed=True,alpha=0.5,lw=0,label=r"$V_x$")
ax.hist(vy_new,bins='auto',normed=True,alpha=0.5,lw=0,label=r"$V_y$")
ax.hist(vz_new,bins='auto',normed=True,alpha=0.5,lw=0,label=r"$V_z$")

kBT = 101.67137433242462
m = 1
sig2= kBT/m
ave=0.0
x = np.arange(-30,30,0.1)
y = np.exp(-(x-ave)**2/2/sig2)/np.sqrt(2*np.pi*sig2)


# Draw theoretical gaussian distribution
ax.plot(x,y,lw=4,color='k',label=r"Maxwell-Boltzmann $(\sigma^2=k_BT/m)$")
ax.set_xlabel(r"$V_{\alpha}$",fontsize=20)
ax.set_ylabel(r"$P(V_{\alpha})$", fontsize=20)
ax.set_xlim(-30, 30)
ax.set_ylim(0, 0.1)
ax.legend(fontsize=14, loc=2,framealpha=0.9)
plt.savefig('Histograma_final1_velocities.png', dpi=200)
plt.show()

fig, ax = plt.subplots(figsize=(7.5,7.5))
# Compute histogram of velocities using the last half of the trajectory
# Flatten is equired to transform a 2d array into a 1d array
kBT = 101.67137433242462
m = 1
sig2= kBT/m
ave=0.0
x = np.arange(-30,30,0.1)
y = np.exp(-(x-ave)**2/2/sig2)/np.sqrt(2*np.pi*sig2)

# Draw theoretical gaussian distribution
ax.scatter(v_f90,freq,color='k',label=r"V_{x,y,z}$")
ax.plot(x,y,lw=4,color='k',label=r"Maxwell-Boltzmann $(\sigma^2=k_BT/m)$")
ax.set_xlabel(r"$V_{\alpha}$",fontsize=20)
ax.set_ylabel(r"$P(V_{\alpha})$", fontsize=20)
ax.set_xlim(-30, 30)
ax.set_ylim(0, 0.1)
ax.legend(fontsize=14, loc=2,framealpha=0.9)
plt.savefig('MB.png', dpi=200)
plt.show()
