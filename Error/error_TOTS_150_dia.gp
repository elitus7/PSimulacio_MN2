set terminal pngcairo enhanced size 1500,1080 font "Cambria, 24"
set output "error_TOTS_150_dia.png" 

set xlabel "Dia"
set ylabel "Error Relatiu"
set xrange [2:36600/2] #Per tal de poder visualitzar-ho tot i atès que el comportament és periòdic representem únicament la meitat de les daedes.
set yrange [-1:1]
set grid
set format y "%.2f"

set key right bottom

plot "error_TOTS_150_dia.dat" using 1:2 with lines lw 5 lc rgb "yellow" title "Sol", \
     "error_TOTS_150_dia.dat" using 1:3 with lines lw 2 lc rgb "orange" title "Mercuri", \
     "error_TOTS_150_dia.dat" using 1:4 with lines lw 2 lc rgb "green" title "Venus", \
     "error_TOTS_150_dia.dat" using 1:5 with lines lw 2 lc rgb "blue" title "Terra", \
     "error_TOTS_150_dia.dat" using 1:6 with lines lw 2 lc rgb "red" title "Mart", \
     "error_TOTS_150_dia.dat" using 1:7 with lines lw 2 lc rgb "purple" title "Júpiter", \
     "error_TOTS_150_dia.dat" using 1:8 with lines lw 2 lc rgb "pink" title "Saturn", \
     "error_TOTS_150_dia.dat" using 1:9 with lines lw 2 lc rgb "magenta" title "Urà", \
     "error_TOTS_150_dia.dat" using 1:10 with lines lw 2 lc rgb "grey" title "Neptú"

set output