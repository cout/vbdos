DEFINT A-Z
DECLARE SUB BigTextEnd (SndT, PlyT)
DECLARE SUB BigText (Factor%, S$, Y%, X%, C%)
DECLARE SUB Plot (Num, Y, X)
STACK 512
DIM Grid(20, 20) AS STRING * 1
DIM Colors(3) AS INTEGER
DIM Gcol(20, 20) AS INTEGER
DIM SHARED Text AS INTEGER
DIM SHARED Brick(65, 3)
DIM Pic&(8192)
DIM Temp(5000), TempVar(5000)
DIM SHARED SndT, PlyT

DIM A$(186)
L$ = CHR$(0) + CHR$(75)
R$ = CHR$(0) + CHR$(77)
U$ = CHR$(0) + CHR$(72)
D$ = CHR$(0) + CHR$(80)
F1$ = CHR$(0) + CHR$(59)
F2$ = CHR$(0) + CHR$(60)
F3$ = CHR$(0) + CHR$(61)
F4$ = CHR$(0) + CHR$(62)

PLAY "o0MBL8 "
DATA A16,MN, A2,o1,ML,E4.,D-32,C32,D2
DATA C16,ML,O0,B16,o0,D-16,MN,o1,C,C,o0,B2,A4.,ML,C16,G16
DATA F2,o1,C4.,o0,ML,B16,G16,A-4
DATA A4,B.,o1,MS,C16,MN,D.
DATA o0,ML,G16,B16,MN,o1,E,E,ML,E4,D8,ML,C16,E16,MN,E2
DATA T240
DATA o0,F2,ML,B2,B4,MN,E4,ML,A2
DATA A,MN,D,ML,G2,G4,MN,C4,F2
DATA T120
DATA o0,MS,E4,o1,ML,C2,C8
DATA MN,F8,ML,G16,F16,E16,D16
DATA C2,C8,MN,F8,ML,G16,F16,E16,D16

DATA o1,Co0,G,ML,A16,G16,F16,D16,MN,G,B-,o1,ML,C16,o0,B16,A16,G16,MN,o1,C2.
DATA ML,o0,G,B,o1,D,MN,D,D4,P8,G,G
DATA F+,F,F,E,P8,E-,ML,E,D,D,E,E,D,D,C,MN,C4,ML,o0,B.,A16,B16,MN,A4,P8,A
DATA o0,ML,D,B4.,A,G4,P8,D,B4,A,G4,P8,D,o1,E2.,MS,D,C,o0,B,A,G4,P4,P8,ML,E16

PRINT "Please Wait..."
FOR J = 1 TO 184
    READ A$(J)
NEXT J
LOCATE 1, 1: PRINT "             "

SndT = 1
PlyT = 1
Com$ = UCASE$(COMMAND$)

IF INSTR(Com$, "NOGR") THEN NoGr = 1
IF INSTR(Com$, "TEXT") THEN
    Text = 1
    GOTO Txt
END IF
IF Text <> 1 THEN
    ON ERROR GOTO Text
    IF INSTR(Com$, "MCGA") THEN
        SCREEN 13
        MCGA = 1
    ELSE
        SCREEN 9
    END IF
    ON ERROR GOTO 0
    FOR J = 1 TO 3
        LINE (1, 1)-(7, 7), J, BF
        LINE (1, 1)-(1, 7), 3 + J
        LINE (1, 1)-(7, 1), 3 + J
        LINE (7, 1)-(7, 7), 8 + J
        LINE (7, 7)-(2, 7), 8 + J
        GET (1, 1)-(7, 7), Brick(0, J)
    NEXT J
    IF MCGA <> 1 THEN
        PALETTE 4, 8
        PALETTE 5, 16
        PALETTE 6, 24
    ELSE
        PALETTE 4, 1376256
        PALETTE 5, 5376&
        PALETTE 6, 1381632
    END IF
    CLS
    IF MCGA <> 1 THEN
        WINDOW (0, 0)-(319, 199)
        WIDTH 40
    END IF
    IF MCGA <> 1 AND NoGr <> 1 THEN
        LINE (118, 100)-(208, 112), 15, B
        LOCATE 14, 16: PRINT "Please Wait"
        GET (119, 101)-(207, 111), Temp
        PUT (119, 101), Temp
        PAINT (122, 102), 7, 15
        PUT (119, 101), Temp, OR
        LINE (118, 100)-(208, 112), 8, B
        LINE (208, 101)-(208, 112), 15
        LINE (119, 112)-(208, 112), 15

        ON ERROR GOTO Ferror
        OPEN "Piles.NAS" FOR INPUT AS #1
        FOR J% = 0 TO 8192
            INPUT #1, Pic&(J%)
        NEXT J%
        CLOSE
    END IF
