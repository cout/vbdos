DEFDBL A-Z
DEFLNG H
DIM a%(10000)
150 GOTO 920
160 GOSUB 1100

210 k$ = UCASE$(INKEY$): IF k$ = "" THEN 230
GOSUB 1200
230 r11 = r11 + r12: r1 = r1 + r11: r2 = r2 + r22: m5 = m5 + m5b: r3 = r3 + r3a
IF r1 > 6.28319 THEN r1 = r1 - 6.28139 ELSE IF r1 <= 0 THEN r1 = r1 + 6.28319
IF r2 > 6.28319 THEN r2 = r2 - 6.28139 ELSE IF r2 <= 0 THEN r2 = r2 + 6.28319
IF r3 > 6.28319 THEN r3 = r3 - 6.28139 ELSE IF r3 <= 0 THEN r3 = r3 + 6.28319
sr1 = SIN(r1): cr1 = COS(r1): sr2 = SIN(r2): cr2 = COS(r2): sr3 = SIN(r3): cr3 = COS(r3)
IF j = 1 THEN k = 0 ELSE k = 1
IF j = 1 THEN LOCATE 1, 1: PRINT "1-" ELSE LOCATE 1, 1: PRINT "-2"
GOSUB 880
SCREEN , , j, k: CLS
IF m15 < 0 THEN GOSUB 770 ELSE IF (m15 * 220) < 15 THEN GOSUB 10000
GOSUB 350: GOSUB 390: GOSUB 460

290 VIEW (219, 136)-(318, 198): LINE (-96, -80)-(96, 80), , B: PAINT (15, 15), 0, 3: LINE (-96, -80)-(96, 80), , B: CIRCLE (-m13, m14), 2, 0: PSET (-m13, m14), 3
WINDOW SCREEN (-160, -100)-(160, 100)
PUT (-160, -100), a%, OR: PSET (-20, -20), 0

300 GOSUB 9990: RESTORE: PCOPY j, k: j = k: VIEW (23, 1)-(296, 130): GOTO 210

350 mx = sr1 * m3: my = cr1 * m4: m13 = m13 + mx: m14 = m14 + my: m15 = m15 + m5: m23 = cr1 * m13 - sr1 * m14: m24 = sr1 * m13 + cr1 * m14: m25 = m15: m33 = cr2 * m23 + sr2 * m25: m34 = m24: m35 = cr2 * m25 - sr2 * m23: m43 = m33: m44 = cr3 * m34 -  _
sr3 * m35: m45 = sr3 * m34 + cr3 * m35: RETURN

390 READ x, y, z: GOSUB 560: H1 = sx: H2 = sy: READ x, y, z: GOSUB 560: LINE (H1, H2)-(sx, sy)
IF CINT(H2) - CINT(sy) = 0 THEN LINE (H1, H2)-(sx, sy), 2
RETURN

460
FOR t = 1 TO 5
    READ x, y: z = 0
    GOSUB 610
    IF y < 1 THEN
        READ x, y
    ELSE
        PSET (sx, sy), 9
        READ x, y: z = 0
        GOSUB 610
        LINE -(sx, sy), 9
    END IF
NEXT

FOR t1 = 1 TO 3
    READ x, y, z
    GOSUB 610
    IF y < 1 THEN
        FOR t2 = 1 TO 4
            READ x, y, z
        NEXT
        READ x, y, z
    ELSE
        PSET (sx, sy), 8
        FOR t2 = 1 TO 4
            READ x, y, z
            GOSUB 610
            LINE -(sx, sy), 8
        NEXT t2
        READ x, y, z
        GOSUB 610
        PAINT (sx, sy), 8, 8
    END IF
NEXT t1

READ x, y: z = -4
GOSUB 610
IF y < 1 THEN
    FOR t = 1 TO 11
        READ x, y
    NEXT
    READ x, y
ELSE
    PSET (sx, sy), 0
    FOR t = 1 TO 11
        READ x, y: z = -4
        GOSUB 610
        LINE -(sx, sy), 0
    NEXT
    READ x, y: z = -4
    GOSUB 610
    PAINT (sx, sy), 0, 0
END IF

