C     REVISED FOR FL32
C     CHECK, ERRROR ON D NEEDS A TRUNCATION LIMIT (NOW IS SET TO 1D-2)
      SUBROUTINE FCN (NPAR,G,F,X,IFLAG)
C      IMPLICIT DOUBLE PRECISION (A-H,L-Z)
      SAVE
      COMMON/UNIT/ISYSRD,ISYSWR,ISYSPU,IVIDEO
      REAL*8 X(3),D(900),C(900),CCAL(900)
      REAL*8 DINF,CINF,TIME,STSIZE,SHIFT,F,FF,EROR,EROR2,SUM,Q1,Q2,Q3,C0
      REAL*8 ERFC,ERF,SIGSQ,CC,CCC,DIFF,TRUNC,CS(2),IN,DIFFS
      INTEGER I,CONTO,POINT0,MIN,NUM,NFF,SWTH,NERR,NERRIN
      OPEN(UNIT=19,FILE='DATA.OUT',STATUS='OLD')
C     **************
C     **************
C     in the input file:

C     SWTH
C     POINT0 MIN
C     DINF TIME
C     NUM
C     D(I) C(I)
C     **************
C     ***********************************************
C     **** NO NEED TO MODIFY ANYTHING HERE!!!! ******
C     ***********************************************

C     SWTH=0 -> (ERFC), SWTH=1 -> (EXP)
C      SWTH=0
C     point0 is the point where the zero is shifted(default is 1)
C      POINT0=16
C     MIN is the first point of the diffusion profile(BIGGER OR EQUAL TO point0)
C      MIN=23
C     DINF is the point where the baCkground start to be CalCulated (in real distance)
C      DINF=2300
C     CUTOFF (C-CINF)/(C0-CINF) FOR SIGMA
      TRUNC=1D-2
c     Run No: Nd-Di 03 T=900 C, t=96 hr
C      TIME=345600
C     ***************
      GO TO (10,40,40,40) IFLAG
C     NUM is the number of steps in the profile
10    READ (ISYSRD,*) SWTH
      READ (ISYSRD,*) POINT0,MIN
      READ (ISYSRD,*) DINF,TIME
      READ (ISYSRD,30) NUM
      WRITE (IVIDEO,30) NUM
      CONTO=0
      DO 11 I=1,NUM
C     READ (ISYSRD,31) D(I),C(I)
      READ (ISYSRD,*) D(I),C(I)
      WRITE (IVIDEO,31) D(I),C(I)
C     CINF is the average baCkground CalCulated after DINF
      IF(D(I).GT.DINF)THEN
      CINF=CINF+C(I)      
      CONTO=CONTO+1      
      ENDIF
11    CONTINUE
      CINF=CINF/(CONTO*1D0)
C     ******* SHIFT *********
      STSIZE=D(2)-D(1)
      SHIFT=(POINT0-1D0)*STSIZE
      DO 29 I=1,NUM
      D(I)=D(I)-SHIFT
      WRITE(ISYSWR,*) D(I),C(I)
29    CONTINUE
30    FORMAT(I4)
C31   FORMAT(F8.1,F8.1)
31    FORMAT(F10.3,F13.6)
C     ******************
40    F=0.0D0
      FF=0D0
      NFF=0
C     DIFF is the diffusion CoeffiCient (variable)
C     C0 is the ConCentration at distanCe=0 (variable)
      DIFF=X(1)
      C0=X(2)
      DO 100 I=MIN,NUM
      IF(SWTH.EQ.0)THEN
      SUM=D(I)/(2D0*(DIFF*TIME)**.5D0)
      IF(SUM.GT.7D0)THEN
      F=F+C(I)**2D0
      GOTO 100
      ENDIF
      Q1=1D0/(1D0+.3275911D0*SUM)
      Q2=-(SUM**2)
      Q3=.7978846D0*DEXP(Q2)
      ERFC=Q3*Q1*((((1.330274D0*Q1-1.821254D0)*Q1+1.781478D0)* 
     &Q1-.3565638D0)*Q1+.3193815D0)
      ERF=ERFC
      CCAL(I)=ERF*(C0-CINF)+CINF
      ELSE IF(SWTH.EQ.1)THEN
      CCAL(I)=(C0-CINF)*(EXP((-D(I)**2)/(4*DIFF*TIME)))+CINF
      ENDIF
      F=F+(C(I)-CCAL(I))**2
       IF((C(I)-CINF)/(C0-CINF).GT.0.1D0)THEN
       NFF=NFF+1
       FF=FF+((C(I)-CINF)/(C0-CINF)-(CCAL(I)-CINF)/(C0-CINF))**2
       ENDIF
100   CONTINUE
C     AVERAGE
      FF=FF/(NFF*1D0)
C     ******** PAUSA
      IF(IFLAG.EQ.3) GOTO 301
      RETURN      
