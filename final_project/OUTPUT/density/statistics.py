import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
import matplotlib.pyplot as plt
import math
plt.style.use('seaborn-whitegrid')



pres = np.loadtxt('pressure.dat')


density = pres[:,0]
kinetic = pres[:,1]



plt.show()

x = [1, 2, 3, 4]
y = [1, 4, 9, 16]


fig=plt.figure(10,(10,8))



plt.title('Correlation time binning data vs density')
plt.xlabel('Density $(g/cm^3$)')
plt.ylabel('$\u03C4_{corr}$')

plt.plot(density, kinetic,'x', color='black',markersize=7);






