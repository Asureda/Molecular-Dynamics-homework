MODULE sample
use read_data
use pbc
use def_var
IMPLICIT NONE
integer :: kk
contains

subroutine sample_production()

  temp_instant=2d0*kinetic/(3d0*n_particles)
  pressure=(density*temp_instant+pressure/(3d0*L**3d0))
  kinetic = kinetic/dble(n_particles)
  potential = potential/dble(n_particles)


  kin_avg(nstep) = kinetic
  pot_avg(nstep) = potential
  energy_avg(nstep) = (kinetic+potential)
  temp_avg(nstep) = temp_instant


  if((mod(nstep,n_meas).eq.0).and.(is_print_thermo.eqv..true.))then
    write(15,*) t, kinetic, potential,(kinetic+potential),temp_instant, pressure

  end if

end subroutine sample_production

subroutine sample_equilibration()

  if((mod(nstep,n_meas).eq.0).and.(is_print_thermo.eqv..true.))then

    temp_instant=2d0*kinetic/(3d0*n_particles)
    write(16,*) t, temp_instant

  end if

  if((mod(nstep,n_meas_time_ev).eq.0).and.(is_time_evol.eqv..true.))then

    WRITE(19,*)n_particles
    WRITE(19,*)
    DO kk=1,n_particles
      WRITE(19,*)'X',r(kk,:)
    END DO
  end if
end subroutine sample_equilibration

subroutine histo(v,n_particles,histogram)
  implicit none
integer,intent(in)                                  :: n_particles
real*8, dimension(:,:),intent(in)                   :: v
real*8, allocatable,dimension(:),intent(out)        :: histogram
integer                                             :: nHist,io
integer                                             :: i, j, k, l
real*8, dimension(3)                                :: vec
real*8                                              :: iniHist, finHist, pasH, modV
real*8                                              :: minVel, minVel2

iniHist = -30.0D0; finHist = 30.0D0; nHist = 25
pasH = (finHist - iniHist)/dfloat(nHist)

allocate(histogram(nHist + 2))
histogram(:) = 0

do k = 1, n_particles, 1
   do l = 1, 3, 1
        vec(:) = v(k,:)
        !modV = dsqrt(dot_product(vec,vec))

        minVel  = iniHist
        minVel2 = iniHist + pasH
        do j = 1, nHist, 1
                if ((vec(l) <= minVel2).and.(vec(l) > minVel)) then
                        histogram(j+1) = histogram(j+1) + 1
                end if
                minVel  = minVel  + pasH
                minvel2 = minVel2 + pasH
        end do

        if (vec(l) < iniHist) then
                histogram(1) = histogram(1) + 1
        else if (modV >= finHist) then
                histogram(nHist+2) = histogram(nHist+2) + 1
        end if
  end do
end do

! NORMALITZACIÓ
histogram(:) = histogram(:)/sum(histogram(:)*pasH)

open(unit=55, file='MB_velocityDistribution.dat')
do i = 1, nHist + 2, 1
        write(55,*) iniHist + (i-1)*pasH, histogram(i)
end do
close(55)
end subroutine histo

subroutine make_bin(X, nPoints, binnedX, M)
  implicit none
  integer, intent(in)                               :: nPoints, M
  real*8, dimension(nPoints), intent(inout)         :: X
  real*8, dimension(nPoints/M), intent(out)         :: binnedX
  integer                                           :: i, j, counter

  counter = 0; binnedX(:) = 0
  do i = 1, nPoints , M
          counter = counter + 1
          do j = 1, M, 1
                  binnedX(counter) = binnedX(counter) + X(j+i-1)
          end do
          binnedX(counter) = binnedX(counter)/M
  end do
  end subroutine make_bin

  subroutine print_velocity(file)
    integer,intent(in)  :: file
    integer :: i
    do i = 1,n_particles
      write(file,*) v(i,:)
    end do
  end subroutine print_velocity

  subroutine print_variance(file)
    integer,intent(in) :: file
    DO i = 1,3
      allocate(energy_bin(n_verlet/2**i))
      call make_bin(energy_avg,n_verlet,energy_bin,2**i)
      write(file,*) 2**i, mean(energy_bin),std(energy_bin)
      deallocate(energy_bin)
    END DO

  end subroutine print_variance

  subroutine print_results()

    WRITE(20,*)'<KE>',mean(kin_avg),'±',std(kin_avg)
    WRITE(20,*)'<V>',mean(pot_avg),'±',std(pot_avg)
    WRITE(20,*)'<E>',mean(energy_avg),'±',std(energy_avg)
    WRITE(20,*)'<T>',mean(temp_avg),'±',std(temp_avg)

  end subroutine print_results

  function mean(x)

    real*8,dimension(:), intent(in):: x
      real*8 ::   mean
      mean=sum(x)/size(x)
  end function mean

  function std(x)
    real*8,dimension(:),intent(in)::x
    real*8:: media, suma, std
    media=mean(x)
    suma=sum((x(:)-media)**2)
    std=sqrt(suma/(size(x)-1.0d0))
  end function std



END MODULE sample
