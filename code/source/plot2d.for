C This file is a part of the GIFA program
C     This software has been developped by the NMR Group in GIF/Yvette.
C
C     Authors :       M.A.Delsuc
C                     NMR Laboratory,
C                     ICSN - CNRS
C                     91190 GIF/YVETTE   FRANCE
C
C     This software cannot be used unless the user have been fully
C licensed to do so form the above laboratory.
C     This file cannot be copied, duplicated or used in any other program,
C without written permission from the authors.
C

C    This subroutine is based on a program kindly provided by H.DELACROIX and
C J.L.RISLER,    C.G.M.   - C.N.R.S.
C   91190 Gif-Sur-Yvette
C---------------------------------------------------------------------

      subroutine plot2d(pl_id,vd_id,si1,si2,matrix,
     *        maxi,scaling,mode,dx,dy,levels,sign2,loga,col,
     *        zoom,zolf1,zolf2,zour1,zour2,clear)
c IN	: all parameters, but
c INOUT	: maxi
C  Plots a contour-plot of array matrix(si1,si2)
C  levels =  number of levels
C  scaling = scaling factor
C  loga = 1.0 means equidistant levels,
C      .gt.1.0 means each level is *loga above the previous
C  drawing size =  dx x dy (in cm.)
C  mode = 0         -> plots everything
C  mode = 1         -> one over two in dim 2
C  mode = 2         -> one over two in dim 1
C  mode = 3         -> one over two in both dim
C
C  sign =  1        -> plot only positive levels
C  sign = -1        -> plot only negative levels
C  sign = 0         -> plot both levels
C
C  col  = 1         -> levels are drawn in color
C
C  if pl_id <> 99  -> plot on graphics screen
C                      vd_id = visual display id
C                      The window must have been
C                      opened with 0-1 world coords.
c zoom,zolf1,zolf2,zour1,zour2 describe the zoom state
c
c clear = 1    -> clear screen before displaying
C
C  Some bugs have been reported
C   -drawing extra lines
C   -division by 0 if 2 connected points are exactly at the same level,
C      and that level being the one currently plot.
c
C  This program tries to avoid level crossing
C
C---------------------------------------------------------------------
C
        implicit none


        integer pl_id,vd_id
        integer si1,si2
        integer mode
        integer levels
        integer sign2,col
        integer zoom
        integer zolf1,zolf2,zour1,zour2, clear
        real matrix(si2,si1)
        real scaling,loga
        real dx,dy

#include "controlc.inc"
#include "gcolor.inc"

        integer thecolor

	integer NX,NY
        integer KMAX
        integer i,j,k
        integer nf,nl
        integer si1im,si2im
        integer llf1,llf2,lur1,lur2
        integer writingmode

        real mini,maxi
        real nivmin
        real interv
        real iniv(64),niv
        real dxx,dyy
        real sign

        integer jmin,jmax,jstep
        integer imin,imax,istep
        integer ii,jj
        integer irec,jrec
        integer iimax,jjmax
	 integer fbox(64,64)
        integer ipt,last,ib,jb
        integer ntrav,first
        integer flag(4)

	real z11,z12,z21,z22
        integer buff_siz
        parameter (buff_siz=4096)
        real x(buff_siz+12),y(buff_siz+12),xx,yy
C +12 because we experimented some nasty out of buffer bugs
        real z(64,64)
#f2c        save x,y, z, fbox     ! this is needed because of a limited size for local C variables

        logical remain

C-------------------------------------------------------------
C
C                 4
C               .....
C             1 .   . 3
C               .....
C                 2
C
C
C	FBOX:	0 RIEN A TRACER
C		1 PAS ENCORE PASSE
C		2 PASSE UNE FOIS HORIZONTALEMENT
C		3 PASSE UNE FOIS VERTICALEMENT
C
C-------------------------------------------------------------
        if (scaling.eq.0.0) then
            write(*,*) '*** Scaling is zero!'
            return
        endif
        sign = sign2

        if (mod(mode,2).eq.0) then
           istep = 1
        else
           istep = 2
        endif
        if (mode.lt.2) then
           jstep = 1
        else
           jstep = 2
        endif
