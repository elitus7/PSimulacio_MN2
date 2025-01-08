set terminal pngcairo size 800,600 enhanced font 'Arial,12'
set output 'histograma.png'

set boxwidth 0.8 relative
set style fill solid 0.5 border -1

set xlabel "Mesos"
set ylabel "Energia Generada (kWh)"

set xtics rotate by -45
set grid ytics

plot 'Energia_mesos_kWh.dat' using 2:xtic(1) with boxes lc rgb "blue" notitle
