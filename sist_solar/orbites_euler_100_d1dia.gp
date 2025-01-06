set terminal pngcairo enhanced size 1500,1080 font "Cambria, 24"
set output "orbites_euler_100_d1dia.png" 

set xlabel "x (UA)"
set ylabel "y (UA)"
set xrange [-6:6]
set yrange [-6:6]
set grid


plot "sol_100_d1dia.dat" with lines lw 2 lc rgb "yellow" title "Sol", \
     "mercuri_100_d1dia.dat" with lines lw 2 lc rgb "orange" title "Mercuri", \
     "venus_100_d1dia.dat" with lines lw 2 lc rgb "green" title "Venus", \
     "terra_100_d1dia.dat" with lines lw 2 lc rgb "blue" title "Terra", \
     "mart_100_d1dia.dat" with lines lw 2 lc rgb "red" title "Mart", \
     "jupiter_100_d1dia.dat" with lines lw 2 lc rgb "purple" title "Júpiter"

set output