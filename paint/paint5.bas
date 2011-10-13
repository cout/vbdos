DEFINT A-Z
'$INCLUDE: 'MOUSE.BI'
'$DYNAMIC
DIM Undo(32000)
STACK 512

Com$ = UCASE$(COMMAND$)
re:
a = 0
IF INSTR(Com$, "MCGA") THEN GOTO MCGA
IF INSTR(Com$, "EGA") THEN GOTO EGA
IF INSTR(Com$, "CGA2") THEN GOTO CGA2
IF INSTR(Com$, "CGA") THEN GOTO CGA

MCGA:
ON ERROR GOTO EGA
SCREEN 13
MaxX = 319
MaxY = 199
MaxC = 255
GOTO Start

EGA:
ON ERROR GOTO CGA
SCREEN 7
MaxX = 319
MaxY = 199
MaxC = 15
GOTO Start

CGA2:
SCREEN 2
MaxX = 319
MaxY = 199
MaxC = 1
WINDOW SCREEN (0, 0)-(319, 199)
WIDTH 40
GOTO Start

CGA:
ON ERROR GOTO Mono
SCREEN 1
MaxX = 319
MaxY = 199
MaxC = 3
GOTO Start

Mono:
PRINT "Your graphics adapter is not"
PRINT "supported by Fast Paint."
PRINT
PRINT "Hercules users can get CGA"
PRINT "graphics by using an emulation"
PRINT "program. "
RESUME Ender
Ender:
END

NoMouse:
    PRINT "No mouse is installed..."
    NoMouse = 1
    PAINT (160, 0), 15 MOD (MaxC + 1)
    RESUME Start3:
Start:
IF ERR THEN RESUME Start2
Start2:

ON ERROR GOTO 0

PAINT (160, 0), 15 MOD (MaxC + 1)

ON ERROR GOTO NoMouse
MouseInit

Start3:
ON ERROR GOTO 0
IF a = 1 THEN
    CLS
    PAINT (160, 0), 15 MOD (MaxC + 1)
END IF
a = 1

LOCATE 1, 1: PRINT "File³Edit³Picture³Options³Help       "
LINE (0, 8)-(MaxX, 8)

SELECT CASE MaxC
    CASE 255
        X2 = 4: Y2 = 63
        X = 3: Y = 3
    CASE 15
        X2 = 1: Y2 = 15
        X = 12: Y = 12
    CASE 3
        X2 = 1: Y2 = 3
        X = 12: Y = 48
    CASE 1
        X2 = 1: Y2 = 1
        X = 12: Y = 96
END SELECT
WINDOW SCREEN (0, 0)-(MaxX, 199)
LINE (283, 0)-(MaxX, MaxY), 3 MOD (MaxC + 1), BF
LINE (0, MaxY - 1)-(MaxX, MaxY), 3 MOD (MaxC + 1), BF
FOR J = 0 TO Y2
    FOR I = 1 TO X2
        Xa = MaxX - ((I - 1) * X)
        Xb = MaxX - (X - 1) - ((I - 1) * X)
        Ya = (J * Y)
        Yb = Y + (J * Y)
        LINE (Xa, Ya)-(Xb, Yb), (J * X2) + I - 1, BF
    NEXT I
NEXT J
WINDOW
LINE (MaxX - 12, MaxY)-(MaxX, MaxY - 5), 0, BF
WINDOW SCREEN (0, 0)-(319, 199)
FOR J = 1 TO 10
    LINE (285, J * 20 - 20)-(305, J * 20 - 2), 7 MOD (MaxC + 1), BF
    LINE (285, J * 20 - 20)-(285, J * 20 - 2), 8 MOD (MaxC + 1)
    LINE (285, J * 20 - 2)-(305, J * 20 - 2), 15 MOD (MaxC + 1)
    LINE (305, J * 20 - 2)-(305, J * 20 - 20), 15 MOD (MaxC + 1)
    LINE (285, J * 20 - 20)-(305, J * 20 - 20), 8 MOD (MaxC + 1)
