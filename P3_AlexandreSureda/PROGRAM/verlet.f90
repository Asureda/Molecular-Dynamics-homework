MODULE verlet_algorithm
use read_data
use def_var
use forces
use pbc
implicit none
contains
subroutine velo_verlet(r,v,F,h)
    integer                     :: i
    real*8                      :: r(:,:),v(:,:)
    real*8                      :: F(:,:),cutoff,h

    kinetic = 0.d0
    DO i=1,n_particles
        r(i,:)=r(i,:)+v(i,:)*h+5d-1*F(i,:)*h*h
        v(i,:)=v(i,:)+5d-1*F(i,:)*h
        r(i,1)=PBC2(r(i,1),L)
        r(i,2)=PBC2(r(i,2),L)
        r(i,3)=PBC2(r(i,3),L)
    END DO
    CALL force(r,F,cutoff)
    DO i=1,n_particles
        v(i,:)=v(i,:)+5d-1*F(i,:)*h
        kinetic = kinetic + (v(i,1)**2+v(i,2)**2+v(i,3)**2)
    END DO
    kinetic = 5d-1*kinetic 
    RETURN
END subroutine

subroutine andersen(v,temp)
  IMPLICIT NONE
  integer                   ::i
  real*8                    :: temp,nu,n1,n2,n3,n4,n5
  real*8                    :: temp1
  real*8, DIMENSION(:,:)    :: v
  nu=0.08
  call random_seed
  temp1=sqrt(temp)
  DO i=1,n_particles
      call random_number(n5)
      IF(n5.lt.nu)THEN
          call random_number(n1)
          call random_number(n2)
          call random_number(n3)
          call random_number(n4) 
          v(i,1)=temp1*sqrt(-2d0*log(n1))*cos(2d0*pi*n2)
          v(i,2)=temp1*sqrt(-2d0*log(n1))*sin(2d0*pi*n2)
          v(i,3)=temp1*sqrt(-2d0*log(n3))*cos(2d0*pi*n4)
      END IF
  END DO
  end subroutine andersen


END MODULE verlet_algorithm
