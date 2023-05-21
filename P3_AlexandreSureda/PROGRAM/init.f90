module init

    use read_data
    use def_var
    use forces
    use pbc
    IMPLICIT NONE

contains

    subroutine FCC_Initialize(r)
    ! We create an FCC latice of a system of N particles
        integer                                  :: n,i,j,k
        real*8,dimension(:,:),intent(out)        :: r
        n=1
    do i=0,M-1
        do j=0,M-1
            do k=0,M-1
                r(n,:)=a*(/i,j,k/)
                r(n+1,:)=r(n,:)+a*(/0.5,0.5,0.0/)
                r(n+2,:)=r(n,:)+a*(/0.5,0.0,0.5/)
                r(n+3,:)=r(n,:)+a*(/0.0,0.5,0.5/)
                n=n+4
            end do
        end do
    end do
    print*, 'particles positioned', n-1, 'of a total input', n_particles
    CALL force(r,F,cutoff)

    return
    end subroutine FCC_Initialize

    subroutine SC_Initialize(r)
    ! We create an SC latice of a system of N particles
    integer                                 :: n,i,j,k
    real*8,dimension(:,:),intent(out)        :: r
    n=1
    do i=0,M-1
        do j=0,M-1
            do k=0,M-1
                r(n,:)=a*(/i,j,k/)
                n=n+1
            end do
        end do
    end do
    print*, 'particles positioned', n-1, 'of a total input', n_particles
    CALL force(r,F,cutoff)

    return
  end subroutine SC_Initialize

  subroutine null_vel(v)
    integer                             :: i 
    real*8,dimension(:,:),intent(out)   :: v
    
    do i = 1,n_particles
        v(i,:) =(/0.d0,0.d0,0.d0/)
    end do 
  end subroutine 

  subroutine uniform_velocity(v)
  ! We initialize the velocities for a system of N particles in a uniform distribution
  integer                               :: i,j,seed
  real*8,dimension(:,:),intent(inout)   :: v
  real*8                                :: vi,vtot,t,t_a
  CALL RANDOM_SEED()
  t = 0.d0
  t_a = 0.d0 
  do i=1,3
      vtot=0
      do j=1,n_particles-1
        call random_number(vi)
          vi=2*vi-1
          v(j,i)=vi
          vtot=vtot+vi
      end do
      v(n_particles,i)=-vtot
  end do
  v(:,1) = v(:,1) - sum(v(:,1))/dble(n_particles)
  v(:,2) = v(:,2) - sum(v(:,2))/dble(n_particles)
  v(:,3) = v(:,3) - sum(v(:,3))/dble(n_particles)

  return
  end subroutine Uniform_velocity

  subroutine velo_rescal(v,T)
    ! We rescale the velocities so the kinetic energy is consistent with the temperature
    IMPLICIT NONE
    real*8,intent(in)                           :: T
    real*8,dimension(:,:),intent(inout)         :: v(:,:)
    real*8                                      :: alpha
    alpha=sqrt(3d0*n_particles*T/(2d0*KINETIC_ENERGY(v)))
    v=alpha*v

  end subroutine velo_rescal

    function KINETIC_ENERGY(v)
        IMPLICIT NONE
        integer                                 :: i
        real*8,dimension(:,:),intent(in)        :: v(:,:)
        real*8                                  :: KINETIC_ENERGY
        KINETIC_ENERGY=0d0
        DO i=1,n_particles
            KINETIC_ENERGY = KINETIC_ENERGY + (v(i,1)**2+v(i,2)**2+v(i,3)**2)
        END DO
        KINETIC_ENERGY = 0.5d0*KINETIC_ENERGY
        RETURN
    end function



end module init