C
        if (zoom.eq.1) then      ! zoom mode is on
            if (zolf1.lt.1 .or. zolf2.lt.1 .or.
     *          zour1.gt.si1 .or. zour2.gt.si2) then
               write(*,*) 'Wrong zoom window'
               return
            endif
            lur1 = zour1
            lur2 = zour2
            llf1 = zolf1
            llf2 = zolf2
            si1im = zour1-zolf1+1
            si2im = zour2-zolf2+1
        else
            lur1 = si1
            lur2 = si2
            llf1 = 1
            llf2 = 1
            si2im = si2
            si1im = si1
        endif

        if (si1im.le.1 .or. si2im.le.1) then
           write(*,*) '*** Size too small for display'
           return
        endif

C nx, ny number of x and y partitions...
        nx = si2im/istep
        ny = si1im/jstep
C dxx, dyy size of each of the nx-1 partitions of dx, etc...
        dxx = dx / float(nx-1)
        dyy = dy / float(ny-1)

C Check for which output device...
C       On plotter...
        if (pl_id.eq.99) then
C         call plinit(pl_id)
C         Draw a frame of dx x dy cm. around the plot...
          call plmove(pl_id,0.0,0.0)
          call pldraw(pl_id,dx,0.0)
          call pldraw(pl_id,dx,dy)
          call pldraw(pl_id,0.0,dy)
          call pldraw(pl_id,0.0,0.0)
        else
C on screen
           writingmode = 1
           call win_set_writing_mode(vd_id,writingmode)
           call win_enable_display_list(vd_id)
           if (clear.eq.1) call win_erase(vd_id)
C          Set up dx x dy frame in world coords...
C          Draw the frame on the screen
           x(1) = 0.0
           y(1) = 0.0
           x(2) = 1.0
           y(2) = 0.0
           x(3) = 1.0
           y(3) = 1.0
           x(4) = 0.0
           y(4) = 1.0
           x(5) = 0.0
           y(5) = 0.0

           call win_plot_array(vd_id,5,x,y)
           call win_update(vd_id)
        endif

        if (maxi.eq.0.0) then
         call mxavect(mini,maxi,i,j,matrix,si1*si2)
        endif

10000   nivmin = maxi/(scaling*32)         ! lowest level
        if (sign.eq.-1) nivmin=-nivmin     ! plot negative levels
        interv = nivmin                    ! inter level spacing

C
C	VALEUR DES COURBES DE NIVEAU DANS INIV(64)
	IF (levels.EQ.1) THEN
	  KMAX=1
	  INIV(1)=NIVmin
        ELSE
           KMAX = levels
           KMAX = MIN(KMAX,64)
           iniv(1) = nivmin
           if (loga.gt.1.0) then
              do i=2,kmax
                 iniv(i) = iniv(i-1)*loga
              enddo
           else
	      DO 255 I=2,KMAX
        	 INIV(I)=INIV(I-1)+INTERV
255	      CONTINUE
           endif
	ENDIF
C
	DO 1002 JMIN=0,NY-1,63     ! move the box
	JMAX=JMIN+63
C
	DO 1002 IMIN=0,NX-1,63
	IMAX=IMIN+63
C                 copy the matrix into z(ii,jj)
	JJ=0
        iimax = 0
        jjmax = 0
	DO 310 JREC=(JMIN)*Jstep+llf1,(JMAX)*jstep+llf1,jstep
	  JJ=JJ+1
	  II=0
	  DO 310 IREC=(IMIN)*istep+llf2,(IMAX)*istep+llf2,istep
	    II=II+1
            if (irec.le.lur2 .and. jrec.le.lur1) then
	       Z(II,JJ)=matrix(irec,jrec)
               iimax = max(iimax,ii)
               jjmax = max(jjmax,jj)
            else
               z(ii,jj)=0.0
            endif
310	CONTINUE
        iimax = min(iimax,63)
        jjmax = min(jjmax,63)
