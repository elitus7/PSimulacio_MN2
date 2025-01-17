set terminal pngcairo enhanced size 1500,1080 font "Cambria, 24"
set output "mov_sol_mesos.png"

set xlabel "Posició x (UA)"
set ylabel "Posició y (UA)"
set xrange [-1.1:1.1]
set yrange [0:0.9]
set grid
set format y "%.2f"
set format x "%.2f"
set key

plot "mov_sol_21gener.dat" with lines lw 2 lc rgb "black" title "21 Jan", \
     "mov_sol_21febrer.dat" with lines lw 2 lc rgb "gray" title "21 Feb", \
     "mov_sol_21marc.dat" with lines lw 2 lc rgb "purple" title "21 Mar", \
     "mov_sol_21abril.dat" with lines lw 2 lc rgb "yellow" title "21 Apr", \
     "mov_sol_21maig.dat" with lines lw 2 lc rgb "green" title "21 May", \
     "mov_sol_21juny.dat" with lines lw 2 lc rgb "orange" title "21 Jun", \
     "mov_sol_21juliol.dat" with lines lw 2 lc rgb "red" title "21 Jul", \
     "mov_sol_21agost.dat" with lines lw 2 lc rgb "brown" title "21 Aug", \
     "mov_sol_21setembre.dat" with lines lw 2 lc rgb "blue" title "21 Sep", \
     "mov_sol_21octubre.dat" with lines lw 2 lc rgb "pink" title "21 Oct", \
     "mov_sol_21novembre.dat" with lines lw 2 lc rgb "magenta" title "21 Nov", \
     "mov_sol_21desembre.dat" with lines lw 2 lc rgb "cyan" title "21 Dec"

set output
