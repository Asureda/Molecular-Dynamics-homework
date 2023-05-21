PROGRAM SEQUENTIAL_MD

  use read_data
  use def_var
  use init
  use forces
  use verlet_algorithm
  use sample

  IMPLICIT NONE
  real*8 :: starttime, endtime,cutoff
!##########################
! INITIAL CONFIGURATION
!#########################
  call read_all_data()
  call other_global_vars()
  call initialize_vars()
  !call SC_Initialize(r)
  call two_particle(r,r_old,v)
  !call Uniform_velocity(v)
  !call velo_rescal(v,Temp)
  open(15,file='Energy_red.dat')
  open(16,file='Energy_real.dat')
  open(17,file='TP_red.dat')
  open(18,file='TP_real.dat')
  open(20,file='momentum.dat')
  open(21,file='distance.dat')




  open(19,file='positions.xyz')


  call cpu_time(starttime)

  DO nstep = 1,n_verlet
    t = t_a + nstep*h
    call velo_verlet(r,v,F)
    !call euler(r,v,F)
    !call verlet(r,r_old,v,F)
    call samples()
  END DO

  call cpu_time(endtime)

  print*,'PROGRAM END'
  print*, 'Time =',endtime-starttime, 's'

END PROGRAM SEQUENTIAL_MD
