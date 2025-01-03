set terminal pngcairo enhanced size 1800,1080 font "Cambria, 20"
set output "orbites_euler_tots.png" 

set xlabel "x (UA)"
set ylabel "y (UA)"
set xrange [-35:35]
set yrange [-35:35]
set grid


plot "sol_tots.dat" with lines lw 2 lc rgb "yellow" title "Sol", \
     "mercuri_tots.dat" with lines lw 2 lc rgb "orange" title "Mercuri", \
     "venus_tots.dat" with lines lw 2 lc rgb "green" title "Venus", \
     "terra_tots.dat" with lines lw 2 lc rgb "blue" title "Terra", \
     "mart_tots.dat" with lines lw 2 lc rgb "red" title "Mart", \
     "jupiter_tots.dat" with lines lw 2 lc rgb "purple" title "Júpiter", \
     "saturn_tots.dat" with lines lw 2 lc rgb "pink" title "Saturn", \
     "ura_tots.dat" with lines lw 2 lc rgb "cyan" title "Urà", \
     "neptu_tots.dat" with lines lw 2 lc rgb "magenta" title "Neptú"

set output