READ h12, h21, h13, h31, h14, h41     'garnet excess properties
READ h23, h32, h24, h42, h34, h43
READ s12, s21, s13, s31, s14, s41
READ s23, s32, s24, s42, s34, s43
READ v12, v21, v13, v31, v14, v41
READ v23, v32, v24, v42, v34, v43
READ HAn, SAn, VAn                     'Anothite properties (1bar,298K)
READ k0An, k1An, k2An, k3An            'Berman(1988), J. Petrology, V29
READ V1An, V2An, V3An, V4An
READ HGr, SGr, VGr                     'Grossular properties (1bar,298K)
READ k0Gr, k1Gr, k2Gr, k3Gr
READ V1Gr, V2Gr, V3Gr, V4Gr
READ HKy, SKy, VKy                     'Kyanite properties (1bar,298K)
READ k0Ky, k1Ky, k2Ky, k3Ky
READ V1Ky, V2Ky, V3Ky, V4Ky
READ HAnd, SAnd, VAnd                  'Andalusite properties (1bar,298K)
READ k0And, k1And, k2And, k3And
READ v1And, v2And, V3And, V4And
READ HSil, SSil, VSil                  'Sillimanite properties (1bar,298K)
READ k0Sil, k1Sil, k2Sil, k3Sil
READ V1Sil, V2Sil, V3Sil, V4Sil
READ HQa, SQa, VQa                     'Quartz(alpha) properties (1bar,298K)
READ k0Q, k1Q, k2Q, k3Q
READ V1Qa, V2Qa, V3Qa, V4Qa
READ HQb, SQb, VQb                     'Quartz(beta) properties (1bar,298K)
READ V1Qb, V2Qb, V3Qb, V4Qb
READ l1Q, l2Q
READ HAbOr, HOrAb, HAbAn, HAnAb, HOrAn, HAnOr
READ SAbOr, SOrAb, SAbAn, SAnAb, SOrAn, SAnOr
READ VAbOr, VOrAb, VAbAn, VAnAb, VOrAn, VAnOr
READ HAbOrAn, SAbOrAn, VAbOrAn
'******************************************

10 CLS
LOCATE 4, 1
PRINT "          (((?)))          "
PRINT "         (  o o  )         "
PRINT "   _____ooO_(_)_Ooo___________________________________________"
PRINT "   ***********************************************************"
PRINT "   * This program calculates pressure at a given temperature *"
PRINT "   * according to the equlibrium                             *"
PRINT "   *      3 anorthite = grossular + 2 kyanite + quartz       *"
PRINT "   ***********************************************************"
PRINT
PRINT
PRINT
      LOCATE 22, 1
PRINT "To read the instruction, Type 'y' and hit 'Enter; to start calculation,"
PRINT "hit 'Enter'"
INPUT a$
  IF a$ <> "y" AND a$ <> "Y" THEN GOTO 100
50   CLS
      LOCATE 2, 1
PRINT "             THERMODYNAMIC PROPERTIES OF PURE MINERALS "
PRINT "Molar volume, enthalpy and entropy: Berman, 1988, J. Petrology"
PRINT "For the pure end-member GASP reaction, this program uses the experimental"
PRINT "data of Koziol and Newton, 1988, Amer. Mineral"
PRINT "The program accounts for the effect of alpha-beta transition of quartz"
PRINT "and the aluminiumsilicate polymorphism. "
PRINT
PRINT "              THERMODYNAMIC SOLUTION MODELS"
PRINT "Garnet Solution Model: Ganguly, Cheng and Tirone, 1996, Contrib"
PRINT "Mineral Petrol 123, 137-151"
PRINT "Plagioclase Solution Model: Elkins and Grove(1990, Amer."
PRINT "Mineralog. 75, 544-559"
PRINT
      LOCATE 23, 1
PRINT "To read next page, Type 'y'and hit 'Enter'; else hit 'Enter'"
INPUT a$
  IF a$ <> "y" AND a$ <> "Y" THEN GOTO 100
CLS

