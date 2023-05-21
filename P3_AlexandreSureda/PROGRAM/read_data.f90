MODULE read_data

    IMPLICIT NONE
    ! Variables of parameters.dat file
    integer :: n_particles
    real*8 :: density,sigma,epsi,mass,t_b,h,t_eq,h_eq,Temp,T_therm
    logical :: add_pbc

    ! Variables of config.dat file
    integer :: n_meas,n_meas_time_ev,n_melting
    logical :: is_print_thermo,is_time_evol,is_thermostat


    ! Variables of constants.dat file
    real*8 :: k_b,n_avog

    ! Additional variables
    integer :: M,n_radial
    real*8 :: L,a,t_a,t_eqa,kinetic,potential,pressure

    CONTAINS

        ! Subroutine to define global variables that will be used in the different modules
        subroutine READ_ALL_DATA()
            IMPLICIT NONE
            !---------------------------------------------------
            !            WE READ THE PARAMETERS FILE
            !---------------------------------------------------
            OPEN(11,FILE='parameters.dat',status='OLD')
            READ(11,*)  n_particles
            READ(11,*)  density
            READ(11,*)  t_eq
            READ(11,*)  h_eq
            READ(11,*)  t_b
            READ(11,*)  h
            READ(11,*)  sigma
            READ(11,*)  epsi
            READ(11,*)  mass
            READ(11,*)  is_thermostat
            READ(11,*)  T_therm
            READ(11,*)  Temp
            READ(11,*)  add_pbc
            CLOSE(11)

            !--------------------------------------------------
            !          WE READ THE CONFIGURATION FILE
            !--------------------------------------------------
            OPEN(12,FILE='config.dat',status='OLD')
            READ(12,*)  is_print_thermo
            READ(12,*)  n_meas
            READ(12,*)  is_time_evol
            READ(12,*)  n_meas_time_ev
            CLOSE(12)


            OPEN(13,FILE='constants.dat',status='OLD')
            READ(13,*)  k_b
            READ(13,*)  n_avog
            CLOSE(13)
        END subroutine

        subroutine OTHER_GLOBAL_VARS()
            ! Calculation of some important variables for the simulation
            IMPLICIT NONE
            M=nint(((n_particles*1d0)/4d0)**(1d0/3d0))    ! Number of nodes in each direction FCC
            !M=nint(((n_particles*1d0))**(1d0/3d0))       ! Number of nodes in each direction SC
            L=((n_particles*1d0)/density)**(1d0/3d0)      ! Length of the system
            a=L/(M*1d0)                                   ! Edge of each unit cell
            t_a = 0.d0                                    ! Initial time
            t_eqa = 0.d0

        END subroutine

        END MODULE
