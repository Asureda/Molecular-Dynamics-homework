MODULE def_var
    USE READ_DATA
    IMPLICIT NONE
    INTEGER seed
    REAL*8 energy_re,dist_re,temp_re,press_re,n_mols,total_mass,rho_re,temp_instant,cutoff_aux
    REAL*8,DIMENSION(:,:),ALLOCATABLE :: r, f


    CONTAINS
    SUBROUTINE initialize_vars()
        IMPLICIT NONE

        ALLOCATE(r(n_particles,3),F(n_particles,3))
        seed=1996


        ! Dimensional factors
        temp_re=epsi/k_B   ! Kelvin
        energy_re=epsi     ! kJ/mol
        dist_re=sigma      ! Angstroms
        press_re=1d33*epsi/(n_avog*sigma**3d0)  ! Pascals
        n_mols=n_particles/n_avog
        total_mass=n_mols*mass
        rho_re=mass*1d24/(sigma**3d0*n_avog)


    END SUBROUTINE initialize_vars
END MODULE def_var