END IF

GOTO Start

Ferror:
RESUME Start:

Text:
RESUME Txt

Txt:
Text = 1
SCREEN 0
WIDTH 40
CLS

Start:

IF MCGA = 1 THEN SHELL "LOADPCX PILES.PCX"

Score& = 0

ON ERROR GOTO 0

IF Text <> 1 THEN
    CLS
    IF MCGA <> 1 AND NoGr <> 1 THEN
        PUT (0, 0), Pic&(0)
        COLOR 9
        LINE (160, 0)-(160, 160), 9
        LINE (0, 160)-(160, 160), 9
    END IF
    LINE (0, 0)-(159, 159), 0, BF
ELSE
    FOR J = 1 TO 24
        LOCATE 25, 1
        PRINT SPACE$(34);
    NEXT J
END IF

RANDOMIZE TIMER

FOR X = 1 TO 20
    FOR Y = 1 TO 20
        Grid(X, Y) = " "
        Gcol(X, Y) = 0
    NEXT Y
NEXT X

FOR J = 1 TO 20
    LOCATE J, 1
    PRINT SPACE$(20)
NEXT J

COLOR 9
LOCATE 1, 25
PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
LOCATE 2, 25
PRINT "³  S C O R E  ³"
LOCATE 3, 25
PRINT "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
LOCATE 4, 25
PRINT USING "³ ###,###,### ³"; Score
LOCATE 5, 25
PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
IF Text <> 1 THEN
    LINE (197, 6)-(197, 19), 1
    LINE (197, 5)-(306, 5), 1
    LINE (197, 22)-(197, 35), 1
    LINE (197, 21)-(306, 21), 1
    LINE (197, 37)-(308, 37), 1
    LINE (309, 37)-(309, 5), 1
    COLOR 1
    LOCATE 2, 26
    GET (198, 8)-(305, 15), TempVar
    PRINT "  S C O R E  "
    GET (198, 8)-(305, 15), Temp
    PUT (199, 9), Temp, OR
    PUT (198, 8), TempVar, OR
END IF
LOCATE 6, 28
PRINT "Level:";
LOCATE 7, 30
PRINT L
LOCATE 21, 1

Colors(1) = INT(3 * RND) + 1
Colors(2) = INT(3 * RND) + 1
Colors(3) = INT(3 * RND) + 1
X = 10: Y = 1
Xold = X: Yold = Y
Fold = Flipped

