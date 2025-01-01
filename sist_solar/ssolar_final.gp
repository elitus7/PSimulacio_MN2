set terminal pngcairo enhanced size 1500,1080 font "Arial,12"
set output "ssolar_final.png" 

set xlabel("x (UA)")
set ylabel("y (UA)")
set xrange[-5:6]
set yrange[-5:6]
plot "pfinal_ssolar.dat" with points pointsize 3 pointtype 2 linewidth 2 title "Cossos del Sistema Solar"

set output