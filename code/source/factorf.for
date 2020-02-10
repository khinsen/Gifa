      SUBROUTINE FACTORF (B,K4,ZN,KPRINT,error)
c IN	: B,K4,KPRINT
c OUT	: ZN,error
C     CALCULATE THE PE COEFFICIENTS FROM THE AR FORWARD COEFF.
C     SETS UP PROBLEM, CALLS DPROOTB
C     FACTORS COMPLEX POLYNOMIAL
C     SIGMA COEFF(I)*Z**(I-1),I=1,K4)
C     THE COEFFICIENTS ARE IN ASCENDING ORDER, ARE NOT NORMALIZED
C     SIGNAL LENGTH <= 1024
C     error : = 1 si toutes les racines n'ont pas ete localisees ; = 0 sinon
C
C  EDIT HISTORY:
C
C     WRITTEN BY STEIGLITZ, MODIFIED BY FENG NI, 9-30-84
C     IMPLEMENTED ON PRIME 550, HASP BY FENG NI, 9-29-84
C     ADAPTED TO VAX/8600, SU/NMR, BY FENG NI, 3-18-86
C     adapted to GIFA  by T.Malliavin, March 1991
C
      IMPLICIT NONE
      character*80 line
      COMPLEX*16 B(*),COE(1024),ZN(*)
      INTEGER KPRINT,K4,K4M,I,KERR,error
      DO I=1,K4-1
	COE(I)=B(K4-I)
      ENDDO
      COE(K4) = (1.0D0,0.0D0)
      K4M=K4-1
      CALL DPROOTB(K4M,COE,ZN,KERR,KPRINT)
      IF(KPRINT.EQ.1)WRITE(*,600)KERR
600   FORMAT(' RETURN FROM DPROOTB WITH KERR=',I5)
      IF (KERR.GT.0) then
	WRITE(line,7777)
7777  FORMAT(' Warning from .FACTOR. : not all the roots located!')
	call gifaout(line)
	error = 1
      endif
      RETURN
      END