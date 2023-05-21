import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit


def binning(array,magnitude):
     '''
     Function that returns the average
     and the standard deviation(w/ binning method)
     for a data array
     array :: NUMPY TYPE
     REURN
        - average
        - variance
        - correlation time

     '''

     def fitting(x,a,b,t):

     #Function to fit the S^2(m) to the the variance and the correlation time
     #   a : variance of the data set
     #   t : correlation time
         return a-b*np.exp(-x/t)
     # Converting to float64
     data=np.array(array,dtype=np.float64)
     #computug m as we need a power of 2
     x=np.int(np.log2(len(data)))
     #Getting the lower optimal size as a power of two
     n=2**x
     print(n)
     # array for the binnig with the optimal size to perform the algorithm
     data=data[0:n]
     average=np.sum(data)/(np.float64(len(data)))
     f = open('binning_'+magnitude+'.dat', "w")
     f.write("Final set of parametters for "+magnitude)
     print('naive average',average)
     f.write("\n<E>/N naive ="+str(average))

     #Initializing the vars
     bins=data.copy()
     vec_m=np.empty([0])
     vec_s2=np.empty([0])
     vec_aver = np.empty([0])

     #______________________________BINNING____________________________________
     for i in range(0,x):
         #in every iteration we add two consecutive numbers and get the average.
         #in every iteration we get the average as the sum for the array divided
         #for the number of bins
         #Then e compute the s^2
         m=2**i
         N_b=int(n/m)
         if(m>1000):
             break
         vec_m=np.append(vec_m,m)
         aver = np.sum(bins)/np.float64(N_b)
         #aver, s2 = mean_and_variance(bins)
         #aver = np.mean(bins, dtype=np.float64)
         vec_aver = np.append(vec_aver,aver)
         s2=np.sum((bins-aver)**2.0)/np.float64((N_b)*(N_b-1))
         #s2 = np.var(bins)
         s2 = np.sqrt(s2)
         vec_s2=np.append(vec_s2,s2)

         bins=(bins[0::2]+bins[1::2])/np.float64(2)


     #Getting the parameters for the fitting
     try:
          #trying to fit the curve
          popt,pcov=curve_fit(fitting,vec_m,vec_s2)
          af,bf,tf=popt
          y_fit=fitting(vec_m,af,bf,tf)
          #Ploting the results
          xx = np.linspace(1,1000,500)
          fig=plt.figure()
          plt.xscale('log')
          plt.xlim(1,1000)
          plt.title('Binning results')
          plt.xlabel('m')
          plt.ylabel('$\sigma_m$')
          plt.plot(vec_m,vec_s2,'x',color='black',markersize=5,label='data')
          plt.plot(xx,fitting(xx,af,bf,tf),'-.',color='black',linewidth=0.5, label='fit')
          plt.legend(loc='best')
          plt.show()
          fig.savefig('binning_S2_'+magnitude+'.png')
     except:
          #if the fit fails we get the avg of the binning
          af=np.sum(vec_s2)/np.float64(len(vec_s2))

          tf=0.0

     average1 = np.sum(vec_aver)/(np.float64(len(vec_aver)))
     corr_estim = vec_s2[-1]**2/vec_s2[0]**2
     f.write("\n<E>/N binning ="+str(average1))
     f.write("\nVar(A)="+str(af**2)+"\tSigma for <A>="+str(af))
     f.write("\ntau exp fit="+str(tf))
     f.write("\nCorrelation time estimated="+str(corr_estim))
     f.close()



     return average1, af , bf, tf
def jack_knife_1d(x,function):
    x_total=np.sum(x)
    jk_aver_x=[]
    for i in x:
        jk_aver_x.append((x_total-i)/np.float64(len(x)-1))
    #print(jk_aver_1)
    jk_func=np.array(list(map(lambda x : function(x),jk_aver_x)))
    #for i,j in zip(jk_aver_x,jk_aver_y):
    #    jk_func.append(function(i,j))
    #print(jk_func)
    #print(type(jk_func))
    jk_func_aver=np.sum(jk_func)/np.float64(len(x))
    #Error
    #s_sum=0.
    #for i in jk_func:
    # s_sum+=(i-jk_func_aver)**2.
    #print('sum',s_sum,np.sum((jk_func-jk_func_aver)**2.))
    err=np.sqrt((np.float64(len(x)-1))*np.sum((jk_func-jk_func_aver)**2.)/np.float64(len(x)))
    return jk_func_aver,err
def jack_knife_2d(x,y,function):
    x_total=np.sum(x)
    y_total=np.sum(y)
    jk_aver_x=[]
    jk_aver_y=[]
    for i,j in zip(x,y):
      #print(i,j)
      jk_aver_x.append((x_total-i)/np.float64(len(x)-1))
      jk_aver_y.append((y_total-j)/np.float64(len(y)-1))
    #print(jk_aver_1)
    jk_func=[]
    jk_func=np.array(list(map(lambda x,y : function(x,y),jk_aver_x,jk_aver_y )))
    #for i,j in zip(jk_aver_x,jk_aver_y):
    #    jk_func.append(function(i,j))
    #print(jk_func)
    #print(type(jk_func))
    jk_func_aver=np.sum(jk_func)/np.float64(len(x))
    #Error
    #s_sum=0.
    #for i in jk_func:
     #   s_sum+=(i-jk_func_aver)**2.
    #print('sum',s_sum,np.sum((jk_func-jk_func_aver)**2.))
    err=np.sqrt((np.float64(len(x)-1))*np.sum((jk_func-jk_func_aver)**2.)/np.float64(len(x)))
    return jk_func_aver,err

thermo = np.loadtxt('binning_thermodynamics.dat')
#Getting the lower optimal size as a power of two
pressure = thermo[:,4]
potential = thermo[:,1]
kinetic = thermo[:,0]
temperature = thermo[:,3]
average,sigma,b,tt=binning(potential,'potential')
average1,sigma1,b1,tt1=binning(pressure,'pressure')
average2,sigma2,b2,tt2=binning(kinetic,'kinetic')
average3,sigma3,b3,tt3=binning(temperature,'temperature')