C
C
        remain=.true.        ! remain.eq..false. ==> no plotting left,
	DO 1001 K=1,KMAX    ! sur les niveaux
C
        if (.not.remain) then    !no plotting left
           goto 1002
        endif
	NIV=INIV(K)
CCCCCCCCCCCCCCCCCCCCCCCc
        if (pl_id.ne.99) then
          if (col.eq.1) then
            if (sign.eq.-1) then
             thecolor = black-max(int(black*float(k)/float(kmax)),1)
            else
             thecolor = black+max(int((black+1)*float(k)/float(kmax)),1)
            endif

            if (thecolor.gt.63) then
c              write(*,*) thecolor
              thecolor = 63
            endif

            if (thecolor.lt.0) then
c              write(*,*) thecolor
              thecolor = 0
            endif
            call win_fgcolor(vd_id,thecolor)
c          else
c            call win_fgcolor(vd_id,white)
          endif
        endif
CCCCCCCCCCCCCCCCCCCCCCCc
C
	DO 320 II=1,63
	DO 320 JJ=1,63   !met fbox a 1
	  FBOX(II,JJ)=1
320	CONTINUE
C

       if ((niv.gt.0.0 .and. z(1,1).lt.niv) .or. 
     *     (niv.lt.0.0 .and. z(1,1).gt.niv))    then
           remain = .false.		! assume no plotting left to do
       else
           remain = .true.		! unless niv is below this point
       endif
	IPT=0
	LAST=1
C
	DO 1000 IB=1,iimax
	DO 1000 JB=1,jjmax      ! dans la boite
C
C	IL FAUT DEMARRER POUR CELA ON CHERCHE UN POINT
C	QUELCONQUE EN SUIVANT LES LIGNES ET LES COLONNES
C
	IF(FBOX(IB,JB).EQ.0) GOTO 1000	! PLUS RIEN A VOIR
C
	Z11=Z(IB,JB)-NIV
	Z21=Z(IB+1,JB)-NIV
	Z12=Z(IB,JB+1)-NIV
	Z22=Z(IB+1,JB+1)-NIV
C

	IF(FBOX(IB,JB).GE.2)GOTO 35
C
	DO 15 NF=1,4
	FLAG(NF)=0
15	CONTINUE
	NTRAV=0
C
	IF((Z11.GT.0.AND.Z12.LT.0).OR.
     +	(Z11.LT.0.AND.Z12.GT.0))THEN
	 FLAG(1)=1
	 NTRAV=NTRAV+1
	ENDIF
C
	IF((Z11.GT.0.AND.Z21.LT.0).OR.
     +	(Z11.LT.0.AND.Z21.GT.0))THEN
	 FLAG(2)=1
	 NTRAV=NTRAV+1
	ENDIF
C
	IF((Z21.GT.0.AND.Z22.LT.0).OR.
     +	(Z21.LT.0.AND.Z22.GT.0))THEN
	 FLAG(3)=1
	 NTRAV=NTRAV+1
	ENDIF
C
	IF((Z22.GT.0.AND.Z12.LT.0).OR.
     +	(Z22.LT.0.AND.Z12.GT.0))THEN
	 FLAG(4)=1
	 NTRAV=NTRAV+1
	ENDIF
C
	GOTO(25,1000,30,1000,35)(NTRAV+1)
C
25	FBOX(IB,JB)=0		! AUCUN COTE TRAVERSE
	GO TO 1000		! PLUS RIEN A VOIR
C
C	CAS SIMPLE TRAVERSEE
C
30	FIRST=0
	LAST=0
C
	DO 20 NF=1,4
	IF(FLAG(NF).EQ.0)GOTO 20
	IF(FIRST.EQ.0)THEN
	FIRST=NF
	ELSE
	LAST=NF
	FBOX(IB,JB)=0
	GO TO 40
	ENDIF
20	CONTINUE
C
C	CAS DES DOUBLES TRAVERSEES
C
35	GO TO(1000,31,32,33)(FBOX(IB,JB)+1)
C
C	CAS DES DEUX TRAVERSEES POUR LA PREMIERE FOIS
C
31	FIRST=1
	LAST=2
	FBOX(IB,JB)=2
	GO TO 40