IF Text = 1 OR NoGr = 1 THEN
    IF Text <> 1 THEN
        COLOR 9
        LOCATE 8, 23
        PRINT "ÚÄÄÄ¿ ÚÄÄÄ¿ ÚÄÄÄ¿"
        LOCATE 9, 23
        PRINT "³   ³ ³   ³ ³   ³"
        LOCATE 10, 23
        PRINT "ÀÄÄÄÙ ÀÄÄÄÙ ÀÄÄÄÙ"
        LOCATE 11, 23
        PRINT "ÚÄÄÄ¿ ÚÄÄÄ¿ ÚÄÄÄ¿"
        LOCATE 12, 23
        PRINT "³   ³ ³   ³ ³   ³"
        LOCATE 13, 23
        PRINT "ÀÄÄÄÙ ÀÄÄÄÙ ÀÄÄÄÙ"
        LOCATE 14, 23
        PRINT "ÚÄÄÄ¿ ÚÄÄÄ¿ ÚÄÄÄ¿"
        LOCATE 15, 23
        PRINT "³   ³ ³   ³ ³   ³"
        LOCATE 16, 23
        PRINT "ÀÄÄÄÙ ÀÄÄÄÙ ÀÄÄÄÙ"
        GET (177, 58)-(311, 128), TempVar
        PUT (175, 58), TempVar, XOR
        GET (176, 57)-(311, 128), Temp
        PUT (175, 56), Temp, OR
        PUT (175, 56), TempVar, OR
        GET (176, 57)-(311, 128), TempVar
    END IF
    COLOR 1
    LOCATE 8, 23
    PRINT "ÚÄÄÄ¿ ÚÄÄÄ¿ ÚÄÄÄ¿"
    LOCATE 9, 23
    PRINT "³ 7 ³ ³ 8 ³ ³ 9 ³"
    LOCATE 10, 23
    PRINT "ÀÄÄÄÙ ÀÄÄÄÙ ÀÄÄÄÙ"
    LOCATE 11, 23
    PRINT "ÚÄÄÄ¿ ÚÄÄÄ¿ ÚÄÄÄ¿"
    LOCATE 12, 23
    PRINT "³ "; CHR$(27); " ³ ³?-¨³ ³ "; CHR$(26); " ³"
    LOCATE 13, 23
    PRINT "ÀÄÄÄÙ ÀÄÄÄÙ ÀÄÄÄÙ"
    LOCATE 14, 23
    PRINT "ÚÄÄÄ¿ ÚÄÄÄ¿ ÚÄÄÄ¿"
    LOCATE 15, 23
    PRINT "³ 1 ³ ³ "; CHR$(25); " ³ ³ 3 ³"
    LOCATE 16, 23
    PRINT "ÀÄÄÄÙ ÀÄÄÄÙ ÀÄÄÄÙ"
    IF Text <> 1 THEN PUT (178, 59), TempVar, OR
    COLOR 14
    LOCATE 22, 1
    PRINT " _         _   _"
    COLOR 13
    LOCATE 23, 1
    PRINT "|_> | |   |_  |_"
    PRINT "|   | |__ |_   _|     ";
    COLOR 9
    LOCATE 25, 1
    REM The following line is a "dummy" line; the x's represent the current year
    PRINT "(C) Copyright 1993 Paul Brannan";
    COLOR 9
    FOR J = 1 TO 20
        LOCATE J, 21
        PRINT "³"
    NEXT J
    PRINT STRING$(20, 196); "Ù"
END IF

COLOR 7

ON TIMER(1) GOSUB Plyer2
TIMER ON
ON PLAY(1) GOSUB Player
PLAY ON
PLAY "MLE16"
IF INSTR(Com$, "NOMUS") THEN
    PLAY OFF
    PlyT = 0
END IF
IF INSTR(Com$, "NOSND") THEN SndT = 0

