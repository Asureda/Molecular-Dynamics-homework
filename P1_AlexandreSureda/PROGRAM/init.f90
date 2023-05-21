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

end module init
