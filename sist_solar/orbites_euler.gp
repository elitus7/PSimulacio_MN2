set terminal pngcairo enhanced size 1500,1080 font "Cambria, 20"
set output "orbites_euler.png" 

set xlabel "x (UA)"
set ylabel "y (UA)"
set xrange [-3:3]
set yrange [-3:6]
set grid


plot "sol.dat" with lines lw 2 lc rgb "yellow" title "Sol", \
     "mercuri.dat" with lines lw 2 lc rgb "orange" title "Mercuri", \
     "venus.dat" with lines lw 2 lc rgb "green" title "Venus", \
     "terra.dat" with lines lw 2 lc rgb "blue" title "Terra", \
     "mart.dat" with lines lw 2 lc rgb "red" title "Mart", \
     "jupiter.dat" with lines lw 2 lc rgb "purple" title "Júpiter"

set output