NEXT J
PSET (295, 10), 0
LINE (301, 23)-(289, 35), 0
CIRCLE (295, 50), 7, 0
LINE (288, 63)-(302, 75), 0, B
CIRCLE (295, 90), 7, 0
PAINT (295, 90), 0, 0
LINE (288, 103)-(302, 115), 0, BF
LINE (288, 128)-(302, 135), 0, B
CIRCLE (295, 128), 7, 0, 0, 2 * 1.571
LINE (290, 145)-(300, 155), 0, B
LINE (295, 145)-(295, 143), 0
LINE (295, 143)-(294, 143), 0
LINE (295, 170)-(295, 165), 0
LINE (295, 170)-(292, 167), 0
LINE (295, 170)-(298, 176), 0
LINE (295, 170)-(296, 176), 0
LOCATE 24, 37: PRINT "U";
GET (288, 184)-(295, 191), Undo
PAINT (289, 185), 7, 7
PUT (292, 186), Undo, OR

WINDOW

LINE (276, 0)-(282, MaxY - 6), 7 MOD (MaxC + 1), BF
LINE (276, 0)-(276, MaxY - 6), 8 MOD (MaxC + 1)
LINE (282, 0)-(282, MaxY - 6), 15 MOD (MaxC + 1)
LINE (276, MaxY - 6)-(282, MaxY - 6), 15 MOD (MaxC + 1)
LINE (276, 0)-(282, 0), 8 MOD (MaxC + 1)

LINE (0, MaxY - 6)-(276, MaxY - 2), 7 MOD (MaxC + 1), BF
LINE (0, MaxY - 6)-(0, MaxY - 2), 8 MOD (MaxC + 1)
LINE (1, MaxY - 2)-(276, MaxY - 2), 15 MOD (MaxC + 1)
LINE (276, MaxY - 6)-(276, MaxY - 2), 15 MOD (MaxC + 1)
LINE (0, MaxY - 6)-(276, MaxY - 6), 8 MOD (MaxC + 1)

LINE (277, MaxY - 5)-(281, MaxY - 3), 7 MOD (MaxC + 1), BF
LINE (277, MaxY - 5)-(281, MaxY - 3), 8 MOD (MaxC + 1), B

LINE (283, 10 + (20 * Tool))-(284, 10 + (20 * Tool)), 4 MOD (MaxC + 1)
LINE (306, 10 + (20 * Tool))-(307, 10 + (20 * Tool)), 4 MOD (MaxC + 1)

GET (0, 8)-(275, 192), Undo
MouseShow

WINDOW SCREEN (0, 0)-(319, 199)

altx$ = CHR$(0) + CHR$(45)