DO
    IF PLAY(0) = 0 AND PlyT = 1 THEN GOSUB Player
    L = INT(Score& / 1000) + 1
    IF L <> Lold THEN
        IF SndT = 1 AND PlyT = 0 THEN
            SOUND 30000, 0
            SOUND 600, 1
            SOUND 1000, 1
            SOUND 32767, .1
            SOUND 1000, 1
            SOUND 32767, .1
            SOUND 1000, 1
            SOUND 32767, .1
        ELSEIF SndT = 1 THEN
            SOUND 30000, 0: SOUND 600, 1
            SOUND 30000, 0: SOUND 1000, 1
            SOUND 30000, 0: SOUND 32767, .1
            SOUND 30000, 0: SOUND 1000, 1
            SOUND 30000, 0: SOUND 32767, .1
            SOUND 30000, 0: SOUND 1000, 1
            SOUND 30000, 0: SOUND 32767, .1
        END IF
        LOCATE 6, 28
        PRINT "Level:";
        LOCATE 7, 30
        PRINT L
    END IF
    Lold = L

    IF Xold <> X OR Yold <> Y OR Fold <> Flipped THEN
        IF Yold < 2 THEN Yold = 2
        COLOR 0
        IF Fold THEN
            LOCATE Yold, Xold
            PRINT " "
            LOCATE Yold, Xold - 1
            PRINT " "
            LOCATE Yold, Xold + 1
            PRINT " "
        ELSE
            LOCATE Yold, Xold
            PRINT " "
            LOCATE Yold + 2, Xold
            PRINT " "
            LOCATE Yold + 1, Xold
            PRINT " "
        END IF
        IF Flipped THEN
            Plot Colors(1), Y - 1, X - 1
            Plot Colors(2), Y - 1, X
            Plot Colors(3), Y - 1, X + 1
        ELSE
            Plot Colors(1), Y - 1, X
            Plot Colors(2), Y, X
            Plot Colors(3), Y + 1, X
        END IF
    END IF

    Xold = X
    Yold = Y
    Fold = Flipped

    SELECT CASE UCASE$(INKEY$)
        CASE CHR$(27)
            GOTO Ender
        CASE "4", L$
            IF Flipped THEN
                IF X - 2 < 1 THEN X = X + 1
                IF Grid(X - 2, Y) = " " THEN
                    X = X - 1
                    IF X < 1 THEN X = 1
                END IF
            ELSE
                IF X - 1 < 1 THEN X = X + 1
                IF Grid(X - 1, Y) = " " THEN
                    IF Grid(X - 1, Y + 1) = " " THEN
                        IF Grid(X - 1, Y + 2) = " " THEN
                            X = X - 1
                        END IF
                    END IF
                END IF
            END IF
        CASE "6", R$
            IF Flipped THEN
                IF X + 2 > 20 THEN X = X - 1
                IF Grid(X + 2, Y) = " " THEN
                    X = X + 1
                    IF X > 19 THEN X = 19
                END IF
            ELSE
                IF X + 1 > 20 THEN X = X - 1
                IF Grid(X + 1, Y) = " " THEN
                    IF Grid(X + 1, Y + 1) = " " THEN
                        IF Grid(X + 1, Y + 2) = " " THEN
                            X = X + 1
                        END IF
                    END IF
                END IF
            END IF
        CASE "2", D$
            IF Flipped THEN
                IF Y + 1 < 21 THEN
                    IF Grid(X, Y + 1) = " " AND Grid(X - 1, Y + 1) = " " AND Grid(X + 1, Y + 1) = " " THEN
                        Y = Y + 1
                        t@ = TIMER
                        IF Y > 20 THEN
                            GOSUB Check
                            Grid(X, Y) = "Û"
                            Grid(X, Y + 1) = "Û"
                            Grid(X, Y + 2) = "Û"
                            GOSUB Dcheck
                            Y = 1: X = 10
                            Xold = X: Yold = Y
                        END IF
                    END IF
                END IF
            ELSE
                IF Y + 3 < 21 THEN
                    IF Grid(X, Y + 3) = " " THEN
                        Y = Y + 1
                        t@ = TIMER
                        IF Y > 20 THEN
                            GOSUB Check
                            Grid(X, Y) = "Û"
                            Grid(X, Y + 1) = "Û"
                            Grid(X, Y + 2) = "Û"
                            GOSUB Dcheck
                            Y = 1: X = 10
                            Xold = X: Yold = Y
                        END IF
                    END IF
                END IF
            END IF
        CASE "5", U$
            Flipped = NOT Flipped
            F = F + 1
            IF Flipped THEN
                IF X - 1 < 1 OR X + 1 > 20 THEN
                    Flipped = NOT Flipped
                    F = F - 1
                ELSEIF Grid(X, Y) = "Û" OR Grid(X - 1, Y) = "Û" OR Grid(X + 1, Y) = "Û" THEN
                    Flipped = NOT Flipped
                    F = F - 1
                END IF
            ELSE
                IF Y + 3 > 21 THEN
                    Flipped = NOT Flipped
                    F = F - 1
                ELSEIF Grid(X, Y) = "Û" OR Grid(X, Y + 1) = "Û" OR Grid(X, Y + 2) = "Û" THEN
                    Flipped = NOT Flipped
                    F = F - 1
                END IF
            END IF
            IF F > 3 THEN F = 0
            IF F = 0 OR F = 2 THEN
                Temp = Colors(1)
                Colors(1) = Colors(3)
                Colors(3) = Temp
            END IF
        CASE F1$
            PLAY ON
            TIMER ON
            PlyT = 1
        CASE F2$
            PLAY OFF
            TIMER OFF
            PlyT = 0
        CASE F3$
            SndT = 1
        CASE F4$
            SndT = 0
    END SELECT

    IF t@ + (.5 / L) < TIMER THEN
        IF Flipped THEN
            IF Y < 20 THEN
                IF Grid(X, Y + 1) = " " AND Grid(X - 1, Y + 1) = " " AND Grid(X + 1, Y + 1) = " " THEN
                    Y = Y + 1
                    IF Y > 20 THEN
                        GOSUB Check
                        Grid(X, Y) = "Û"
                        Grid(X, Y + 1) = "Û"
                        Grid(X, Y + 2) = "Û"
                        GOSUB Dcheck
                        Y = 1: X = 10
                        Xold = X: Yold = Y
                    END IF
                    t@ = TIMER
                ELSE
                    GOSUB Check
                    Grid(X, Y) = "Û"
                    Grid(X - 1, Y) = "Û"
                    Grid(X + 1, Y) = "Û"
                    GOSUB Dcheck
                    Y = 1: X = 10
                    Xold = X: Yold = Y
                END IF
            ELSE
                GOSUB Check
                Grid(X, Y) = "Û"
                Grid(X - 1, Y) = "Û"
                Grid(X + 1, Y) = "Û"
                GOSUB Dcheck
                Y = 1: X = 10
                Xold = X: Yold = Y
            END IF
        ELSE
            IF Y + 3 < 21 THEN
                IF Grid(X, Y + 3) = " " THEN
                    Y = Y + 1
                    IF Y > 20 THEN
                        GOSUB Check
                        Grid(X, Y) = "Û"
                        Grid(X, Y + 1) = "Û"
                        Grid(X, Y + 2) = "Û"
                        GOSUB Dcheck
                        Y = 1: X = 10
                        Xold = X: Yold = Y
                    END IF
                    t@ = TIMER
                ELSE
                    GOSUB Check
                    Grid(X, Y) = "Û"
                    Grid(X, Y + 1) = "Û"
                    Grid(X, Y + 2) = "Û"
                    GOSUB Dcheck
                    Y = 1: X = 10
                    Xold = X: Yold = Y
                END IF
            ELSE
                GOSUB Check
                Grid(X, Y) = "Û"
                Grid(X, Y + 1) = "Û"
                Grid(X, Y + 2) = "Û"
                GOSUB Dcheck
                Y = 1: X = 10
                Xold = X: Yold = Y
            END IF
        END IF
    END IF

    IF Flipped THEN
        IF Y > 20 THEN
            GOSUB Check
            Grid(X, Y) = "Û"
            Grid(X + 1, Y) = "Û"
            Grid(X - 1, Y) = "Û"
            GOSUB Dcheck
            Y = 1: X = 10
            Xold = X: Yold = Y
        END IF
    ELSE
        IF Y + 2 > 20 THEN
            GOSUB Check
            Grid(X, Y) = "Û"
            Grid(X, Y + 1) = "Û"
            Grid(X, Y + 2) = "Û"
            GOSUB Dcheck
            Y = 1: X = 10
            Xold = X: Yold = Y
        END IF
    END IF
