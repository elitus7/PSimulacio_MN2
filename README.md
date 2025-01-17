# PSimulació_MN2

En aquest repositori podeu trobar tots els codis, programes, gràfics i animacions corresponents a la pràctica de simulació de Mètodes Numèrics II usant Fortran (majoritàriament), Python (en el cas de les animacions) i Gnuplot (per representar les dades en forma de gràfiques i histogrames).

Podeu trobar la informació classificada en carpetes:

-->Animació: Codi corresponent a les animacions + animacions en format mp4. Per executar aquests codis i generar els arxius .mp4 de les animacions cal tenir instal·lat FFmpeg (una eina de línia de comandes per processar vídeos). https://ffmpeg.org/download.html

Un cop instal·lada, assegureu-vos que la carpeta on es troba FFmpeg estigui afegida a la variable d'entorn PATH. 

Si teniu problemes amb FFmpeg, podeu canviar a .gif i utilitzar Pillow com a escriptor (writer). Tingueu en compte que tarda bastant més. 

-->Error: Càlculs corresponents a l'error associat a les òrbites.

-->Latex: Document a latex en .pdf i arxiu .tex.

-->Moviment del Sol sobre la Terra: Codi per al càlcul del moviment del Sol sobre la Terra, usant les órbites obtingudes + gràfiques.

-->Sistema Solar: Aquí podeu trobar el codi principal per a l'implementació del mètode d'Euler per trobar les òrbites del Sistema Solar per diversos casos + les gràfiques.

Tots els codis en Fortran s'han de compilar prèviament emprant un compilador habitual, com ara bé gfortran.
