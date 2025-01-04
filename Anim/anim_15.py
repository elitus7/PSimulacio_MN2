import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation


file_sol = "../PSIMULACIO_MN2/sist_solar/sol_15_d1dia.dat "
file_mercuri = "../PSIMULACIO_MN2/sist_solar/mercuri_15_d1dia.dat "
file_venus = "../PSIMULACIO_MN2/sist_solar/venus_15_d1dia.dat "
file_terra = "../PSIMULACIO_MN2/sist_solar/terra_15_d1dia.dat "
file_mart = "../PSIMULACIO_MN2/sist_solar/mart_15_d1dia.dat"
file_jupiter = "../PSIMULACIO_MN2/sist_solar/jupiter_15_d1dia.dat "
'''
file_saturn = "../PSIMULACIO_MN2/sist_solar/saturn_1_d1dia.dat "
file_ura = "../PSIMULACIO_MN2/sist_solar/ura_1_d1dia.dat "
file_neptu = "../PSIMULACIO_MN2/sist_solar/neptu_1_d1dia.dat "
'''

files_planetes = [file_sol,
                  file_mercuri,
                  file_venus,
                  file_terra,
                  file_mart,
                  file_jupiter]

dades_planetes = [ np.loadtxt(files) for files in files_planetes]
dades_venus = np.loadtxt(file_venus)

num_planetes = len(files_planetes)
ntemps, npos = dades_planetes[0].shape

fig, ax = plt.subplots()
noms = ["Sol", "Mercuri", "Venus", "Terra", "Mart", "Júpiter"]
lines = [ax.plot([], [], label= nom)[0] for nom in noms] 

ax.set_xlim(-6,6)
ax.set_ylim(-6,6)
ax.set_xlabel('x (UA)')
ax.set_ylabel('y (UA)')
ax.legend()
ax.grid()

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
anim.save('Anim/animacio_planetes_15anys.mp4', writer='ffmpeg', fps=30)