LOCATE 2, 1
PRINT "                    ESTIMATION OF Fe3+   "
PRINT "If you have not estimated the Fe3+ contents of garnet,"
PRINT "then you could use a `default option' to estimate the Fe3+ contents"
PRINT "from the microprobe data of Fe(total). The default values are"
PRINT "calculated, according to Holdaway (1998, Amer Min):"
PRINT "Garnet: Fe3+ = 3% of total Fe"
PRINT "If you want to treat Fe2+= Fe(total), then input Fe3+ = 0.0001"
PRINT
LOCATE 23, 1
PRINT "To read about data file to input, type 'y'and hit 'Enter'; else hit 'Enter'"
INPUT b$
IF b$ <> "y" AND b$ <> "Y" THEN GOTO 100
'--------------------------------------------------------------
      CLS
      LOCATE 3, 1
PRINT "                  INPUT DATA FILE"
PRINT "Your data can be in a file with an extention data (xxx.dat), if you"
PRINT "want to use a number of data sets; alternatively, each data set can"
PRINT "be input one by one following the instruction below."
PRINT "You can input the data as either mole fraction or mole number. "
PRINT
PRINT "If you chose to use a data file, you should specify the file name with"
PRINT "the correct path (e.g. b:\name.dat)."
PRINT "To see if the program is working correctly, you can use the data file"
PRINT "(gasp.dat) provided with this package; it has 2 data sets, and for"
PRINT "an input T = 613 C, you will get P=6688.271 bars for both data sets"
PRINT " "
PRINT "The data for each coexisting pair must be in one line. Separate"
PRINT "each entry by a space without using comma. The first five entries"
PRINT "are for garnet in the order Fe, Fe3+, Mg, Ca and Mn, followed by "
PRINT "three entries for the plagioclase in the order An, Ab and Or"
PRINT
PRINT "If you want to use the default option to calculate Fe3+, then input"
PRINT "Fe3+ = 0"
      LOCATE 23, 1
PRINT "To start calculation, type 'y' and hit 'enter'; To read instruction again"
PRINT "hit 'enter'"
      INPUT c$
      IF c$ <> "y" AND c$ <> "Y" THEN GOTO 50
'-----------------------------------finish instruction
100   CLS
      LOCATE 19, 1
PRINT "If you want to use printer to print results, turn on your printer;"
PRINT "type 'y' and hit 'Enter'; else hit 'Enter'"
INPUT p$
PRINT

PRINT "If you want to input your data from a data file, then type '1'and hit 'Enter'"
PRINT "If you want to input data one by one, type '2'and hit 'Enter'"
      INPUT DD
      IF DD = 2 THEN GOTO 200
      CLS
      LOCATE 2, 1
PRINT "Type your input data file name (e.g. b:\name.dat)"
      INPUT "Input data file name: "; i$
PRINT
PRINT "Type your output data file name (e.g. b:\name.dat)"
      INPUT "Output data file name: "; o$
      OPEN o$ FOR OUTPUT AS #1
PRINT
PRINT "How many sets of the data?"
      INPUT "Data sets= "; zz
PRINT
PRINT "What is the assemblage temperature?"
      INPUT "T(C)= "; T
PRINT
      GOTO 250
      '-------------------------------------------------------------
200   CLS
LOCATE 3, 1
PRINT "What is the composition of Garnet?  Input the data as follows:"
PRINT "Fe, Fe3+, Mg, Ca, Mn (if no Fe3+ data, input Fe3+ = 0)"
      INPUT gfe, gfe3, gmg, gca, gmn
PRINT
PRINT "What is the composition of Feldspar? Input the data as follows:"
PRINT "An, Ab, Or"
      INPUT An, Ab, oor
PRINT
PRINT "What is the assemblage temperature?"
      INPUT "T(C)= "; T
PRINT
      CLS
      GOTO 300
'-------------------------------------
250   CLS
      OPEN i$ FOR INPUT AS #2
      FOR Z = 1 TO zz
      INPUT #2, gfe, gfe3, gmg, gca, gmn, An, Ab, oor
  
300   IF gfe3 = 0 THEN
      gfe2 = gfe * (1 - .03)
      ELSE
      gfe2 = gfe - gfe3
      END IF

      IF bfe3 = 0 THEN
      bfe2 = bfe * (1 - .116)
      ELSE
      bfe2 = bfe - bfe3
      END IF