LOOP

Check:
IF Flipped THEN
    Gcol(X - 1, Y) = Colors(1)
    Gcol(X, Y) = Colors(2)
    Gcol(X + 1, Y) = Colors(3)
ELSE
    Gcol(X, Y) = Colors(1)
    Gcol(X, Y + 1) = Colors(2)
    Gcol(X, Y + 2) = Colors(3)
END IF
RETURN

Dcheck:
XS = X: YS = Y
Bonus = 10
FOR X = 1 TO 19
    FOR Y = 2 TO 19
    XFlag = 0
    FOR X1 = X - 1 TO X + 1
        IF Gcol(X1, Y) <> 0 THEN
        IF X1 > 1 THEN
            IF Gcol(X1 - 2, Y) = Gcol(X1, Y) THEN
                IF Gcol(X1 - 1, Y) = Gcol(X1, Y) THEN
                    Cly = Y: Clx = X1 - 2
                    GOSUB Clr
                    Cly = Y: Clx = X1 - 1
                    GOSUB Clr
                    Cly = Y: Clx = X1
                    GOSUB Clr
                END IF
            END IF
        END IF
        IF X1 > 0 AND X1 < 20 THEN
            IF Gcol(X1 - 1, Y) = Gcol(X1, Y) THEN
                IF Gcol(X1 + 1, Y) = Gcol(X1, Y) THEN
                    Cly = Y: Clx = X1 - 1
                    GOSUB Clr
                    Cly = Y: Clx = X1 + 1
                    GOSUB Clr
                    Cly = Y: Clx = X1
                    GOSUB Clr
                END IF
            END IF
        END IF
        IF X1 < 19 THEN
            IF Gcol(X1 + 2, Y) = Gcol(X1, Y) THEN
                IF Gcol(X1 + 1, Y) = Gcol(X1, Y) THEN
                    Cly = Y: Clx = X1 + 2
                    GOSUB Clr
                    Cly = Y: Clx = X1 + 1
                    GOSUB Clr
                    Cly = Y: Clx = X1
                    GOSUB Clr
                END IF
            END IF
        END IF
        IF Y > 2 THEN
            IF Gcol(X1, Y - 1) = Gcol(X1, Y) THEN
                IF Gcol(X1, Y - 2) = Gcol(X1, Y) THEN
                    XFlag = 1
                    Cly = Y - 2: Clx = X1
                    GOSUB Clr
                    Cly = Y - 1: Clx = X1
                    GOSUB Clr
                    Cly = Y: Clx = X1
                    GOSUB Clr
                    GOSUB R3
                END IF
            END IF
        END IF
        IF Y > 1 AND Y < 20 THEN
            IF Gcol(X1, Y - 1) = Gcol(X1, Y) THEN
                IF Gcol(X1, Y + 1) = Gcol(X1, Y) THEN
                    XFlag = 1
                    Cly = Y - 1: Clx = X1
                    GOSUB Clr
                    Cly = Y: Clx = X1
                    GOSUB Clr
                    Cly = Y + 1: Clx = X1
                    GOSUB Clr
                    GOSUB R3
                END IF
            END IF
        END IF
        IF Y < 19 THEN
            IF Gcol(X1, Y + 1) = Gcol(X1, Y) THEN
                IF Gcol(X1, Y + 2) = Gcol(X1, Y) THEN
                    XFlag = 1
                    Cly = Y: Clx = X1
                    GOSUB Clr
                    Cly = Y + 1: Clx = X1
                    GOSUB Clr
                    Cly = Y + 2: Clx = X1
                    GOSUB Clr
                    GOSUB R3
                END IF
            END IF
        END IF
        END IF
    NEXT X1
    XFlag = 1
    FOR Y1 = Y - 1 TO Y + 1
        IF Gcol(X, Y1) <> 0 THEN
        IF Y1 > 2 THEN
            IF Gcol(X, Y1 - 2) = Gcol(X, Y1) THEN
                IF Gcol(X, Y1 - 1) = Gcol(X, Y1) THEN
                    Clx = X: Cly = Y1 - 2
                    GOSUB Clr
                    Clx = X: Cly = Y1 - 1
                    GOSUB Clr
                    Clx = X: Cly = Y1
                    GOSUB Clr
                    GOSUB R3
                END IF
            END IF
        END IF
        IF Y1 > 1 AND Y1 < 20 THEN
            IF Gcol(X, Y1 - 1) = Gcol(X, Y1) THEN
                IF Gcol(X, Y1 + 1) = Gcol(X, Y1) THEN
                    Clx = X: Cly = Y1 - 1
                    GOSUB Clr
                    Clx = X: Cly = Y1
                    GOSUB Clr
                    Clx = X: Cly = Y1 + 1
                    GOSUB Clr
                    GOSUB R3
                END IF
            END IF
        END IF
        IF Y1 < 19 THEN
            IF Gcol(X, Y1 + 2) = Gcol(X, Y1) THEN
                IF Gcol(X, Y1 + 1) = Gcol(X, Y1) THEN
                    Clx = X: Cly = Y1
                    GOSUB Clr
                    Clx = X: Cly = Y1 + 1
                    GOSUB Clr
                    Clx = X: Cly = Y1 + 2
                    GOSUB Clr
                    GOSUB R3
                END IF
            END IF
        END IF
        IF X > 2 THEN
            IF Gcol(X - 1, Y1) = Gcol(X, Y1) THEN
                IF Gcol(X - 2, Y1) = Gcol(X, Y1) THEN
                    XFlag = 0
                    Clx = X - 2: Cly = Y1
                    GOSUB Clr
                    Clx = X - 1: Cly = Y1
                    GOSUB Clr
                    Clx = X: Cly = Y1
                    GOSUB Clr
                END IF
            END IF
        END IF
        IF X > 1 AND X < 20 THEN
            IF Gcol(X - 1, Y1) = Gcol(X, Y1) THEN
                IF Gcol(X + 1, Y1) = Gcol(X, Y1) THEN
                    XFlag = 0
                    Clx = X - 1: Cly = Y1
                    GOSUB Clr
                    Clx = X + 1: Cly = Y1
                    GOSUB Clr
                    Clx = X: Cly = Y1
                    GOSUB Clr
                END IF
            END IF
        END IF
        IF X < 19 THEN
            IF Gcol(X + 1, Y1) = Gcol(X, Y1) THEN
                IF Gcol(X + 2, Y1) = Gcol(X, Y1) THEN
                    XFlag = 0
                    Clx = X + 2: Cly = Y1
                    GOSUB Clr
                    Clx = X + 1: Cly = Y1
                    GOSUB Clr
                    Clx = X: Cly = Y1
                    GOSUB Clr
                END IF
            END IF
        END IF
        END IF
    NEXT Y1
    XFlag = 0
    NEXT Y
