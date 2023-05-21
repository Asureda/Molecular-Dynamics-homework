module init

use read_data

IMPLICIT NONE

contains

    subroutine FCC_Initialize(r)
    ! We create an FCC latice of a system of N particles
    INTEGER :: n,i,j,k
    REAL*8 :: r(:,:)
    n=1
    DO i=0,M-1
        DO j=0,M-1
            DO k=0,M-1
                r(n,:)=a*(/i,j,k/)
                r(n+1,:)=r(n,:)+a*(/0.5,0.5,0.0/)
                r(n+2,:)=r(n,:)+a*(/0.5,0.0,0.5/)
                r(n+3,:)=r(n,:)+a*(/0.0,0.5,0.5/)
                n=n+4
            END DO
        END DO
    END DO
    PRINT*, 'particles positioned', n-1, 'of a total input', n_particles
    RETURN
    end subroutine FCC_Initialize

    subroutine SC_Initialize(r)
    ! We create an SC latice of a system of N particles
    INTEGER :: n,i,j,k
    REAL*8 :: r(:,:)
    n=1
    DO i=0,M-1
        DO j=0,M-1
            DO k=0,M-1
                r(n,:)=a*(/i,j,k/)
                n=n+1
            END DO
        END DO
    END DO
    PRINT*, 'particles positioned', n-1, 'of a total input', n_particles
    RETURN
  end subroutine SC_Initialize

  subroutine two_particle(r,r_old,v)
  INTEGER :: i
  REAL*8 :: d
  REAL*8 :: r(:,:),v(:,:),r_old(:,:)
  d = 1.01d0
  DO i = 1,n_particles
    r(i,:) = (/(i-1)*d,0.d0,0.d0/)
    v(i,:) = (/0.d0,0.d0,0.d0/)
  END DO

  r_old = r

  RETURN
end subroutine two_particle


  subroutine Uniform_velocity(v)
  ! We initialize the velocities for a system of N particles in a uniform distribution
  INTEGER :: i,j,seed
  REAL*8 :: v(:,:),vi,vtot
  CALL RANDOM_SEED()

  DO i=1,3
      vtot=0
      DO j=1,n_particles-1
          call random_number(vi)
          vi=2*vi-1
          v(j,i)=vi
          vtot=vtot+vi
      END DO
      v(n_particles,i)=-vtot
  END DO
  RETURN
  end subroutine Uniform_velocity

end module init