C
C	CAS D'UNE DEUXIEME TRAVERSEE
C
32	FIRST=3
	LAST=4
	FBOX(IB,JB)=0
	GO TO 40
C
33	FIRST=1
	LAST=2
	FBOX(IB,JB)=0
C
C	DETERMINATION DES POINTS DE DEPART
C
40	IPT=IPT+1
	GOTO(41,42,43,44)FIRST
C
41	X(IPT)=FLOAT(IB+IMIN-1)
	Y(IPT)=FLOAT(JB+JMIN-1)+(Z11/(Z11-Z12))
	GO TO 45
C
42	X(IPT)=FLOAT(IB+IMIN-1)+(Z11/(Z11-Z21))
	Y(IPT)=FLOAT(JB+JMIN-1)
	GO TO 45
C
43	X(IPT)=FLOAT(IB+IMIN)
	Y(IPT)=FLOAT(JB+JMIN-1)+(Z21/(Z21-Z22))
	GO TO 45
C
44	X(IPT)=FLOAT(IB+IMIN-1)+(Z12/(Z12-Z22))
	Y(IPT)=FLOAT(JB+JMIN)
C
45	IPT=IPT+1
	GOTO(46,47,48,49)LAST
C
46	X(IPT)=FLOAT(IB+IMIN-1)
	Y(IPT)=FLOAT(JB+JMIN-1)+(Z11/(Z11-Z12))
	GO TO 50
C
47	X(IPT)=FLOAT(IB+IMIN-1)+(Z11/(Z11-Z21))
	Y(IPT)=FLOAT(JB+JMIN-1)
	GO TO 50
C
48	X(IPT)=FLOAT(IB+IMIN)
	Y(IPT)=FLOAT(JB+JMIN-1)+(Z21/(Z21-Z22))
	GO TO 50
C
49	X(IPT)=FLOAT(IB+IMIN-1)+(Z12/(Z12-Z22))
	Y(IPT)=FLOAT(JB+JMIN)
C
C	POURSUITE DE LA COURBE
C
50	I=IB
	J=JB
C
80	CONTINUE
C
	IF(IPT.EQ.512)GOTO 90
C
	GOTO(81,82,83,84)LAST
C
81	I=I-1
	IF(I.LT.1)GOTO 90
	FIRST=3
	GO TO 85
C
82	J=J-1
	IF(J.LT.1)GOTO 90
	FIRST=4
	GO TO 85
C
83	I=I+1
	IF(I.GT.iimax)GOTO 90
	FIRST=1
	GO TO 85
C
84	J=J+1
	IF(J.GT.jjmax)GOTO 90
	FIRST=2
C
85	IF(FBOX(I,J).EQ.0)GO TO 90
C
	Z11=Z(I,J)-NIV
	Z21=Z(I+1,J)-NIV
	Z12=Z(I,J+1)-NIV
	Z22=Z(I+1,J+1)-NIV
C
	IF(FBOX(I,J).GE.2)GOTO 135
C
	DO 86 NF=1,4
	FLAG(NF)=0
86	CONTINUE
	NTRAV=0
C
	IF((Z11.GT.0.AND.Z12.LT.0).OR.
     +	(Z11.LT.0.AND.Z12.GT.0))THEN
	 FLAG(1)=1
	 NTRAV=NTRAV+1
	ENDIF
C
	IF((Z11.GT.0.AND.Z21.LT.0).OR.
     +	(Z11.LT.0.AND.Z21.GT.0))THEN
	 FLAG(2)=1
	 NTRAV=NTRAV+1
	ENDIF
C
	IF((Z21.GT.0.AND.Z22.LT.0).OR.
     +	(Z21.LT.0.AND.Z22.GT.0))THEN
	 FLAG(3)=1
	 NTRAV=NTRAV+1
	ENDIF
