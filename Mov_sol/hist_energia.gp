set terminal pngcairo enhanced size 1500,1080 font "Cambria, 24"
set output 'histograma.png'

set boxwidth 0.8 relative
set style fill solid 0.5 border -1

set xlabel "Mesos"
set ylabel "Energia Generada (kW h)"

set xtics rotate by -45
set grid ytics

plot 'Energia_mesos_kWh.dat' using 2:xtic(1) with boxes lc rgb "blue" notitle