FOR t1 = 1 TO 7
    READ x, y: z = -4
    GOSUB 610
    IF y < 1 THEN
        READ x, y
    ELSE
        PSET (sx, sy), 15
        READ x, y: z = -4
        GOSUB 610
        LINE -(sx, sy), 15
    END IF
NEXT

FOR t1 = 1 TO 5
    READ x, y: z = -4
    GOSUB 610
    IF y < 1 THEN
        READ x, y
    ELSE
        PSET (sx, sy), 12
        READ x, y: z = -4
        GOSUB 610
        LINE -(sx, sy), 12
    END IF
NEXT

FOR t = 1 TO 2
    READ x, y: z = -4
    GOSUB 610
    IF y < 1 THEN
        READ x, y
    ELSE
        PSET (sx, sy), 2
        READ x, y: z = -4
        GOSUB 610
        LINE -(sx, sy), 2
    END IF
NEXT

READ x, y, z
GOSUB 610
IF y < 1 THEN
    FOR t = 1 TO 4
        READ x, y, z
    NEXT
    READ x, y, z
ELSE
    PSET (sx, sy), 8
    FOR t = 1 TO 4 STEP 1
        READ x, y, z
        GOSUB 610
        LINE -(sx, sy), 8
    NEXT
    READ x, y, z
    GOSUB 610
    PAINT (sx, sy), 8, 8
END IF

READ x, y, z
GOSUB 610
IF y < 1 THEN
    FOR t = 1 TO 4
        READ x, y, z
    NEXT
    READ x, y, z
ELSE
    PSET (sx, sy), 7
    FOR t = 1 TO 4
        READ x, y, z
        GOSUB 610
        LINE -(sx, sy), 7
    NEXT
    READ x, y, z
    GOSUB 610
    PAINT (sx, sy), 7, 7
END IF

READ x, y, z
GOSUB 610
IF y < 1 THEN
    FOR t = 1 TO 4
        READ x, y, z
    NEXT t
    READ x, y, z
ELSE
    PSET (sx, sy), 7
    FOR t = 1 TO 4
        READ x, y, z
        GOSUB 610
        LINE -(sx, sy), 7
    NEXT
    READ x, y, z
    GOSUB 610
    PAINT (sx, sy), 7, 7
END IF

FOR t = 1 TO 2
    READ x, y, z
    GOSUB 610
    IF y < 1 THEN
        READ x, y, z
    ELSE
        PSET (sx, sy), 15
        READ x, y, z
        GOSUB 610
        LINE -(sx, sy), 15
    END IF
NEXT

RETURN

560 y = -1 * y: xa = cr2 * x + sr1 * z: za = cr2 * z - sr2 * x: ya = cr3 * y - sr3 * za: z = sr3 * y + cr3 * za: sx = d * xa / ya: sy = d * z / ya: RETURN
610 xa = cr1 * x - sr1 * y: ya = sr1 * x + cr1 * y: x = cr2 * xa + sr2 * z
za = cr2 * z - sr2 * xa: y = cr3 * ya - sr3 * za: z = sr3 * ya + cr3 * za
x = x + m43: y = y + m44: z = z + m45
sx = d * x / y: sy = d * z / y
IF sx > 32000 THEN sx = 32000 ELSE IF sx < -32000 THEN sx = -32000 ELSE IF sy > 32000 THEN sy = 32000 ELSE IF sy < -32000 THEN sy = -32000
IF sx > 32000# THEN sx = 32000 ELSE IF sx < -32000# THEN sx = -32000 ELSE IF sy > 32000# THEN sy = 32000 ELSE IF sy < -32000# THEN sy = -32000
RETURN

680 LOCATE 19, 4: PRINT "Altitude": LOCATE 20, 4: PRINT "Compass": LOCATE 21, 4: PRINT "Clock": LOCATE 22, 4: PRINT "Airspeed": LOCATE 23, 4: PRINT "Undercarriage is"
RETURN

730 SCREEN 0, 0, 0, 0: CLS : END

