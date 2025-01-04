import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation


file_sol = "../PSIMULACIO_MN2/sist_solar/sol_TOTS_15_d1dia.dat "
file_mercuri = "../PSIMULACIO_MN2/sist_solar/mercuri_TOTS_15_d1dia.dat "
file_venus = "../PSIMULACIO_MN2/sist_solar/venus_TOTS_15_d1dia.dat "
file_terra = "../PSIMULACIO_MN2/sist_solar/terra_TOTS_15_d1dia.dat "
file_mart = "../PSIMULACIO_MN2/sist_solar/mart_TOTS_15_d1dia.dat"
file_jupiter = "../PSIMULACIO_MN2/sist_solar/jupiter_TOTS_15_d1dia.dat "
file_saturn = "../PSIMULACIO_MN2/sist_solar/saturn_TOTS_15_d1dia.dat "
file_ura = "../PSIMULACIO_MN2/sist_solar/ura_TOTS_15_d1dia.dat "
file_neptu = "../PSIMULACIO_MN2/sist_solar/neptu_TOTS_15_d1dia.dat "


files_planetes = [file_sol,
                  file_mercuri,
                  file_venus,
                  file_terra,
                  file_mart,
                  file_jupiter,
                  file_saturn,
                  file_ura,
                  file_neptu ]

dades_planetes = [ np.loadtxt(files) for files in files_planetes]
ntemps, npos = dades_planetes[0].shape

fig, ax = plt.subplots()
noms = ["Sol", "Mercuri", "Venus", "Terra", "Mart", "Júpiter", "Saturn", "Urà", "Neptú"]
lines = [ax.plot([], [], label= nom)[0] for nom in noms] 

ax.set_xlim(-30.3,30.3)
ax.set_ylim(-30.3,30.3)
ax.set_xlabel('x (UA)')
ax.set_ylabel('y (UA)')
ax.legend(loc='upper left')
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
anim.save('Anim/animacio_15anys_8planetes.mp4', writer='ffmpeg', fps=30)

