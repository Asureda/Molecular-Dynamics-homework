###################################################################################
# GRAPHIC OF THE ENERGIES, INSTANTANEOUS TEMPERATURE AND PRESSURE (REDUCED UNITS) #
###################################################################################

# SET TERMINAL
set term png

# ENERGIES ---------------------------------------------------------------------
set title '<Energies> vs time'
set xlabel 'time (a.u.)'
set ylabel '<Energies> (a.u.)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'energy_reduced.png'

plot 'Energy_red.dat' u 1:($2) t '<Kinetic Energy>' w l lw 1 lc rgb "orange",\
'' u 1:($3) t '<Potential Energy>' w l lw 1 lc rgb "green",\
'' u 1:($4) t '<Total Energy>' w l lw 1 lc rgb "#9400d3"

# MOMENTUM ---------------------------------------------------------------------
set title '<Momentum> vs time'
set xlabel 'time (a.u.)'
set ylabel '<Momentum> (a.u.)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'momentum.png'

plot 'momentum.dat' u 1:($2) t '<px>' w l lw 1 lc rgb "orange",\
'' u 1:($3) t '<vx particle #1>' w l lw 1 lc rgb "green",\
'' u 1:($4) t '<vx particle #2>' w l lw 1 lc rgb "#9400d3"

# DISTANCE ---------------------------------------------------------------------
set title '<Distance> vs time'
set xlabel 'time (a.u.)'
set ylabel '<Distance> (a.u.)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'distance.png'

plot 'distance.dat' u 1:($2) t '<Distance>' w l lw 1 lc rgb "blue",\