'-------------------------------------

    x3 = gfe2 / (gfe2 + gmg + gca + gmn)
    x2 = gmg / (gfe2 + gmg + gca + gmn)
    x1 = gca / (gfe2 + gmg + gca + gmn)
    x4 = gmn / (gfe2 + gmg + gca + gmn)
    
    xAn = An / (An + Ab + oor)
    xAb = Ab / (An + Ab + oor)
    x0r = oor / (An + Ab + oor)
'
    Tk = T + 273.15
    Tr = 298.15
    Pr = 22.8 * T - 1093
    Pks = -7044.21 + 21.386 * T
    Pab = -17208.8 + 37.5462 * T
    P0 = 5000
'--------------------------
   w12 = h12 - Tk * s12
   w21 = h21 - Tk * s21
   w13 = h13 - Tk * s13
   w31 = h31 - Tk * s31
   w14 = h14 - Tk * s14
   w41 = h41 - Tk * s41
   w23 = h23 - Tk * s23
   w32 = h32 - Tk * s32
   w24 = h24 - Tk * s24
   w42 = h42 - Tk * s42
   w34 = h34 - Tk * s34
   w43 = h43 - Tk * s43
'----------------------------------------
   l1 = .5 * x2 * x3 * (1 - 2 * x1)
   l2 = .5 * x2 * x4 * (1 - 2 * x1)
   l3 = .5 * x3 * x4 * (1 - 2 * x1)
   l4 = -x2 * x3 * x4
   eg1 = w12 * (x2 ^ 2 * (1 - 2 * x1) + l1 + l2)
   eg2 = w21 * (2 * x1 * x2 * (1 - x1) + l1 + l2)
   eg3 = w13 * (x3 ^ 2 * (1 - 2 * x1) + l1 + l3)
   eg4 = w31 * (2 * x1 * x3 * (1 - x1) + l1 + l3)
   eg5 = w14 * (x4 ^ 2 * (1 - 2 * x1) + l2 + l3)
   eg6 = w41 * (2 * x1 * x4 * (1 - x1) + l2 + l3)
   eg7 = w23 * (-2 * x2 * x3 ^ 2 + l1 + l4)
   eg8 = w32 * (-2 * x3 * x2 ^ 2 + l1 + l4)
   eg9 = w24 * (-2 * x2 * x4 ^ 2 + l2 + l4)
   eg10 = w42 * (-2 * x4 * x2 ^ 2 + l2 + l4)
   eg11 = w34 * (-2 * x3 * x4 ^ 2 + l3 + l4)
   eg12 = w43 * (-2 * x4 * x3 ^ 2 + l3 + l4)
   eg = eg1 + eg2 + eg3 + eg4 + eg5 + eg6 + eg7 + eg8 + eg9 + eg10 + eg11 + eg12
'----------------------------------------------------------------
   ev1 = v12 * (x2 ^ 2 * (1 - 2 * x1) + l1 + l2)
   ev2 = v21 * (2 * x1 * x2 * (1 - x1) + l1 + l2)
   ev3 = v13 * (x3 ^ 2 * (1 - 2 * x1) + l1 + l3)
   ev4 = v31 * (2 * x1 * x3 * (1 - x1) + l1 + l3)
   ev5 = v14 * (x4 ^ 2 * (1 - 2 * x1) + l2 + l3)
   ev6 = v41 * (2 * x1 * x4 * (1 - x1) + l2 + l3)
   ev7 = v23 * (-2 * x2 * x3 ^ 2 + l1 + l4)
   ev8 = v32 * (-2 * x3 * x2 ^ 2 + l1 + l4)
   ev9 = v24 * (-2 * x2 * x4 ^ 2 + l2 + l4)
   ev10 = v42 * (-2 * x4 * x2 ^ 2 + l2 + l4)
   ev11 = v34 * (-2 * x3 * x4 ^ 2 + l3 + l4)
   ev12 = v43 * (-2 * x4 * x3 ^ 2 + l3 + l4)
   ev = ev1 + ev2 + ev3 + ev4 + ev5 + ev6 + ev7 + ev8 + ev9 + ev10 + ev11 + ev12
