DEFDBL A-Z
DEFLNG H
ON ERROR GOTO 50000
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
SCREEN , , j, k: CLS
IF m15 < 0 THEN GOSUB 770 ELSE IF (m15 * 220) < 15 THEN GOSUB 10000
GOSUB 350: GOSUB 390: GOSUB 460: GOSUB 880

290 VIEW (219, 136)-(318, 198): LINE (-96, -80)-(96, 80), , B: PAINT (0, 0), 0: LINE (-96, -80)-(96, 80), , B: LINE (0, 0)-(96, -80), , B: PSET (-20, -20), 0: CIRCLE (-m13, m14), 2, 0: PSET (-m13, m14), 3

300 GOSUB 9990: PCOPY j, k: j = k: RESTORE: j = 1 - j: VIEW (23, 1)-(296, 130): GOTO 210

350 mx = sr1 * m3: my = cr1 * m4: m13 = m13 + mx: m14 = m14 + my: m15 = m15 + m5: m23 = cr1 * m13 - sr1 * m14: m24 = sr1 * m13 + cr1 * m14: m25 = m15: m33 = cr2 * m23 + sr2 * m25: m34 = m24: m35 = cr2 * m25 - sr2 * m23: m43 = m33: m44 = cr3 * m34 -  _
sr3 * m35: m45 = sr3 * m34 + cr3 * m35: RETURN

390 READ x, y, z: GOSUB 560: h1 = sx: h2 = sy: READ x, y, z: GOSUB 560: LINE (h1, h2)-(sx, sy)
IF CINT(h2) - CINT(sy) = 0 THEN LINE (h1, h2)-(sx, sy), 2
RETURN

460

x = 0: y = 0: z = 21456 / 220
GOSUB 610
IF y < 1 THEN
    CIRCLE (sx, sy), 1080 / 220, 15: PAINT (sx, sy), 15, 15
    FOR t = 1 TO 15: x = INT(108 / 221 * (RND)): y = INT(1080 / 221 * (RND))
        GOSUB 610
        PSET (sx, sy), 1
    NEXT t
END IF

FOR t = 1 TO 5
    READ x, y, z: GOSUB 610
    IF y < 1 THEN
        READ x, y, z
    ELSE
        PSET (sx, sy), 3: READ x, y, z: GOSUB 610: LINE -(sx, sy), 3
    END IF
NEXT t
READ x, y, z: GOSUB 610: IF y < 1 THEN READ x, y, z: GOTO 520 ELSE PSET (sx, sy), 0: READ x, y, z: GOSUB 610: LINE -(sx, sy), 0
520 RETURN

560 y = -1 * y: xa = cr2 * x + sr1 * z: za = cr2 * z - sr2 * x: ya = cr3 * y - sr3 * za: z = sr3 * y + cr3 * za: sx = d * xa / ya: sy = d * z / ya: RETURN

610 y = -1 * y: xa = cr1 * x - sr1 * y: ya = sr1 * x + cr1 * y: x = cr2 * xa + sr2 * z: za = cr2 * z - sr2 * xa: y = cr3 * ya - sr3 * za: z = sr3 * ya + cr3 * za: x = x + m43: y = y + m44: z = z + m45: sx = d * x / y: sy = d * z / y
IF sx > 32000 THEN sx = 32000 ELSE IF sx < -32000 THEN sx = -32000 ELSE IF sy > 32000 THEN sy = 32000 ELSE IF sy < -32000 THEN sy = -32000
IF sx > 32000# THEN sx = 32000 ELSE IF sx < -32000# THEN sx = -32000 ELSE IF sy > 32000# THEN sy = 32000 ELSE IF sy < -32000# THEN sy = -32000
RETURN

680 LOCATE 19, 4: PRINT "Altitude": LOCATE 20, 4: PRINT "Compass": LOCATE 21, 4: PRINT "Clock": LOCATE 22, 4: PRINT "Airspeed": LOCATE 23, 4: PRINT "Undercarriage is"
RETURN

730 SCREEN 0, 0, 0, 0: CLS : END

770 CLS : SCREEN , , 0, 0: VIEW: CLS : SCREEN , , 0, 0: VIEW: CLS
SCREEN 0, 0, 0, 0: LOCATE 12, 15: PRINT "C R A S H !": SOUND 60, 18: SOUND 32767, 10
LOCATE 20, 1: PRINT "Do you want another flight?": LOCATE 21, 1: PRINT "If yes, press Y": LOCATE 22, 1: PRINT "If no, press N"
810 k$ = UCASE$(INKEY$): IF k$ = "Y" THEN CLS : RESTORE: RUN
IF k$ = "N" THEN CLS : SCREEN 0, 0, 0, 0: CLS : END
IF k$ <> "" THEN GOSUB 9990
GOTO 810

880 c0 = INT(r1 * 57.3): LOCATE 19, 12: PRINT INT(m15 * 220); " ": LOCATE 20, 11: PRINT c0; " ": LOCATE 21, 10: PRINT TIME$: kt = CINT(m3 * (-60)): LOCATE 22, 12: PRINT kt; " ": CIRCLE (0, 0), 12, 3
LOCATE 23, 21: IF ucar = -1 THEN PRINT "Up  " ELSE PRINT "Down"
RETURN

920 CLS
SCREEN 1
SCREEN 7, 0, 0, 0: CLS : PALETTE 1, 9: PALETTE 2, 2: LOCATE 1, 1: PRINT "1-": GOSUB 680
WINDOW SCREEN (-160, -100)-(160, 100): VIEW (23, 1)-(296, 130), , 3
SCREEN 7, 0, 1, 0: CLS : PALETTE 1, 9: PALETTE 2, 2: LOCATE 1, 1: PRINT "-2": GOSUB 680
WINDOW SCREEN (-160, -100)-(160, 100): VIEW (23, 1)-(296, 130), , 3
SCREEN , , 0, 0
LINE (-160, 0)-(160, 0), 2
ON KEY(2) GOSUB 730: KEY(2) ON
GOTO 160

1050 DATA -25000,-10000,0,25000,-10000,0
DATA 0,0,0,0,0,-5,0,-40,0,0,-40,-5,48,0,0,48,0,-5,0,40,0,0,40,-5,-48,0,0,-48,0,-5
DATA -20,-20,0,-20,-20,-5

1100 j = 0
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
        IF m13 > 0 OR m14 > 0 THEN LOCATE 13, 5: PRINT "Now try to land inside the box!"
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

