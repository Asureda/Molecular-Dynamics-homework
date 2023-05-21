PROGRAM SEQUENTIAL_MD

  use read_data
  use def_var
  use init
  use forces
  use verlet_algorithm
  use radial_dist
  use sample

  IMPLICIT NONE
  real*8        :: starttime, endtime

  call read_all_data()
  call other_global_vars()
  call initialize_vars()

  call cpu_time(starttime)

!##########################
! INITIAL CONFIGURATION
!#########################
  call random_seed
  call FCC_Initialize(r)
  call uniform_velocity(v)
  call velo_rescal(v,T_therm)
!##########################
! EQUILIBRATION RUN
!#########################

  DO nstep=1,n_eq
    t=t_a+nstep*h_eq
    call velo_verlet(r,v,F,h_eq)
    call andersen(v,T_therm)
    call sample_equilibration()
  END DO

!##########################
! REESCALING VELOCITY
!#########################

   call Uniform_velocity(v)
   call velo_rescal(v,Temp)

!##########################
! PRODUCTION RUN
!#########################

  DO nstep=1,n_verlet
    t=t_a+nstep*h
    call velo_verlet(r,v,F,h)
    if(is_thermostat.eqv..true.)THEN
      call andersen(v,Temp)
    end if
    call sample_production()
  END DO

  CALL gdr(21)

  call print_binning(22)
  call print_results()

  call cpu_time(endtime)

  print*,'PROGRAM END'
  print*, 'Time =',endtime-starttime, 's'

END PROGRAM SEQUENTIAL_MD