C     ******** PAUSA
301   CONTINUE     
      EROR=0
      EROR2=0
      SIGSQ=0
      NERR=0
      DO 500 I=MIN,NUM
      WRITE(ISYSWR,501) D(I),(CCAL(I)-CINF)/(C0-CINF),
     &(C(I)-CINF)/(C0-CINF)
      WRITE(19,501) D(I),(CCAL(I)-CINF)/(C0-CINF),
     &(C(I)-CINF)/(C0-CINF)
      IF((CCAL(I)-CINF)/(C0-CINF).LT.TRUNC)GOTO 555
      NERR=NERR+1

      EROR=(((C(I)-CINF)/(C0-CINF))-((CCAL(I)-CINF)/
     &(C0-CINF)))
      EROR2=((TIME*D(I))/(2*DEXP((D(I)**2D0)/(4*DIFF*TIME))*
     &DSQRT(3.141592654D0)*((DIFF*TIME)**1.5D0)))
      SIGSQ=SIGSQ+(EROR/EROR2)**2
C      WRITE(ISYSWR,777)D(I),EROR/EROR2,LOG10(DABS(EROR/EROR2)),
C     &(CCAL(I)-CINF)/(C0-CINF)
C777   FORMAT(1F12.6,1F16.3,2F12.6)
C      WRITE(*,*)I,DIFF,EROR/EROR2+DIFF
555   CONTINUE
500   CONTINUE
      SIGSQ=SIGSQ/(NERR-MIN-1D0)


C     CALCULATE % OF POINTS WITHIN PROFILES GIVEN BY +- SIGMA D
      NERR=0
      NERRIN=0
      DO 600 I=MIN,NUM
      IF((CCAL(I)-CINF)/(C0-CINF).LT.TRUNC)GOTO 655
      NERR=NERR+1
      DO 601 I1=1,2
      IF(I1.EQ.1)DIFFS=X(1)+SIGSQ**.5D0
      IF(I1.EQ.2)DIFFS=X(1)-SIGSQ**.5D0
      IF(DIFFS.LT.0)DIFFS=1E-8
      SUM=D(I)/(2D0*(DIFFS*TIME)**.5D0)
      IF(SUM.GT.7D0)THEN
      CS(I1)=0
      GOTO 601
      ENDIF
      Q1=1D0/(1D0+.3275911D0*SUM)
      Q2=-(SUM**2)
      Q3=.7978846D0*DEXP(Q2)
      ERFC=Q3*Q1*((((1.330274D0*Q1-1.821254D0)*Q1+1.781478D0)* 
     &Q1-.3565638D0)*Q1+.3193815D0)
      ERF=ERFC
      CS(I1)=ERF
601   CONTINUE
      IF((C(I)-CINF)/(C0-CINF).LT.CS(1).AND.
     &(C(I)-CINF)/(C0-CINF).GT.CS(2))THEN
      NERRIN=NERRIN+1      
      ENDIF
600   CONTINUE
655   CONTINUE
      IN=100*NERRIN*1D0/NERR*1D0


C     CalCulate the profile for the 1000 angstrom
      DO 505 I=0,1000,25
      IF(SWTH.EQ.0)THEN
      SUM=I*1D0/(2*(DIFF*TIME)**.5D0)
      IF(SUM.GT.7) GOTO 505
      Q1=1D0/(1D0+.3275911D0*SUM)
      Q2=-(SUM**2)
      Q3=.7978846*DEXP(Q2)
      ERFC=Q3*Q1*((((1.330274D0*Q1-1.821254D0)*Q1+1.781478D0)* 
     &Q1-.3565638D0)*Q1+.3193815D0)
      ERF=ERFC
      CC=(C0-CINF)*ERF+CINF
      ELSE IF(SWTH.EQ.1)THEN
      CC=(C0-CINF)*(EXP((-I**2)/(4*DIFF*TIME)))+CINF
      ENDIF
      CCC=(CC-CINF)/(C0-CINF)
C      WRITE (IVIDEO,502)I,CCC,0D0
      WRITE (ISYSWR,502)I,CCC,0D0
505   CONTINUE

      WRITE(IVIDEO,*) 'Cinf ',CINF,' AFTER ',DINF, 'Angstrom'
      WRITE(ISYSWR,*) 'Cinf ',CINF,' AFTER ',DINF, 'Angstrom'
      WRITE(IVIDEO,*) 'STANDARD DEVIATION for D(*10^-16)', SIGSQ**.5D0
      WRITE(ISYSWR,*) 'STANDARD DEVIATION for D(*10^-16)', SIGSQ**.5D0
C      WRITE(IVIDEO,*) DLOG10(DIFF*10D0**(-16))

      WRITE(IVIDEO,*) 'STANDARD DEVIATION for LOG10(D)', 
     &(SIGSQ**.5D0)/(DIFF*2.303D0)
      WRITE(ISYSWR,*) 'STANDARD DEVIATION for LOG10(D)', 
     &(SIGSQ**.5D0)/(DIFF*2.303D0)
      WRITE(IVIDEO,*) 'DIFF C0',DIFF,C0
      WRITE(*,*)'LOG(DIF) FF',DLOG10(DIFF*1D-16),FF
      WRITE(*,*)'% POINTS WITHIN SIGMA',IN,NERR,NERRIN
501   FORMAT(F7.1,2F12.5)
502   FORMAT(I7,2F12.7)
      END      




