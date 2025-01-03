set terminal pngcairo enhanced size 1800,1080 font "Cambria, 20"
set output "orbites_euler_TOTS_150_d1dia.png" 

set xlabel "x (UA)"
set ylabel "y (UA)"
set xrange [-35:35]
set yrange [-35:35]
set grid


plot "sol_TOTS_150_d1dia.dat" with lines lw 2 lc rgb "yellow" title "Sol", \
     "mercuri_TOTS_150_d1dia.dat" with lines lw 2 lc rgb "orange" title "Mercuri", \
     "venus_TOTS_150_d1dia.dat" with lines lw 2 lc rgb "green" title "Venus", \
     "terra_TOTS_150_d1dia.dat" with lines lw 2 lc rgb "blue" title "Terra", \
     "mart_TOTS_150_d1dia.dat" with lines lw 2 lc rgb "red" title "Mart", \
     "jupiter_TOTS_150_d1dia.dat" with lines lw 2 lc rgb "purple" title "Júpiter", \
     "saturn_TOTS_150_d1dia.dat" with lines lw 2 lc rgb "pink" title "Saturn", \
     "ura_TOTS_150_d1dia.dat" with lines lw 2 lc rgb "cyan" title "Urà", \
     "neptu_TOTS_150_d1dia.dat" with lines lw 2 lc rgb "magenta" title "Neptú"

set output