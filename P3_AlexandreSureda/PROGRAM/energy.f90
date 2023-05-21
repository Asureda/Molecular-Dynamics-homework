MODULE forces
use READ_DATA
use PBC
implicit none
contains

  SUBROUTINE L_J(d,ff,pot,cutoff)
      ! Lennard-Jones potential
      IMPLICIT NONE
      real*8,intent(in)   :: d,cutoff
      real*8,intent(out)  :: ff,pot
      ff=0d0
      pot=0d0
      IF (d<cutoff) THEN
          ff=(48d0/d**14d0)-(24d0/d**8d0)         ! F = -grad(V)
          pot=4d0*((1d0/d**12d0)-(1d0/d**6d0))    ! Potential
      END IF
      RETURN
  END SUBROUTINE L_J

SUBROUTINE force(r,F,cutoff)
! Compute the forces, the potential energy of the
! system and the pressure taking into account PBC
    IMPLICIT NONE
    integer                               :: i,j
    real*8, dimension(:,:),intent(inout)  :: r
    real*8, dimension(:,:),intent(out)    :: F
    real*8                                :: cutoff
    real*8                                :: pot
    real*8                                :: dx,dy,dz,d,ff
    cutoff=0.8*L*5d-1
    F=0d0
    potential=0d0
    pressure=0.0
    DO i=1,n_particles-1
        DO j=i+1,n_particles

          if(add_pbc.eqv.(.TRUE.)) then
            dx=PBC2(r(i,1)-r(j,1),L)
            dy=PBC2(r(i,2)-r(j,2),L)
            dz=PBC2(r(i,3)-r(j,3),L)
          else
            dx=r(i,1)-r(j,1)
            dy=r(i,2)-r(j,2)
            dz=r(i,3)-r(j,3)
          end if
            d=(dx**2d0+dy**2d0+dz**2d0)**0.5
            CALL L_J(d,ff,pot,cutoff)
            F(i,1)=F(i,1)+ff*dx
            F(i,2)=F(i,2)+ff*dy
            F(i,3)=F(i,3)+ff*dz
            F(j,1)=F(j,1)-ff*dx
            F(j,2)=F(j,2)-ff*dy
            F(j,3)=F(j,3)-ff*dz
            potential=potential+pot
            pressure=pressure+(ff*dx**2d0+ff*dy**2d0+ff*dz**2d0)
        END DO
    END DO
END SUBROUTINE force

END MODULE forces