DO
    MousePoll row, col, lButton, rButton
    IF lButton <> 0 THEN
        IF col > 307 THEN
            MouseHide
            Colr = POINT(col, row)
            LINE (MaxX - 11, MaxY - 1)-(MaxX - 1, MaxY - 4), Colr, BF
            MouseShow
        ELSEIF col > 284 THEN
            MouseHide
            LINE (283, 10 + (20 * Tool))-(284, 10 + (20 * Tool)), 3 MOD (MaxC + 1)
            LINE (306, 10 + (20 * Tool))-(307, 10 + (20 * Tool)), 3 MOD (MaxC + 1)
            ot = Tool
            Tool = INT(row / ((MaxY + 1) / 10))
            IF Tool = 9 THEN
                PUT (0, 8), Undo, PSET
                Tool = ot
            END IF
            LINE (283, 10 + (20 * Tool))-(284, 10 + (20 * Tool)), 4 MOD (MaxC + 1)
            LINE (306, 10 + (20 * Tool))-(307, 10 + (20 * Tool)), 4 MOD (MaxC + 1)
            MouseShow
        ELSE
            MouseHide
            VIEW SCREEN (0, 8)-(275, 192)
            MaxXs = MaxX: MaxYs = MaxY
            IF col < 276 AND row < 193 AND row > 8 THEN
                GET (0, 8)-(275, 192), Undo
                SELECT CASE Tool
                    CASE 1
                        PSET (row, col), Colr
                        MouseBorder 9, 0, 192, 275
                        orow = row: ocol = col
                        WHILE lButton <> 0
                            MousePoll row, col, lButton, rButton
                            IF row <> or2 OR col <> oc2 THEN
                                PUT (0, 8), Undo, PSET
                                LINE (ocol, orow)-(col, row), Colr
                            END IF
                            oc2 = col: or2 = row
                        WEND
                        MouseBorder 0, 0, MaxY, MaxX
                    CASE 2
                        PSET (row, col), Colr
                        MouseBorder 9, 0, 192, 275
                        orow = row: ocol = col
                        WHILE lButton <> 0
                            MousePoll row, col, lButton, rButton
                            IF row <> or2 OR col <> oc2 THEN
                                PUT (0, 8), Undo, PSET
                                CIRCLE (ocol, orow), ABS((ocol + orow) - (col + row)) / 2, Colr
                            END IF
                            oc2 = col: or2 = row
                        WEND
                        MouseBorder 0, 0, MaxY, MaxX
                    CASE 3
                        PSET (row, col), Colr
                        MouseBorder 9, 0, 192, 275
                        orow = row: ocol = col
                        WHILE lButton <> 0
                            MousePoll row, col, lButton, rButton
                            IF row <> or2 OR col <> oc2 THEN
                                PUT (0, 8), Undo, PSET
                                LINE (ocol, orow)-(col, row), Colr, B
                            END IF
                            oc2 = col: or2 = row
                        WEND
                        MouseBorder 0, 0, MaxY, MaxX
                    CASE 4
                        PSET (row, col), Colr
                        MouseBorder 9, 0, 192, 275
                        orow = row: ocol = col
                        WHILE lButton <> 0
                            MousePoll row, col, lButton, rButton
                            IF row <> or2 OR col <> oc2 THEN
                                PUT (0, 8), Undo, PSET
                                CIRCLE (ocol, orow), ABS((ocol + orow) - (col + row)) / 2, Colr
                            END IF
                            oc2 = col: or2 = row
                        WEND
                        MouseBorder 0, 0, MaxY, MaxX
                        PAINT (ocol, orow), Colr, Colr
                    CASE 5
                        PSET (row, col), Colr
                        MouseBorder 9, 0, 192, 275
                        orow = row: ocol = col
                        WHILE lButton <> 0
                            MousePoll row, col, lButton, rButton
                            IF row <> or2 OR col <> oc2 THEN
                                PUT (0, 8), Undo, PSET
                                LINE (ocol, orow)-(col, row), Colr, B
                            END IF
                            oc2 = col: or2 = row
                        WEND
                        LINE (ocol, orow)-(col, row), Colr, BF
                        MouseBorder 0, 0, MaxY, MaxX
                    CASE 6
                        LINE (0, 8)-(275, 192), Colr, B
                        PAINT (col, row), Colr, Colr
                        LINE (0, 8)-(275, 192), 15, B
                    CASE 7
                        PSET (col, row), Colr
                        MouseBorder 9, 0, 192, 275
                        WHILE lButton <> 0
                            MousePoll row, col, lButton, rButton
                            PSET (col + 4 - 8 * RND, row + 4 * 8 - RND - 30), Colr
                            T@ = TIMER
                            DO UNTIL TIMER - T@ > .005: LOOP
                        WEND
                        MouseBorder 0, 0, MaxY, MaxX
                    CASE 8
                        PSET (row, col), Colr
                        MouseBorder 9, 0, 192, 275
                        orow = row: ocol = col
                        WHILE rButton = 0
                            MousePoll row, col, lButton, rButton
                            IF lButton <> 0 THEN
                                MouseHide
                                WHILE lButton <> 0
                                    MousePoll row, col, lButton, rButton
                                    LINE (ocol, orow)-(col, row), Colr
                                    oc2 = col: or2 = row
                                WEND
                                MouseShow
                            END IF
                        WEND
                        DO UNTIL rButton = 0
                            MousePoll row, col, lButton, rButton
                        LOOP
                        MouseBorder 0, 0, MaxY, MaxX
                    CASE 9
                        PUT (0, 8), Undo
                    CASE ELSE
                        PSET (col, row), Colr
                        MouseBorder 9, 0, 192, 275
                        WHILE lButton <> 0
                            MousePoll row, col, lButton, rButton
                            LINE -(col, row), Colr
                            PSET (col, row), 0
                            PSET (col, row), Colr
                        WEND
                        MouseBorder 0, 0, MaxY, MaxX
                END SELECT
            END IF
            MouseShow
            MaxX = MaxXs: MaxY = MaxYs
            VIEW SCREEN (0, 0)-(319, 199)
        END IF
    END IF
    IF row < 8 AND lButton <> 0 THEN
        MouseHide
        GET (0, 8)-(272, 192), Undo
        MouseShow
        SELECT CASE col
            CASE 0 TO 36
                MouseHide
                LOCATE 2, 1: PRINT "New ³"
                LOCATE 3, 1: PRINT "Open³"
                LOCATE 4, 1: PRINT "Load³"
                LOCATE 5, 1: PRINT "Save³"
                LOCATE 6, 1: PRINT "Exit³"
                LOCATE 7, 1: PRINT "ÄÄÄÄÙ"
                MouseShow
                DO
                    MousePoll row, col, lButton, rButton
                LOOP WHILE lButton = 0
                IF col <= 32 THEN
                    SELECT CASE row
                        CASE 8 TO 15
                            MouseHide
                            GOTO Start3
                        CASE 16 TO 23: PUT (0, 8), Undo, PSET
                        CASE 24 TO 31: PUT (0, 8), Undo, PSET
                        CASE 32 TO 39
                            MouseHide
                            PUT (0, 8), Undo, PSET
                            C$ = CHR$(193)
                            OPEN "PCX.PCX" FOR BINARY AS #1
                            RESTORE PCX
                            FOR J = 1 TO 128
                                READ a$
                                a = VAL("&h" + a$)
                                b$ = CHR$(a)
                                PUT #1, , b$
                            NEXT
                            FOR Y = 8 TO 192
                                FOR X = 0 TO 275
                                    a = POINT(X, Y)
                                    b$ = CHR$(a)
                                    IF a AND 192 <> 192 THEN
                                        PUT #1, , b$
                                    ELSE
                                        PUT #1, , C$
                                        PUT #1, , b$
                                    END IF
                                NEXT X
                                b$ = CHR$(0)
                                FOR X = 276 TO 319
                                    PUT #1, , b$
                                NEXT X
                            NEXT Y
                            FOR J = 1 TO 5120
                                PUT #1, , b$
                            NEXT J
                            OUT &H3C8, 0
                            FOR J = 1 TO 768
                                a = INP(&H3C9)
                                b$ = CHR$(a)
                                PUT #1, , b$
                            NEXT J
                        MouseShow
                        CASE 40 TO 47: END
                        CASE ELSE
                            MouseHide
                            PUT (0, 8), Undo, PSET
                            MouseShow
                    END SELECT
                ELSE
                    MouseHide
                    PUT (0, 8), Undo, PSET
                    MouseShow
                END IF
            CASE 37 TO 77
                MouseHide
                LOCATE 2, 5: PRINT "³Get ³"
                LOCATE 3, 5: PRINT "³Copy³"
                LOCATE 4, 5: PRINT "³Move³"
                LOCATE 5, 5: PRINT "³Del ³"
                LOCATE 6, 5: PRINT "ÀÄÄÄÄÙ"
                MouseShow
                DO
                    MousePoll row, col, lButton, rButton
                LOOP WHILE lButton = 0
                IF col > 32 AND col <= 72 THEN
                    MouseHide
                    SELECT CASE row
                        CASE 8 TO 15: PUT (0, 8), Undo, PSET
                        CASE 16 TO 23: PUT (0, 8), Undo, PSET
                        CASE 24 TO 31: PUT (0, 8), Undo, PSET
                        CASE 32 TO 39: PUT (0, 8), Undo, PSET
                        CASE ELSE
                            MouseHide
                            PUT (0, 8), Undo, PSET
                            MouseShow
                    END SELECT
                    MouseShow
                ELSE
                    MouseHide
                    PUT (0, 8), Undo, PSET
                    MouseShow
                END IF
            CASE 78 TO 142
                MouseHide
                LOCATE 2, 5: PRINT "³Get ³"
                LOCATE 3, 5: PRINT "³Copy³"
                LOCATE 4, 5: PRINT "³Move³"
                LOCATE 5, 5: PRINT "³Del ³"
                LOCATE 6, 5: PRINT "ÀÄÄÄÄÙ"
                MouseShow
                DO
                    MousePoll row, col, lButton, rButton
                LOOP WHILE lButton = 0
                IF col > 32 AND col <= 72 THEN
                    MouseHide
                    SELECT CASE row
                        CASE 8 TO 15: PUT (0, 8), Undo, PSET
                        CASE 16 TO 23: PUT (0, 8), Undo, PSET
                        CASE 24 TO 31: PUT (0, 8), Undo, PSET
                        CASE 32 TO 39: PUT (0, 8), Undo, PSET
                        CASE ELSE
                            MouseHide
                            PUT (0, 8), Undo, PSET
                            MouseShow
                    END SELECT
                    MouseShow
                ELSE
                    MouseHide
                    PUT (0, 8), Undo, PSET
                    MouseShow
                END IF
            CASE 143 TO 201
                MouseHide
                LOCATE 2, 18: PRINT "³Colors ³"
                LOCATE 3, 18: PRINT "ÃÄÄÄÄÄÄÄ´"
                LOCATE 4, 18: PRINT "³  -1-  ³"
                LOCATE 5, 18: PRINT "³  -4-  ³"
                LOCATE 6, 18: PRINT "³ -016- ³"
                LOCATE 7, 18: PRINT "³ -256- ³"
                LOCATE 8, 18: PRINT "ÀÄÄÄÄÄÄÄÙ"
                
                MouseShow
                DO
                    MousePoll row, col, lButton, rButton
                LOOP WHILE lButton = 0
                IF col >= 136 AND col <= 208 THEN
                    SELECT CASE row
                        CASE 24 TO 31: Com$ = "CGA2": GOTO re
                        CASE 32 TO 39: Com$ = "CGA": GOTO re
                        CASE 40 TO 47: Com$ = "EGA": GOTO re
                        CASE 48 TO 55: Com$ = "MCGA": GOTO re
                        CASE ELSE
                            MouseHide
                            PUT (0, 8), Undo, PSET
                            MouseShow
                    END SELECT
                ELSE
                    MouseHide
                    PUT (0, 8), Undo, PSET
                    MouseShow
                END IF
            CASE 203 TO 240
        END SELECT
    END IF
LOOP WHILE rButton = 0 OR INKEY$ = altx$
END

PCX:
DATA A,5,1,8,0,0,0,0,3F,1,C7,0,20,3,58,2,A,0,7,0,D,0
DATA 8,0,C,0,C,0,D,0,6,0,6,0,9,0,C,0,C,0,9,0,C,0,C,0
DATA C,0,C,0,C,0,C,0,D,0,6,0,9,0,9,0,4,0,0,1,40,1,1,0,20
DATA 3,58,2,8,0,3,0,4,0,4,0,8,0,7,0,3,0,7,0,3,0,6,0
DATA 7,0,7,0,7,0,7,0,7,0,7,0,7,0,7,0,7,0,7,0,3,0
DATA 3,0,6,0,6,0,6,0,0,0,0,0