'*****************************************************
   wOrAb = HOrAb - Tk * SOrAb
   wAbOr = HAbOr - Tk * SAbOr
   wAbAn = HAbAn - Tk * SAbAn
   wAnAb = HAnAb - Tk * SAnAb
   wOrAn = HOrAn - Tk * SOrAn
   wAnOr = HAnOr - Tk * SAnOr
   wAbOrAn = HAbOrAn - Tk * SAbOrAn
   an1 = wOrAb * (xAb * x0r * (.5 - xAn - 2 * xAb))
   an2 = wAbOr * (xAb * x0r * (.5 - xAn - 2 * x0r))
   an3 = wAbAn * (2 * xAb * xAn * (1 - xAn) + xAb * x0r * (.5 - xAn))
   an4 = wAnAb * (xAb ^ 2 * (1 - 2 * xAn) + xAb * x0r * (.5 - xAn))
   an5 = wOrAn * (2 * x0r * xAn * (1 - xAn) + xAb * x0r * (.5 - xAn))
   an6 = wAnOr * (x0r ^ 2 * (1 - 2 * xAn) + xAb * x0r * (.5 - xAn))
   an7 = wAbOrAn * (x0r * xAb * (1 - 2 * xAn))
   egan = an1 + an2 + an3 + an4 + an5 + an6 + an7
'--------------------------------------------
   an1v = VOrAb * (xAb * x0r * (.5 - xAn - 2 * xAb))
   an2v = VAbOr * (xAb * x0r * (.5 - xAn - 2 * x0r))
   an3v = VAbAn * (2 * xAb * xAn * (1 - xAn) + xAb * x0r * (.5 - xAn))
   an4v = VAnAb * (xAb ^ 2 * (1 - 2 * xAn) + xAb * x0r * (.5 - xAn))
   an5v = VOrAn * (2 * x0r * xAn * (1 - xAn) + xAb * x0r * (.5 - xAn))
   an6v = VAnOr * (x0r ^ 2 * (1 - 2 * xAn) + xAb * x0r * (.5 - xAn))
   an7v = VAbOrAn * (x0r * xAb * (1 - 2 * xAn))
   evan = an1v + an2v + an3v + an4v + an5v + an6v + an7v
'-----------------------------------------------------
   Vant = VAn * (1 + V3An * (Tk - Tr) + V4An * (Tk - Tr) ^ 2)
   VGrt = VGr * (1 + V3Gr * (Tk - Tr) + V4Gr * (Tk - Tr) ^ 2)
   VKyt = VKy * (1 + V3Ky * (Tk - Tr) + V4Ky * (Tk - Tr) ^ 2)
   VAndt = VAnd * (1 + V3And * (Tk - Tr) + V4And * (Tk - Tr) ^ 2)
   VSil = VSil * (1 + V3Sil * (Tk - Tr) + V4Sil * (Tk - Tr) ^ 2)
   VQat = VQa * (1 + V3Qa * (Tk - Tr) + V4Qa * (Tk - Tr) ^ 2)
   VQbt = VQb * (1 + V3Qb * (Tk - Tr) + V4Qb * (Tk - Tr) ^ 2)
'---------------------------------
   IF Pks < P0 < Pab THEN GOTO 330
   IF P0 < Pks THEN GOTO 350
   VAlSi = VKy
   V1AlSi = V1Ky
   V2AlSi = V2Ky
   VAlSit = VKyt
   VQ = VQa
   V1Q = V1Qa
   V2Q = V2Qa
   VQt = VQat
   GOTO 400
330 VAlSi = VKy
    V1AlSi = V1Ky
    V2AlSi = V2Ky
    VAlSit = VKyt
    VQ = VQb
    V1Q = V1Qb
    V2Q = V2Qb
    VQt = VQbt
   GOTO 400
350 VAlSi = VSil
    V1AlSi = V1Sil
    V2AlSi = V2Sil
    VAlSit = VSilt
    VQ = VQb
    V1Q = V1Qb
    V2Q = V2Qb
    VQt = VQbt
'---------------------------------
400 rdvt = VGrt + 2 * VAlSit + VQt - 3 * Vant
    rdvt1 = VGr * V1Gr + 2 * VAlSi * V1AlSi + VQ * V1Q - 3 * VAn * V1An
    rdvt2 = VGr * V2Gr + 2 * VAlSi * V2AiSi + VQ * V2Q - 3 * VAn * V2An