770 CLS : SCREEN , , 0, 0: VIEW: CLS : SCREEN , , 0, 0: VIEW: CLS
SCREEN 0, 0, 0, 0: LOCATE 12, 15: PRINT "C R A S H !": SOUND 60, 18: SOUND 32767, 10
FOR n = 200 TO 100 STEP 4: SOUND n, .7: NEXT: FOR n = 1000 TO 700 STEP -4: SOUND n, .7: NEXT: FOR n = 700 TO 1000 STEP 4: SOUND n, .7: NEXT
LOCATE 20, 1: PRINT "Do you want another flight?": LOCATE 21, 1: PRINT "If yes, press Y": LOCATE 22, 1: PRINT "If no, press N"
810 k$ = UCASE$(INKEY$): IF k$ = "Y" THEN CLS : RESTORE: RUN
IF k$ = "N" THEN CLS : SCREEN 0, 0, 0, 0: CLS : END
IF k$ <> "" THEN GOSUB 9990
GOTO 810

880 c0 = INT(r1 * 57.3): LOCATE 19, 12: PRINT INT(m15 * 220); " "
LOCATE 20, 11: PRINT c0; " "
LOCATE 21, 10: PRINT TIME$
kt = CINT(m3 * (-60)): LOCATE 22, 12: PRINT kt; " "
CIRCLE (0, 0), 12, 3
LOCATE 23, 21: IF ucar = -1 THEN PRINT "Up  " ELSE PRINT "Down"
RETURN

920 CLS
ON ERROR GOTO 1030
SCREEN 1, 0, 0, 0
ON ERROR GOTO 1040
SCREEN 7, 0, 0, 0
930 ON ERROR GOTO 50000
PALETTE 1, 9: PALETTE 2, 2: CLS : LOCATE 1, 1: PRINT "1-": GOSUB 680
SCREEN 7, 0, 1, 0: CLS : PALETTE 1, 9: PALETTE 2, 2: LOCATE 1, 1: PRINT "-2": GOSUB 680
WINDOW SCREEN (-160, -100)-(160, 100): VIEW (23, 1)-(296, 130), , 3
LINE (-160, 0)-(160, 0), 2: PAINT (0, -90), 1, 2
SCREEN 7, 0, 0, 0
ON KEY(2) GOSUB 730: KEY(2) ON

VIEW (219, 136)-(318, 198)
WINDOW SCREEN (-160, -100)-(160, 100)

FOR t = 1 TO 5
    READ x, y
        PSET (x, y), 9
        READ x, y
        LINE -(x, y), 9
NEXT

FOR t1 = 1 TO 3
    READ x, y, z
        PSET (x, y), 8
        FOR t2 = 1 TO 4
            READ x, y, z
            LINE -(x, y), 8
        NEXT t2
        READ x, y, z
        PAINT (x, y), 8, 8
NEXT t1

READ x, y
    PSET (sx, sy), 0
    FOR t = 1 TO 11
        READ x, y
        LINE -(x, y), 0
    NEXT
    READ x, y
    PAINT (x, y), 0, 0

FOR t1 = 1 TO 7
    READ x, y
        PSET (x, y), 15
        READ x, y
        LINE -(x, y), 15
NEXT

FOR t1 = 1 TO 5
    READ x, y
        PSET (x, y), 12
        READ x, y
        LINE -(x, y), 12
NEXT

FOR t = 1 TO 2
    READ x, y
        PSET (x, y), 2
        READ x, y
        GOSUB 610
        LINE -(x, y), 2
NEXT

READ x, y, z
    PSET (x, y), 8
    FOR t = 1 TO 4 STEP 1
        READ x, y, z
        LINE -(x, y), 8
    NEXT
    READ x, y, z

READ x, y, z
    PSET (x, y), 7
    FOR t = 1 TO 4
        READ x, y, z
        LINE -(x, y), 7
    NEXT
    READ x, y, z

READ x, y, z
    PSET (x, y), 7
    FOR t = 1 TO 4
        READ x, y, z
        LINE -(x, y), 7
    NEXT
    READ x, y, z

FOR t = 1 TO 2
    READ x, y, z
        PSET (x, y), 15
        READ x, y, z
        LINE -(x, y), 15
NEXT
RESTORE
GET (-160, -100)-(160, 100), a%
CLS
WINDOW SCREEN (-160, -100)-(160, 100): VIEW (23, 1)-(296, 130), , 3
LINE (-160, 0)-(160, 0), 2: PAINT (0, -90), 1, 2
GOTO 160

