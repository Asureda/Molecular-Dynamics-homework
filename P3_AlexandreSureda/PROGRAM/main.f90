PROGRAM SEQUENTIAL_MD

  use read_data
  use def_var
  use init
  use forces
  use verlet_algorithm
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

  call FCC_Initialize(r)
  call null_vel(v)

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
   call print_velocity(21)

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

  call print_velocity(22)
  call histo(v,n_particles,histogram)
  call print_results()

  call cpu_time(endtime)

  print*,'PROGRAM END'
  print*, 'Time =',endtime-starttime, 's'

END PROGRAM SEQUENTIAL_MD
