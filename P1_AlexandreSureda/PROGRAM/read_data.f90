MODULE READ_DATA
    IMPLICIT NONE
    ! Variables of parameters.dat file
    INTEGER :: n_particles
    REAL*8 :: density,sigma,epsi,mass
    LOGICAL :: add_pbc


    ! Variables of constants.dat file
    REAL*8 :: k_b,n_avog

    ! Additional variables
    INTEGER :: M,n_radial
    REAL*8 :: L,a,potential,pressure
    CONTAINS

        ! Subroutine to define global variables that will be used in the different modules
        SUBROUTINE READ_ALL_DATA()
            IMPLICIT NONE
            !---------------------------------------------------
            !            WE READ THE PARAMETERS FILE
            !---------------------------------------------------
            OPEN(11,FILE='parameters.dat',status='OLD')
            READ(11,*)n_particles
            READ(11,*)density
            READ(11,*)sigma
            READ(11,*)epsi
            READ(11,*)mass
            READ(11,*)add_pbc
            CLOSE(11)

            OPEN(13,FILE='constants.dat',status='OLD')
            READ(13,*)k_b
            READ(13,*)n_avog
            CLOSE(13)
        END SUBROUTINE

        ! We calculate some other global variables useful for the calculations
        SUBROUTINE OTHER_GLOBAL_VARS()
            IMPLICIT NONE
            L=((n_particles*1d0)/density)**(1d0/3d0)     ! Simulation box's length
            !M=nint(((n_particles*1d0)/4d0)**(1d0/3d0))   ! Number of nodes in each direction
            M=nint(((n_particles*1d0))**(1d0/3d0))   ! Number of nodes in each direction
            a=L/(M*1d0)                                  ! Edge of each unit cell
            potential=0d0
            pressure=0d0
        END SUBROUTINE

        END MODULE
