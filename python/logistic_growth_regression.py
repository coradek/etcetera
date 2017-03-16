# The folowing script is a ROUGH DRAFT of code to regress the sigmoid function.
# Mainly as an excuse to play with scipy optimize.

#Using scipy.optimize.leastsq:
# Thank you stackoverflow: http://stackoverflow.com/questions/4308168/sigmoidal-regression-with-scipy-numpy-python-etc

import numpy as np
import matplotlib.pyplot as plt
import scipy.optimize


def sigmoid(p,x):
  x0,y0,c,k=p
  y = c / (1 + np.exp(-k*(x-x0))) + y0
  return y


def residuals(p,x,y):
  return y - sigmoid(p,x)


def resize(arr,lower=0.0,upper=1.0):
  arr=arr.copy()
  if lower>upper: lower,upper=upper,lower
  arr -= arr.min()
  arr *= (upper-lower)/arr.max()
  arr += lower
  return arr


def main():
    # raw data
    x = np.arange(1, 33, dtype='float')
    y = np.array([10, 20, 30, 40, 51, 61, 77, 99, 128, 163, 203, 251, 298,
                    345, 393, 455, 531, 622, 727, 847, 981, 1116, 1251, 1402,
                    1554, 1752, 1981, 2241, 2532, 2855, 3209, 3595],
                dtype='float')

    x=resize(x,lower=0.01)
    y=resize(y,lower=0.01)
    print(x)
    print(y)
    p_guess=(np.median(x),np.median(y),1.0,1.0)
    p, cov, infodict, mesg, ier = scipy.optimize.leastsq(
      residuals,p_guess,args=(x,y),full_output=1)

    x0,y0,c,k=p
    print('''\
    x0 = {x0}
    y0 = {y0}
    c = {c}
    k = {k}
    '''.format(x0=x0,y0=y0,c=c,k=k))

    xp = np.linspace(0, 1.1, 1500)
    pxp=sigmoid(p,xp)

    # Plot the results
    plt.plot(x, y, '.', xp, pxp, '-')
    plt.xlabel('x')
    plt.ylabel('y',rotation='horizontal')
    plt.grid(True)
    plt.show()


if __name__ == '__main__':
    main()
