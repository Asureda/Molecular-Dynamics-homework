PROGRAM SEQUENTIAL_MD
  use read_data
  use def_var
  use init
  use forces

  IMPLICIT NONE
  integer :: kk,num_print
  real*8 :: starttime, endtime,cutoff
!##########################
! INITIAL CONFIGURATION
!#########################
  call read_all_data()
  call other_global_vars()
  call initialize_vars()
  call SC_Initialize(r)

  open(15,file='Energy.dat')
  open(16,file='positions.xyz')


  call cpu_time(starttime)

DO num_print = 1,4

  cutoff=(1.5+(num_print-1)*0.5)
  call force(r,F,cutoff)

  write(15,*)'rc =',cutoff,'potential (reduced units) = ', potential/dble(n_particles)&
  &,'potential (Kcal/mol)', energy_re*potential/dble(n_particles)

END DO

  WRITE(16,*)n_particles
  WRITE(16,*)
  DO kk=1,n_particles
    WRITE(16,*)'X',r(kk,:)
  END DO

call cpu_time(endtime)
if(add_pbc.eqv.(.TRUE.)) then
  write(15,*)'Energies calculated with PBC'
else
  write(15,*)'Energies calculated without PBC'
end if

print*,'PROGRAM END'
print*, 'Time =',endtime-starttime, 's'

END PROGRAM SEQUENTIAL_MD
