set terminal pngcairo enhanced size 1500,1080 font "Arial,12"
set output "terramov.png" 

set xlabel("x (UA)")
set ylabel("y (UA)")
set xrange[-2:2]
set yrange[-2:2]
plot "terra.dat" with lines

set output