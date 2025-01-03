set terminal pngcairo enhanced size 1500,1080 font "Cambria, 20"
set output "orbites_euler_1_d1hora.png" 

set xlabel "x (UA)"
set ylabel "y (UA)"
set xrange [-3:3]
set yrange [-3:6]
set grid


plot "sol_1_d1hora.dat" with lines lw 5 lc rgb "yellow" title "Sol", \
     "mercuri_1_d1hora.dat" with lines lw 2 lc rgb "orange" title "Mercuri", \
     "venus_1_d1hora.dat" with lines lw 2 lc rgb "green" title "Venus", \
     "terra_1_d1hora.dat" with lines lw 2 lc rgb "blue" title "Terra", \
     "mart_1_d1hora.dat" with lines lw 2 lc rgb "red" title "Mart", \
     "jupiter_1_d1hora.dat" with lines lw 2 lc rgb "purple" title "Júpiter"

set output