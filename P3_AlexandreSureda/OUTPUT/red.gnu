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
set title '<Temperature> vs time'
set xlabel 'time (a.u.)'
set ylabel '<Temperature> (a.u.)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'T_prod.png'

plot 'thermodynamics.dat' u 1:($5) t '<T>' w p lc rgb "red"

# TEMPERATURE ---------------------------------------------------------------------
set title '<Temperature> vs time'
set xlabel 'time (a.u.)'
set ylabel '<Temperature> (a.u.)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'T_equil.png'

plot 'TP_red_equil.dat' u 1:($2) t '<T>' w p lc rgb "red"

# Variance ---------------------------------------------------------------------
#set title 'Variance vs m'
#set xlabel 'm (block size)'
#set ylabel 'σ (Variance)'
#set tics font ", 10"
#set autoscale
#set key outside
#set key bottom
#set key horizontal

# Generate output file
#set output 'variance.png'

#plot 'energy_bin.dat' u 1:($3) t 'σ' w p lc rgb "black"





