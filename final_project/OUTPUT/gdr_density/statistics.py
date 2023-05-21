import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit




gdr_08 = np.loadtxt('gdr_08.dat')
gdr_07 = np.loadtxt('gdr_07.dat')
gdr_06 = np.loadtxt('gdr_06.dat')
gdr_05 = np.loadtxt('gdr_05.dat')
gdr_04 = np.loadtxt('gdr_04.dat')
gdr_03 = np.loadtxt('gdr_03.dat')
gdr_02 = np.loadtxt('gdr_02.dat')
gdr_01 = np.loadtxt('gdr_01.dat')

r1 = gdr_08[:,0]
r2 = gdr_07[:,0]
r3 = gdr_06[:,0]
r4 = gdr_05[:,0]
r5 = gdr_04[:,0]
r6 = gdr_03[:,0]
r7 = gdr_02[:,0]
r8 = gdr_01[:,0]

dens_08 = gdr_08[:,1]
dens_07 = gdr_07[:,1]
dens_06 = gdr_06[:,1]
dens_05 = gdr_05[:,1]
dens_04 = gdr_04[:,1]
dens_03 = gdr_03[:,1]
dens_02 = gdr_02[:,1]
dens_01 = gdr_01[:,1]


fig=plt.figure(figsize=(10, 7))
plt.xlim(0,14)
plt.title('Radial Distribution Function')
plt.xlabel(r'r ($\AA$)')
plt.ylabel('g(r)')
plt.plot(r1,dens_08,'-',color='black',linewidth=1,label=r'$\rho$ = 0.8')
#plt.plot(r2,dens_07,'--',color='black',linewidth=0.5,label='rho = 0.7')
plt.plot(r3,dens_06,'-',color='blue',linewidth=1,label=r'$\rho$ = 0.6')
#plt.plot(r4,dens_05,':',color='black',linewidth=0.5,label='rho = 0.5')
plt.plot(r5,dens_04,'-',color='red',linewidth=1,label=r'$\rho$ = 0.4')
#plt.plot(r6,dens_03,':',color='black',linewidth=0.5,label='rho = 0.3')
plt.plot(r7,dens_02,'-',color='green',linewidth=1,label=r'$\rho$ = 0.2')
plt.plot(r8,dens_01,'-',color='orange',linewidth=1,label=r'$\rho$ = 0.1')

plt.legend(loc='best')
fig.savefig('test_results.png')




