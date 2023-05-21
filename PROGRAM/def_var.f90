MODULE def_var
    use read_data
    IMPLICIT NONE
    integer                                 :: n_verlet,nstep,n_eq,bins,i,n_gr_meas,init_step,n_points,n
    real*8                                  :: time_re,t,temps,energy_re,dist_re,temp_re,press_re,n_mols,total_mass
    real*8                                  :: rho_re, temp_instant, cutoff, pi
    real*8,DIMENSION(:,:),ALLOCATABLE       :: r, v, f
    real*8,DIMENSION(:),ALLOCATABLE         :: kin_avg,pot_avg,energy_avg,temp_avg,press_avg
    real*8,DIMENSION(:),ALLOCATABLE         :: energy_bin
    real*8,DIMENSION(:),ALLOCATABLE         :: histogram
    REAL*8,DIMENSION(:),ALLOCATABLE         :: g_r

    contains
    subroutine initialize_vars()
        implicit none

        allocate(r(n_particles,3),v(n_particles,3),F(n_particles,3),g_r(0:n_radial+1))


        ! Dimensional factors
        temp_re=epsi/k_B                        ! Kelvin
        energy_re=epsi                          ! kJ/mol
        dist_re=sigma                           ! Angstroms
        time_re=0.1*sqrt(mass*sigma**2d0/epsi)  ! Picoseconds
        press_re=1d33*epsi/(n_avog*sigma**3d0)  ! Pascals
        n_mols=n_particles/n_avog
        total_mass=n_mols*mass
        rho_re=mass*1d24/(sigma**3d0*n_avog)

        ! Verlet integration variables
        n_verlet=int((t_b-t_a)/h)               ! Number of time integration steps
        t=t_a
        n_eq=int((t_eq-t_eqa)/h_eq)               ! Number of time integration steps
        pi   = acos(-1.d0)
        n_gr_meas=0
        init_step = 3000
        n_points = n_verlet-init_step
        n = 0

        !allocate(kin_avg(n_verlet ),pot_avg(n_verlet ),energy_avg(n_verlet ),temp_avg(n_verlet ),press_avg(n_verlet))
        allocate(kin_avg(n_points ),pot_avg(n_points ),energy_avg(n_points ),temp_avg(n_points ),press_avg(n_points))
        !allocate(energy_bin(n_verlet/bins))
        open(15,file='thermodynamics.dat')
        open(16,file='thermodynamics_real.dat')
        open(19,file='positions.xyz')
        open(20,file='stats.dat')
        open(21,file='gdr.dat')
        open(22,file='binning_thermodynamics.dat')

    end subroutine initialize_vars
end module def_var