C
	IF((Z22.GT.0.AND.Z12.LT.0).OR.
     +	(Z22.LT.0.AND.Z12.GT.0))THEN
	 FLAG(4)=1
	 NTRAV=NTRAV+1
	ENDIF
C
	GO TO(1000,130,1000,135)NTRAV
C
C	CAS SIMPLE TRAVERSEE
C
130	DO 105 NL=1,4
	IF(FLAG(NL).EQ.0)GOTO 105
	IF(NL.EQ.FIRST)GOTO 105
	LAST=NL
	FBOX(I,J)=0
	GOTO 170
105	CONTINUE
C
C	CAS DES DOUBLES TRAVERSEES
C
135	GO TO(1000,150,160,160)(FBOX(I,J)+1)
C
C	CAS DES DEUX TRAVERSEES POUR LA PREMIERE FOIS
C
150	GO TO(151,152,153,154)LAST
151	FBOX(I,J)=2
	LAST=2
	GOTO 170
152	FBOX(I,J)=2
	LAST=1
	GOTO 170
153	FBOX(I,J)=3
	LAST=4
	GOTO 170
154	FBOX(I,J)=3
	LAST=3
	GOTO 170
C
C	CAS D'UNE DEUXIEME TRAVERSEE
C
160	FBOX(I,J)=0
	GO TO(161,162,163,164)LAST
161	LAST=2
	GOTO 170
162	LAST=1
	GOTO 170
163	LAST=4
	GOTO 170
164	LAST=3
	GOTO 170
C
170	IPT=IPT+1
	GOTO(111,112,113,114)LAST
C
111	 X(IPT)=FLOAT(I+IMIN-1)
	 Y(IPT)=FLOAT(J+JMIN-1)+(Z11/(Z11-Z12))
	 GO TO 80
112	 X(IPT)=FLOAT(I+IMIN-1)+(Z11/(Z11-Z21))
	 Y(IPT)=FLOAT(J+JMIN-1)
	 GO TO 80
113	 X(IPT)=FLOAT(I+IMIN)
	 Y(IPT)=FLOAT(J+JMIN-1)+(Z21/(Z21-Z22))
	 GO TO 80
114	 X(IPT)=FLOAT(I+IMIN-1)+(Z12/(Z12-Z22))
	 Y(IPT)=FLOAT(J+JMIN)
	 GO TO 80
C
90	CONTINUE
C
C	ECRITURE DES POINTS DANS LE FICHIER DE SORTIE
C
c	WRITE(2)INIV(K),IPT,((X(M),Y(M)),M=1,IPT)
C
C Send IPT points to the plotter
        if (ipt.gt.1) then
           remain = .true.                ! still plotting to do.
           if (pl_id.eq.99) then
             xx = max(0.0,min(dx,dxx*x(1)))
             yy = max(0.0,min(dy,dyy*y(1)))
             call plmove(pl_id,xx,yy)
             do i=2,ipt
                xx = max(0.0,min(dx,dxx*x(i)))
                yy = max(0.0,min(dy,dyy*y(i)))
                call pldraw(pl_id,xx,yy)
             enddo
           else
             do i=1,ipt
               x(i) = (x(i)+0.5)/float(nx)
               y(i) = (y(i)+0.5)/float(ny)
             enddo
             call win_plot_array(vd_id,ipt,x,y)
           endif
           IF(IPT.EQ.512)THEN
     	    X(1)=X(512)
   	    Y(1)=Y(512)
   	    IPT=1
   	    GO TO 80
   	   ENDIF
        endif
        ipt = 0
C
1000	CONTINUE  !dans la boite
        if (control.eq.1) return		! test for abort
1001	CONTINUE  !sur les niveaux
        if (pl_id.ne.99) call win_update(vd_id)	! update image
1002	CONTINUE  !deplace la boite

        if (sign.eq.0) then     !if plot both, then do now negatives
           sign=-1
           goto 10000
        endif

c Final
        if (pl_id.eq.99) then
	   call plhome(pl_id)
        else
           call win_update(vd_id)	! update imag
        endif

        return
C
C
	END



