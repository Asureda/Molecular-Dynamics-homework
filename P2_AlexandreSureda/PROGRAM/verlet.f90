MODULE verlet_algorithm
use read_data
use def_var
use forces
use pbc
implicit none
contains
  subroutine euler(r,v,F)
    INTEGER i
    REAL*8 r(:,:),v(:,:)
    REAL*8 F(:,:),cutoff
    cutoff=0.99*L*5d-1
    kinetic = 0.d0
    call force(r,F,cutoff)
    DO i = 1,n_particles
      r(i,:) = r(i,:) + v(i,:)*h + 5d-1*F(i,:)*h*h
      v(i,:) = v(i,:) + F(i,:)*h
      r(i,1)=PBC2(r(i,1),L)
      r(i,2)=PBC2(r(i,2),L)
      r(i,3)=PBC2(r(i,3),L)
      kinetic = kinetic + (v(i,1)**2+v(i,2)**2+v(i,3)**2)
    END DO
    kinetic = 0.5d0*kinetic
    return
  end subroutine euler

  SUBROUTINE verlet(r,r_old,v,F)
      ! We integrate the Newton's equations with the Velocity Verlet algorithm
      ! We obtain new positions, velocities and the forces
      INTEGER i
      REAL*8 r(:,:),v(:,:),r_old(:,:)
      REAL*8 F(:,:),cutoff


      cutoff=0.99*L*5d-1
      kinetic = 0.d0
      call force(r,F,cutoff)

      rold_aux = r
      DO i = 1,n_particles
        !r_old(i,:) = r(i,:)
        r(i,:) =  2.d0*r(i,:) - r_old(i,:) + F(i,:)*h*h
        ! r(i,1)=PBC2(r(i,1),L)
        ! r(i,2)=PBC2(r(i,2),L)
        ! r(i,3)=PBC2(r(i,3),L)
        v(i,1) = PBC2(r(i,1)-r_old(i,1),L)/(2.d0*h**2)
        v(i,2) = PBC2(r(i,2)-r_old(i,2),L)/(2.d0*h**2)
        v(i,3) = PBC2(r(i,3)-r_old(i,3),L)/(2.d0*h**2)
        kinetic = kinetic + (v(i,1)**2+v(i,2)**2+v(i,3)**2)
      END DO
      r_old = rold_aux

      kinetic = 0.5d0*kinetic
      return
  END SUBROUTINE verlet

SUBROUTINE velo_verlet(r,v,F)
    ! We integrate the Newton's equations with the Velocity Verlet algorithm
    ! We obtain new positions, velocities and the forces
    INTEGER i
    REAL*8 r(:,:),v(:,:)
    REAL*8 F(:,:),cutoff
    cutoff=0.99*L*5d-1
    kinetic = 0.d0
    CALL force(r,F,cutoff)
    DO i=1,n_particles
        r(i,:)=r(i,:)+v(i,:)*h+5d-1*F(i,:)*h*h
        v(i,:)=v(i,:)+5d-1*F(i,:)*h
        r(i,1)=PBC2(r(i,1),L)
        r(i,2)=PBC2(r(i,2),L)
        r(i,3)=PBC2(r(i,3),L)
    END DO
    CALL force(r,F,cutoff)
    DO i=1,n_particles
        v(i,:)=v(i,:)+5d-1*F(i,:)*h
        kinetic = kinetic + (v(i,1)**2+v(i,2)**2+v(i,3)**2)
    END DO
    kinetic = 0.5d0*kinetic
    RETURN
END SUBROUTINE
END MODULE verlet_algorithm
