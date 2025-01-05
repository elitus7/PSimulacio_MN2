set terminal pngcairo enhanced size 1500,1080 font "Cambria, 24"
set output "error_1_hora.png" 

set xlabel "Hora"
set ylabel "Error Relatiu"
set xrange [2:8760]
set yrange [-0.025:0.025]
set grid
set format y "%.2f"


plot "error_1_hora.dat" using 1:2 with lines lw 5 lc rgb "yellow" title "Sol", \
     "error_1_hora.dat" using 1:3 with lines lw 2 lc rgb "orange" title "Mercuri", \
     "error_1_hora.dat" using 1:4 with lines lw 2 lc rgb "green" title "Venus", \
     "error_1_hora.dat" using 1:5 with lines lw 2 lc rgb "blue" title "Terra", \
     "error_1_hora.dat" using 1:6 with lines lw 2 lc rgb "red" title "Mart", \
     "error_1_hora.dat" using 1:7 with lines lw 2 lc rgb "purple" title "Júpiter"

set output