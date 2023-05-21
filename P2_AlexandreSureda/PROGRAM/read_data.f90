MODULE READ_DATA
    IMPLICIT NONE
    ! Variables of parameters.dat file
    INTEGER :: n_particles
    REAL*8 :: density,sigma,epsi,mass,t_b,h,Temp
    LOGICAL :: add_pbc

    ! Variables of config.dat file
    INTEGER :: n_meas,n_meas_time_ev
    LOGICAL :: is_print_thermo,is_time_evol


    ! Variables of constants.dat file
    REAL*8 :: k_b,n_avog

    ! Additional variables
    INTEGER :: M,n_radial
    REAL*8 :: L,a,t_a,kinetic,potential,pressure,px,py,pz
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
            READ(11,*)t_b
            READ(11,*)h
            READ(11,*)sigma
            READ(11,*)epsi
            READ(11,*)mass
            READ(11,*) Temp
            READ(11,*)add_pbc
            CLOSE(11)

            !--------------------------------------------------
            !          WE READ THE CONFIGURATION FILE
            !--------------------------------------------------
            OPEN(12,FILE='config.dat',status='OLD')
            READ(12,*)is_print_thermo
            READ(12,*)n_meas
            READ(12,*)is_time_evol
            READ(12,*)n_meas_time_ev
            CLOSE(12)


            OPEN(13,FILE='constants.dat',status='OLD')
            READ(13,*)k_b
            READ(13,*)n_avog
            CLOSE(13)
        END SUBROUTINE

        ! We calculate some other global variables useful for the calculations
        SUBROUTINE OTHER_GLOBAL_VARS()
            IMPLICIT NONE
            !M=nint(((n_particles*1d0)/4d0)**(1d0/3d0))   ! Number of nodes in each direction
            !M=nint(((n_particles*1d0))**(1d0/3d0))   ! Number of nodes in each direction
            a=L/(M*1d0)                                  ! Edge of each unit cell
            L = 10.d0
            t_a = 0.d0
            kinetic = 0.d0
            potential=0d0
            pressure=0d0
            px = 0.d0
            py = 0.d0
            pz = 0.d0
        END SUBROUTINE

        END MODULE
