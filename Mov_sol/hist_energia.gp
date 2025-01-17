set terminal pngcairo enhanced size 1500,1080 font "Cambria, 24"
set output 'histograma.png'

set style data histogram
set style fill solid 1.0 border rgb "#21A8FF"  # Color de las barras y los bordes
set boxwidth 0.8 relative

set xlabel "Mesos"
set ylabel "Energia Generada (kW h)"
set xtics rotate by -45  # Rota las etiquetas del eje x para mayor legibilidad

set ytics 10
set border 0  # Elimina el borde alrededor del gráfico
set xtics nomirror  # Ajusta los tics del eje x para no tener tics duplicados
set ytics nomirror  # Ajusta los tics del eje y para no tener tics duplicados

# Establecer el rango del eje X con un pequeño margen para la primera barra
set xrange [-0.5:12.5]  # Se amplía el rango ligeramente para no cortar la primera barra

# Dibujar líneas horizontales manualmente en gris claro
do for [i=10:1000:10] {
    set arrow from -0.5,i to 12,i nohead lc rgb "#888888" lw 1.5  # Las flechas terminan en 12
}

plot 'Energia_mesos_kWh.dat' using 2:xtic(1) with boxes lc rgb "#21A8FF" notitle
