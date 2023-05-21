MODULE def_var
    USE READ_DATA
    IMPLICIT NONE
    INTEGER seed,n_verlet,nstep
    REAL*8 time_re,t,energy_re,dist_re,temp_re,press_re,n_mols,total_mass,rho_re,temp_instant,cutoff_aux
    REAL*8,DIMENSION(:,:),ALLOCATABLE :: r, v, f,r_old,rold_aux



    CONTAINS
    SUBROUTINE initialize_vars()
        IMPLICIT NONE

        ALLOCATE(r(n_particles,3),v(n_particles,3),F(n_particles,3),r_old(n_particles,3),rold_aux(n_particles,3))
        seed=1996


        ! Dimensional factors
        temp_re=epsi/k_B   ! Kelvin
        energy_re=epsi     ! kJ/mol
        dist_re=sigma      ! Angstroms
        time_re=0.1*sqrt(mass*sigma**2d0/epsi)  ! Picoseconds
        press_re=1d33*epsi/(n_avog*sigma**3d0)  ! Pascals
        n_mols=n_particles/n_avog
        total_mass=n_mols*mass
        rho_re=mass*1d24/(sigma**3d0*n_avog)

        ! Verlet integration variables
        n_verlet=int((t_b-t_a)/h)               ! Number of time inegration steps
        t=t_a


    END SUBROUTINE initialize_vars
END MODULE def_var
