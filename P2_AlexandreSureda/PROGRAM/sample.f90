MODULE SAMPLE
use read_data
use pbc
use def_var
IMPLICIT NONE
INTEGER ii, kk
contains
SUBROUTINE SAMPLES()
  real*8 ::dx,dy,dz,d
! Calculates the final values of these magnitudes and their statistical treatment
  if((mod(nstep,n_meas).eq.0).and.(is_print_thermo.eqv..true.))then

    DO ii = 1,n_particles
      px = px + v(ii,1)
      py = py + v(ii,2)
      pz = pz + v(ii,3)
    END DO


      dx=PBC2(r(1,1)-r(2,1),L)
      dy=PBC2(r(1,2)-r(2,2),L)
      dz=PBC2(r(1,3)-r(2,3),L)

      d=(dx**2d0+dy**2d0+dz**2d0)**0.5

    temp_instant=2d0*kinetic/(3d0*n_particles)
    pressure=(density*temp_instant+pressure/(3d0*L**3d0))
    kinetic = kinetic/dble(n_particles)
    potential = potential/dble(n_particles)
    write(15,*) t, kinetic, potential,(kinetic+potential)
    write(16,*) t*time_re, kinetic*energy_re, potential*energy_re,(kinetic+potential)*energy_re
    write(17,*) t, temp_instant, pressure
    write(18,*) t*time_re, temp_instant*temp_re, pressure*press_re
    write(20,*)t,px,v(1,1),v(2,1)
    write(21,*)t,d

  endif

  IF(is_time_evol.eqv..TRUE.)THEN
    WRITE(19,*)n_particles
    WRITE(19,*)
    DO kk=1,n_particles
      WRITE(19,*)'X',r(kk,:)
    END DO
  END IF

END SUBROUTINE SAMPLES


END MODULE SAMPLE
