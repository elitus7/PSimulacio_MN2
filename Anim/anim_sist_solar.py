import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation


file_jupiter = "../PSIMULACIO_MN2/sist_solar/jupiter.dat "
file_mart = "../PSIMULACIO_MN2/sist_solar/mart.dat"
file_mercuri = "../PSIMULACIO_MN2/sist_solar/mercuri.dat "
file_terra = "../PSIMULACIO_MN2/sist_solar/terra.dat "
file_sol = "../PSIMULACIO_MN2/sist_solar/sol.dat "
file_venus = "../PSIMULACIO_MN2/sist_solar/venus.dat "

files_planetes = [file_jupiter,
                  file_mart,
                  file_mercuri, 
                  file_terra,
                  file_sol,
                  file_venus]

dades_planetes = [ np.loadtxt(files) for files in files_planetes]
dades_venus = np.loadtxt(file_venus)

num_planetes = len(files_planetes)
ntemps, npos = dades_planetes[0].shape

fig, ax = plt.subplots()
noms = ["Júpiter", "Mart", "Mercuri", "Terra", "Sol", "Venus"]
lines = [ax.plot([], [], label= nom)[0] for nom in noms] 

ax.set_xlim(-6,6)
ax.set_ylim(-6,6)
ax.legend()

def init(): 
    for line in lines:
        line.set_data([],[])
    return lines

def update(frame):
    for i, line in enumerate(lines):
        data = dades_planetes[i]
        x, y = data[frame, 0], data[frame, 1]
        line.set_data(data[:frame + 1, 0], data[:frame +1, 1])
    return lines


anim = animation.FuncAnimation(fig, update, frames = ntemps, init_func =init, blit = True, interval= 20)
anim.save('Anim/animacio_planetes.gif', writer='pillow', fps=30)

plt.show()
