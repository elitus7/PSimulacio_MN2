set terminal pngcairo enhanced size 1500,1080 font "Cambria, 24"
set output "mov_sol_solstici.png" 

set xlabel "Posició x (UA)"
set ylabel "Posició y (UA)"
set xrange [-1.1:1.1]
set yrange [0:0.9]
set grid
set format y "%.2f"
set format x "%.2f"
unset key


plot "mov_sol_21juny.dat" with lines lw 5 lc rgb "orange"

set output