! Periodic Boundary Conditions
MODULE PBC
use READ_DATA
implicit none
contains

FUNCTION PBC1(x,L)
    IMPLICIT NONE
    REAL*8 x,L,PBC1
    PBC1=x-int(2d0*x/L)*L
    RETURN
END FUNCTION

FUNCTION PBC2(x,L)
    IMPLICIT NONE
    REAL*8 x,L,PBC2
    IF(x.gt.(L/2.))THEN
        x=x-L
    ELSE IF(x.lt.(-L/2.)) THEN
        x=x+L 
    END IF
    PBC2=x
    RETURN
END FUNCTION

END MODULE PBC
