set terminal pngcairo enhanced size 1500,1080 font "Cambria, 24"
set output "error_100_dia.png" 

set xlabel "Dia"
set ylabel "Error Relatiu"
set xrange [2:36600/4] #Per tal de poder visualitzar-ho tot i atès que el comportament és periòdic representem únicament una part de les daedes.
set yrange [-0.08:0.04]
set grid
set format y "%.2f"

set key right bottom

plot "error_100_dia.dat" using 1:2 with lines lw 5 lc rgb "yellow" title "Sol", \
     "error_100_dia.dat" using 1:3 with lines lw 2 lc rgb "orange" title "Mercuri", \
     "error_100_dia.dat" using 1:4 with lines lw 2 lc rgb "green" title "Venus", \
     "error_100_dia.dat" using 1:5 with lines lw 2 lc rgb "blue" title "Terra", \
     "error_100_dia.dat" using 1:6 with lines lw 2 lc rgb "red" title "Mart", \
     "error_100_dia.dat" using 1:7 with lines lw 2 lc rgb "purple" title "Júpiter"

set output