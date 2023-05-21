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
set output 'Energy_red_prod.png'

plot 'thermodynamics.dat' u 1:($2) t '<Kinetic Energy>' w l lw 1 lc rgb "orange",\
'' u 1:($3) t '<Potential Energy>' w l lw 1 lc rgb "green",\
'' u 1:($4) t '<Total Energy>' w l lw 1 lc rgb "#9400d3"


# TEMPERATURE ---------------------------------------------------------------------
set title 'Instantaneous Temperature vs time'
set xlabel 'time (a.u.)'
set ylabel '<Temperature> (a.u.)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'T_prod.png'

plot 'thermodynamics.dat' u 1:($5) notitle w l lw 1 lc rgb "#00008b"

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

plot 'thermodynamics.dat' u 1:($7) t '<px>' w l lc rgb "red",\
'' u 1:($8) t '<py>' w l lw 1 lc rgb "green",\
'' u 1:($9) t '<pz>' w l lw 1 lc rgb "#9400d3"


# pressure ---------------------------------------------------------------------
set title 'Pressure vs time'
set xlabel 'time (a.u.)'
set ylabel '<Pressure> (a.u.)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'pressure.png'

plot 'thermodynamics.dat' u 1:($6) notitle w l lw 1 lc rgb "red"

# gdr ---------------------------------------------------------------------
# RDF (g(r))
set title 'Radial Distribution Function'
set xlabel 'r (Angstrom)'
set ylabel 'g(r)'
set tics font ", 10"
set autoscale

# Generate output file
set output 'g_r.png'
plot 'gdr.dat' u 1:2 notitle w l lw 1 lc rgb "dark-violet"