600 aa = (Pr - P0) * rdvt
    bb = (.5 * (Pr ^ 2 - P0 ^ 2) - (Pr - P0)) * rdvt1
    cc = ((1 / 3) * (Pr ^ 3 - P0 ^ 3) - (Pr ^ 2 - P0 ^ 2) + (Pr - P0)) * rdvt2
      intvdp = aa + bb + cc
    GASP = intvdp - 3 * (eg - egan) - 6 * (P0 - 1) * (ev - evan) - 3 * 8.3136 * Tk * (LOG(x1) - LOG(xAn))
'-----------------------------------------
   digasp = -rdvt + (-P0 + 1) * rdvt1 + (-P0 ^ 2 + 2 * P0 - 1) * rdvt2
'***********************************************************************
   p1 = P0 - GASP / digasp
1600 IF ABS((p1 - P0) / p1) < .00001 THEN GOTO 1900
   P0 = p1
   GOTO 600
'*************************************************
1900 PRINT
     IF DD = 2 THEN Z = 1
     PRINT "No. "; Z, "T(C) = "; T
     PRINT "X(Fe)="; x3, "X(Mg)="; x2, "X(Ca)="; x1, "X(Mn)="; x4
     PRINT "X(An)="; xAn, "X(Ab)="; xAb, "X(Or)="; x0r
     PRINT "-------------------------------------------"
     PRINT "P(bar)="; p1
IF p$ = "y" OR p$ = "Y" THEN LPRINT
IF p$ = "y" OR p$ = "Y" THEN LPRINT "No. "; Z, "T(C) = "; T
IF p$ = "y" OR p$ = "Y" THEN LPRINT "X(Fe)="; x3, "X(Mg)="; x2, "X(Ca)="; x1, "X(Mn)="; x4
IF p$ = "y" OR p$ = "Y" THEN LPRINT "X(An)="; xAn, "X(Ab)="; xAb, "X(Or)="; x0r
IF p$ = "y" OR p$ = "Y" THEN LPRINT "--------------------------------------------------"
IF p$ = "y" OR p$ = "Y" THEN LPRINT "P(bar)="; p1
     IF DD = 2 THEN GOTO 1920
     PRINT #1, T, p1
NEXT Z
   CLOSE #1
   CLOSE #2

1920 LOCATE 23, 1
PRINT "To calculate more, type 'y'and hit 'Enter'; else hit 'Enter'"
     INPUT e$
     IF e$ = "y" OR e$ = "Y" THEN GOTO 10
2000 END
'***************************************************
DATA 21627, 9834, 873, 6773, 618, 618
DATA 2117, 695, 12083, 12083, 539, 539
DATA 5.78, 5.78, 1.69, 1.69, 0, 0
DATA 0, 0, 7.67, 7.67, 0, 0
DATA 0.012, 0.058, 0, 0.03, 0, 0
DATA 0.07, 0, 0.04, 0.03, 0.04, 0.01
DATA -4228730, 200.186, 10.075
DATA 439.37, -3734.1, 0, -317020000#
DATA -0.000001272, 0.000000000003176, 0.000010918, 0.0000000041985
DATA -6632859, 255.15, 12.538
DATA 573.43, -2039.4, -18887200#, 2319310000#
DATA -0.000000654, 0.000000000001635, 0.000018994, 0.0000000079756
DATA -2594220, 82.43, 4.412
DATA 262.68, -2001.4, -1999700#, -63180000#
DATA -0.000000646, 0, 0.000023973, 0
DATA -2589972, 91.434, 5.147
DATA 236.48, -1102.9, -7526800#, 936440000#
DATA -0.00000077, 0.000000000001923, 0.000023443, 0.0000000007189
DATA -2586091, 95.93, 4.983
DATA 256.73, -1887.2, -2977400#, 250960000#
DATA -0.000000753, 0, 0.000013431, 0
DATA -910700, 41.46, 2.269
DATA 80.01, -240.3, -3546700#, 491570000#
DATA -0.000002434, 0.000000000010137, 0.000023895, 0
DATA -908627, 44.207, 2.37
DATA -0.000001238, 0.000000000007087, 0, 0
DATA -0.09187, 0.00024607
DATA 18810, 27320, 7924, 0, 40317, 38974
DATA 10.3, 10.3, 0, 0, 0, 0
DATA 0.4602, 0.3264, 0, 0, 0, -0.1037
DATA 12545, 0, -1.095