NEXT X
X = XS
Y = YS
Colors(1) = INT(3 * RND) + 1
Colors(2) = INT(3 * RND) + 1
Colors(3) = INT(3 * RND) + 1
FOR J = 1 TO Bonus STEP 10
    IF PLAY(0) = 0 AND PlyT = 1 AND SndT = 0 THEN GOSUB Player
    IF SndT = 1 AND PlyT = 0 THEN
        SOUND 30000, 0: SOUND 1000, .2
        SOUND 900, .2
    ELSEIF SndT = 1 THEN
        SOUND 30000, 0: SOUND 1000, .2
        SOUND 30000, 0: SOUND 900, .2
    END IF
    Score& = Score& + 10
    IF Score& > 2000000 THEN Score& = 2000000
    LOCATE 4, 26
    COLOR (INT(7 * RND) + 1)
    PRINT USING " ###,###,### "; Score&
NEXT J
IF Y = 1 THEN
Ender:
    PLAY OFF
    TIMER OFF
    FOR J = 1 TO 50
        IF SndT = 1 AND PlyT = 0 THEN
            SOUND 30000, 0: SOUND 100, .2
            SOUND 50, .2
        ELSEIF SndT = 1 THEN
            SOUND 30000, 0: SOUND 100, .2
            SOUND 30000, 0: SOUND 50, .2
        END IF
    NEXT J
    IF Text = 1 OR NoGr = 1 THEN
        COLOR 3
        LOCATE 6, 22
        PRINT " _                 "
        LOCATE 7, 22
        PRINT "| \  _   \/ _      "
        LOCATE 8, 22
        PRINT "|_/ |_|  | |_| |_| "
        LOCATE 9, 22
        PRINT "                   "
        LOCATE 10, 22
        PRINT "| | | .   _        "
        LOCATE 11, 22
        PRINT "|_|_| | _|  |-|    "
        LOCATE 12, 22
        PRINT "___     _          "
        LOCATE 13, 22
        PRINT " |  _  |_>    _ \/ "
        LOCATE 14, 22
        PRINT " | |_| |  |_ |-| | "
        LOCATE 15, 22
        PRINT " _                 "
        LOCATE 16, 22
        PRINT "|_|  _   _  .      "
        LOCATE 17, 22
        PRINT "| | |_, |-| | |\| ?"
        LOCATE 20, 22
        PRINT "Please press Y or N"
    ELSE
        BigTextEnd SndT, PlyT
    END IF
    DO UNTIL INKEY$ = "": LOOP
    A$ = ""
    DO UNTIL A$ = "Y" OR A$ = "N"
        A$ = UCASE$(INKEY$)
    LOOP
    IF A$ = "Y" THEN GOTO Start
    END
