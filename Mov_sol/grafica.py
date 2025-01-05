import numpy as np
import matplotlib.pyplot as plt


arxiu =  "../PSIMULACIO_MN2/Mov_sol/mov_sol.dat "

data = np.loadtxt(arxiu)

x = data[:, 0]  
y = data[:, 1] 


plt.plot(x, y)
plt.show()