1030 LOCATE 1, 1: PRINT "A CGA, EGA, VGA, or MCGA graphics adapter"
PRINT "is required."
END

1040 LOCATE 1, 1: PRINT "A EGA or VGA is reccomended to run this"
PRINT "program."
PRINT : PRINT "Press any key to continue..."
DO UNTIL INKEY$ = "": LOOP
DO WHILE INKEY$ = "": LOOP
CLS
RESUME 930

1050 DATA -25000,-10000,0,25000,-10000,0
DATA -70,-30,8,-60,-70,0,70,-56,-70,32,70,-23,-100,90,175,-32,-100,130,175,-10
DATA 0,-37,0,-5,-28,0,-5,-28,-4,0,-37,-4,0,-37,0,-3,-33,-2
DATA -5,-28,0,-3,45,0,-3,45,-4,-5,-28,-4,-5,-28,0,-4,-8,-2
DATA 0,-37,0,5,-28,0,5,-28,-4,0,-37,-4,0,-37,0,2,-33,-2
DATA -4,-42,-6,-32,-11,-29,-11,17,-6,24,-4,45,4,45,5,24,10,18,10,-27,6,-40,-4,-42,0,-25
DATA -2,-42,-11,17,6,-40,-6,24,1,-35,0,-30,-1,-24,-2,-18,-3,-13,-4,-7,-5,-2,-6,4,-7,9,-8,15
DATA 2,-41,1,-35,0,-30,-1,-24,-2,-18,-3,-13,-4,-7,-5,-2,-6,4,-7,9
DATA -8,-19,4,-17,0,16,0,43
DATA 7,-17,-4,7,-17,-8,10,-17,-8,10,-17,-4,7,-17,-4,8,-17,-6
DATA 7,-17,-4,7,-17,-8,7,-4,-8,7,-4,-4,7,-17,-4,7,-10,-6
DATA 7,-17,-8,7,-4,-8,10,-4,-8,10,-17,-8,7,-17,-8,8,-10,-8
DATA 7.5,-10,-8,7.5,-10,-11,7.5,-6,-8,7.5,-6,-11

1100 j = 1
d = 200
m13 = 24: m14 = 80: m15 = 12
m3 = -2!: m4 = m3 * .83333: m5 = 0
r1 = 6.28319: r2 = 6.28319: r3 = 6.28319
ucar = -1
RETURN

1200 SELECT CASE k$
    CASE "W"
        m5b = m5b - .05
        r3a = r3a - .04363
    CASE "X"
        m5b = m5b + .05
        r3a = r3a + .04363
    CASE "A"
        r12 = r12 - .01309
        r22 = r22 - .04363
    CASE "D"
        r12 = r12 + .01309
        r22 = r22 + .04363
    CASE "S"
        r22 = 0
        r12 = 0
        m5b = 0
        r3a = 0
    CASE "="
        m3 = m3 - .1
        m4 = m3 * .83333
    CASE "-"
        m3 = m3 + .1
        m4 = m3 * .83333
        IF CINT(m3 * (-60)) <= 0 THEN GOSUB 770
    CASE "0"
        ucar = -ucar
END SELECT
RETURN

9990 SOUND 400, .7: SOUND 500, .7: RETURN

10000 IF ucar = 1 THEN
    kt = CINT(m3 * (-60))
    IF kt <= 20 THEN
        SCREEN 0, 0, 0, 0
        LOCATE 12, 12: PRINT "A SAFE LANDING!"
        IF m13 > 45 AND m13 < -28 AND m14 > 45 AND m14 < -28 THEN
            LOCATE 14, 5
            PRINT "Now try to land on the carrier"
        END IF
        LOCATE 20, 1: PRINT "Another flight (Y/N)?"
10010   DO: a$ = UCASE$(INKEY$): LOOP WHILE a$ = ""
        IF a$ = "Y" THEN CLS : RESTORE: RUN
        IF a$ = "N" THEN CLS : END
        GOSUB 9990
        GOTO 10010
    END IF
END IF
RETURN

50000 RESUME NEXT