END IF
RETURN

Clr:
IF Cly > 0 AND Clx > 0 THEN
    IF Gcol(Clx, Cly) <> 0 THEN
        COLOR 15
        LOCATE Cly, Clx: PRINT "Û";
        T2@ = TIMER
        DO WHILE T2@ + .2 > TIMER: LOOP
        COLOR 0
        LOCATE Cly, Clx: PRINT "Û"
        Grid(Clx, Cly) = " "
        Gcol(Clx, Cly) = 0
        IF XFlag = 0 THEN
            FOR J = Cly TO 2 STEP -1
                IF PLAY(0) = 0 AND PlyT = 1 AND SndT = 0 THEN GOSUB Player
                IF Cly > 1 AND Clx > 0 THEN
                    Grid(Clx, J) = Grid(Clx, J - 1)
                    Gcol(Clx, J) = Gcol(Clx, J - 1)
                    LOCATE J, Clx
                    COLOR Gcol(Clx, J)
                    IF Grid(Clx, J) = CHR$(219) THEN
                        Plot Gcol(Clx, J), J - 1, Clx
                    ELSE
                        PRINT " ";
                    END IF
                END IF
            NEXT J
            Grid(Clx, 1) = " "
            Gcol(Clx, 1) = 0
        END IF
        LOCATE 1, Clx
        PRINT " ";
        IF SndT = 1 AND PlyT = 0 THEN
            SOUND 30000, 0: SOUND 600, .1
            SOUND 500, .1
        ELSEIF SndT = 1 THEN
            SOUND 30000, 0: SOUND 600, .1
            SOUND 30000, 0: SOUND 500, .1
        END IF
        Score& = Score& + 10
        Bonus = INT(Bonus * 1.2)
        IF Bonus > 16380 THEN Bonus = 16380
        IF Score& > 2000000 THEN Score& = 2000000
        LOCATE 4, 26
        COLOR (INT(7 * RND) + 1)
        PRINT USING " ###,###,### "; Score&
    END IF
