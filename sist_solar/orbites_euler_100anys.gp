set terminal pngcairo enhanced size 1500,1080 font "Cambria, 20"
set output "orbites_euler_100anys.png" 

set xlabel "x (UA)"
set ylabel "y (UA)"
set xrange [-6:6]
set yrange [-6:6]
set grid


plot "sol100anys.dat" with lines lw 2 lc rgb "yellow" title "Sol", \
     "mercuri100anys.dat" with lines lw 2 lc rgb "orange" title "Mercuri", \
     "venus100anys.dat" with lines lw 2 lc rgb "green" title "Venus", \
     "terra100anys.dat" with lines lw 2 lc rgb "blue" title "Terra", \
     "mart100anys.dat" with lines lw 2 lc rgb "red" title "Mart", \
     "jupiter100anys.dat" with lines lw 2 lc rgb "purple" title "Júpiter"

set output