END IF
RETURN

R3:
FOR I = 1 TO 3
    IF PLAY(0) = 0 AND PlyT = 1 AND SndT = 0 THEN GOSUB Player
    FOR J = Cly TO 2 STEP -1
        Grid(Clx, J) = Grid(Clx, J - 1)
        Gcol(Clx, J) = Gcol(Clx, J - 1)
        LOCATE J, Clx
        COLOR Gcol(Clx, J)
        IF Grid(Clx, J) = CHR$(219) THEN
            Plot Gcol(Clx, J), J - 1, Clx
        ELSE
            PRINT " ";
        END IF
    NEXT J
    Grid(Clx, 1) = " "
    Gcol(Clx, 1) = 0
NEXT I
RETURN

Plyer2:
    IF PLAY(0) = 0 AND PlyT = 1 THEN GOSUB Player
    RETURN
Player:
    Snder = Snder + 1
    IF Snder > 184 THEN Snder = 1
    PLAY "X" + VARPTR$(A$(Snder))
    RETURN

SUB BigText (Factor, S$, Y, X, C)
    DIM A(8, 8)
    DEF SEG = &HF000
    FOR J = 1 TO LEN(S$)
        C$ = MID$(S$, J, 1)
        FOR Y2 = 0 TO 7
            offset = 8 * ASC(C$) + &HFA6E
            FOR X2 = 8 TO 1 STEP -1
                A(X2, Y2) = ((PEEK(offset + Y2)) AND (2 ^ (X2 - 1))) / (2 ^ (X2 - 1))
                IF A(X2, Y2) <> 0 THEN
                    LINE (X + (X2 + (J - 1) * 8) * Factor, Y + (Y2 * 4))-(X + (X2 + (J - 1) * 8) * Factor + (Factor), Y + (Y2 * 4) + (2 * Factor + 1)), C, BF
                ELSE
                    LINE (X + (X2 + (J - 1) * 8) * Factor, Y + (Y2 * 4))-(X + (X2 + (J - 1) * 8) * Factor + (Factor), Y + (Y2 * 4) + (2 * Factor + 1)), 0, BF
                END IF
            NEXT X2
        NEXT Y2
    NEXT J
END SUB

SUB BigTextEnd (SndT, PlyT)
    COLOR 3
    IF SndT = 1 OR PlyT = 1 THEN PLAY "O1MNMNMBL4GGEAG2E."
    BigText 2, "Do You", 40, 168, 3
    BigText 2, "Wish ", 70, 168, 3
    BigText 2, "To Play", 102, 168, 3
    BigText 2, "Again?", 132, 168, 3
    LOCATE 22, 22
    PRINT "Please press Y or N"
END SUB

SUB Plot (Num, Y, X)
    IF Text = 1 THEN
        LOCATE Y + 1, X
        COLOR Num
        PRINT CHR$(219)
    ELSE
        PUT ((X - 1) * 8, Y * 8), Brick(0, Num), PSET
    END IF
END SUB

