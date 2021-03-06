DEFINT A-Z
DIM F(3, 2) AS STRING * 2, p(3, 2) AS STRING * 2
DIM k(3, 2) AS STRING * 2, FG(16 * 25, 2)
DIM FG2(16 * 25, 2)
DIM PG(16 * 25, 2), PG2(16 * 25, 2)
DIM KG(16 * 25, 2), KG2(16 * 25, 2)
DIM HG(16 * 25, 2), HG2(16 * 25, 2)
DIM JG(16 * 25, 2), JG2(16 * 25, 2)
DIM BG(20 * 25, 2), BG2(20 * 25, 2)
DIM FXG(20 * 25, 2), FXG2(20 * 25, 2)
DIM IG(30, 2), IG2(30, 2)
DIM Title(1000), T2(1000)
DIM Fence(212)

Com$ = UCASE$(COMMAND$)
IF INSTR(Com$, "CGA") THEN GOTO CGA
IF INSTR(Com$, "XEGA") THEN GOTO XEGA
IF INSTR(Com$, "EGA") THEN GOTO EGA
IF INSTR(Com$, "VGA") THEN GOTO VGA

ON KEY(5) GOSUB NTSet
KEY(5) ON

VGA:
ON ERROR GOTO EGA
SCREEN 13
MaxColor = 255
GOTO GAME

XEGA:
ON ERROR GOTO EGA
SCREEN 7
MaxColor = 16
GOTO GAME

EGA:
ON ERROR GOTO CGA
SCREEN 7
MaxColor = 15
GOTO GAME

CGA:
ON ERROR GOTO Quit
SCREEN 1
MaxColor = 3
GOTO GAME

Quit:
PRINT "Error!"
END
GOTO Quit

GAME:

IF INSTR(Com$, "NT") OR INSTR(Com$, "NOTITLE") THEN NT = 1
IF INSTR(Com$, "COM1") THEN Com1 = 1
IF INSTR(Com$, "COM2") THEN Com2 = 1

ON ERROR GOTO 0

IF NT <> 1 THEN
    ON PLAY(1) GOSUB TitleMusic
    PLAY ON
    PLAY "L16MBO0CCDCECFG"
END IF

FOR Y = 1 TO 20
    FOR X = 1 TO 16
        READ A$
        IF NT <> 1 THEN
            A = VAL("&H" + A$)
            IF A <> 0 AND A MOD (MaxColor + 1) = 0 THEN A = A + 1
            PSET (142 + X, Y + 36), A MOD (MaxColor + 1)
            IF MaxColor > 5 THEN COLOR Y * X MOD MaxColor
            LOCATE 6, 21: PRINT "UNK"
        END IF
    NEXT X
NEXT Y
    IF MaxColor > 5 THEN COLOR 15
    LOCATE 1, 1
    FOR Y = 1 TO 19
        FOR X = 1 TO 16
            READ A$
            IF NT <> 1 THEN
                A = VAL("&H" + A$)
                IF A <> 0 AND A MOD MaxColor = 0 THEN A = A + 1
                PSET (144 + X, 148 + Y), A MOD MaxColor
            END IF
        NEXT X
    NEXT Y
    PRINT "IGHTER";
    LOCATE 2, 1: PRINT "v. 3.0"
    GET (0, 0)-(55, 7), Title(0)
    PUT (0, 0), Title(0), XOR
    C = 5
    IF MaxColor < 6 THEN C = 2
    LINE (146, 156)-(210, 156), C
    PUT (160, 152), Title(0), OR

T@ = TIMER
FOR Y = 1 TO 23
    FOR X = 1 TO 16
        READ A$
        A = VAL("&H" + A$)
        PSET (128 + X, Y + 76), A MOD MaxColor
        PSET (128 + 80 - X, Y + 76), A MOD MaxColor
        IF A = 0 THEN A = -1
        PSET (128 + X, Y + 25 + 76), (A MOD MaxColor) + 1
        PSET (128 + 80 - X, 76 + Y + 25), (A MOD MaxColor) + 1
    NEXT X
NEXT Y
GET (129, 77)-(128 + 16, 76 + 23), FG(0, 1)
GET (128 + 80, 77)-(128 + 80 - 16, 76 + 23), FG(0, 2)
GET (129, 76 + 26)-(128 + 16, 76 + 48), FG2(0, 1)
GET (128 + 80, 76 + 26)-(128 + 80 - 16, 76 + 48), FG2(0, 2)
IF NT <> 1 THEN DO UNTIL T@ + 1 < TIMER: LOOP

T@ = TIMER
FOR Y = 1 TO 23
    FOR X = 1 TO 16
        READ A$
        A = VAL("&H" + A$)
        PSET (128 + X, Y + 76), A MOD MaxColor
        PSET (128 + 80 - X, Y + 76), A MOD MaxColor
        IF A = 0 THEN A = -1
        PSET (128 + X, Y + 25 + 76), (A MOD MaxColor) + 1
        PSET (128 + 80 - X, 76 + Y + 25), (A MOD MaxColor) + 1
    NEXT X
NEXT Y
GET (129, 77)-(128 + 16, 76 + 23), PG(0, 1)
GET (128 + 80, 77)-(128 + 80 - 16, 76 + 23), PG(0, 2)
GET (129, 76 + 26)-(128 + 16, 76 + 48), PG2(0, 1)
GET (128 + 80, 76 + 26)-(128 + 80 - 16, 76 + 48), PG2(0, 2)
IF NT <> 1 THEN DO UNTIL T@ + 1 < TIMER: LOOP

T@ = TIMER
FOR Y = 1 TO 23
    FOR X = 1 TO 16
        READ A$
        A = VAL("&H" + A$)
        PSET (128 + X, Y + 76), A MOD MaxColor
        PSET (128 + 80 - X, Y + 76), A MOD MaxColor
        IF A = 0 THEN A = -1
        PSET (128 + X, Y + 25 + 76), (A MOD MaxColor) + 1
        PSET (128 + 80 - X, 76 + Y + 25), (A MOD MaxColor) + 1
    NEXT X
NEXT Y
GET (129, 77)-(128 + 16, 76 + 23), KG(0, 1)
GET (128 + 80, 77)-(128 + 80 - 16, 76 + 23), KG(0, 2)
GET (129, 76 + 26)-(128 + 16, 76 + 48), KG2(0, 1)
GET (128 + 80, 76 + 26)-(128 + 80 - 16, 76 + 48), KG2(0, 2)
IF NT <> 1 THEN DO UNTIL T@ + 1 < TIMER: LOOP

T@ = TIMER
FOR Y = 1 TO 23
    FOR X = 1 TO 16
        READ A$
        A = VAL("&H" + A$)
        PSET (128 + X, Y + 76), A MOD MaxColor
        PSET (128 + 80 - X, Y + 76), A MOD MaxColor
        IF A = 0 THEN A = -1
        PSET (128 + X, Y + 25 + 76), (A MOD MaxColor) + 1
        PSET (128 + 80 - X, 76 + Y + 25), (A MOD MaxColor) + 1
    NEXT X
NEXT Y
GET (129, 77)-(128 + 16, 76 + 23), JG(0, 1)
GET (128 + 80, 77)-(128 + 80 - 16, 76 + 23), JG(0, 2)
GET (129, 76 + 26)-(128 + 16, 76 + 48), JG2(0, 1)
GET (128 + 80, 76 + 26)-(128 + 80 - 16, 76 + 48), JG2(0, 2)
IF NT <> 1 THEN DO UNTIL T@ + 1 < TIMER: LOOP

RESTORE Fire
T@ = TIMER
FOR Y = 1 TO 23
    FOR X = 1 TO 16
        READ A$
        A = VAL("&H" + A$)
        PSET (128 + X, Y + 76), A MOD MaxColor
        PSET (128 + 80 - X, Y + 76), A MOD MaxColor
        IF A = 0 THEN A = -1
        PSET (128 + X, Y + 25 + 76), (A MOD MaxColor) + 1
        PSET (128 + 80 - X, 76 + Y + 25), (A MOD MaxColor) + 1
    NEXT X
NEXT Y
GET (129, 77)-(128 + 16, 76 + 23), FXG(0, 1)
GET (128 + 80, 77)-(128 + 80 - 16, 76 + 23), FXG(0, 2)
GET (129, 76 + 26)-(128 + 16, 76 + 48), FXG2(0, 1)
GET (128 + 80, 76 + 26)-(128 + 80 - 16, 76 + 48), FXG2(0, 2)
IF NT <> 1 THEN DO UNTIL T@ + 1 < TIMER: LOOP
T@ = TIMER

RESTORE Iced
T@ = TIMER
F = 9
FOR Y = 1 TO 5
    FOR X = 1 TO 5
        READ A$
        A = VAL("&H" + A$)
        PSET (120 + X, Y + 76 + F), A MOD MaxColor
        PSET (120 + 96 - X, Y + 76 + F), A MOD MaxColor
        IF A = 0 THEN A = -1
        PSET (120 + X, Y + 25 + 76 + F), (A MOD MaxColor) + 1
        PSET (120 + 96 - X, 76 + Y + 25 + F), (A MOD MaxColor) + 1
    NEXT X
NEXT Y
GET (121, 77 + F)-(126, 81 + F), IG(0, 1)
GET (211, 77 + F)-(215, 81 + F), IG(0, 2)
GET (121, 102 + F)-(126, 107 + F), IG2(0, 1)
GET (211, 102 + F)-(215, 107 + F), IG2(0, 2)
PUT (121, 77 + F), IG(0, 1)
PUT (211, 77 + F), IG(0, 2)
PUT (121, 102 + F), IG2(0, 1)
PUT (211, 102 + F), IG2(0, 2)
IF NT <> 1 THEN DO UNTIL T@ + 1 < TIMER: LOOP
T@ = TIMER

RESTORE Block
FOR Y = 1 TO 23
    FOR X = 1 TO 20
        READ A$
        A = VAL("&H" + A$)
        PSET (128 + X, Y + 76), A MOD MaxColor
        PSET (128 + 80 - X, Y + 76), A MOD MaxColor
        IF A = 0 THEN A = -1
        PSET (128 + X, Y + 25 + 76), (A MOD MaxColor) + 1
        PSET (128 + 80 - X, 76 + Y + 25), (A MOD MaxColor) + 1
    NEXT X
NEXT Y
GET (129, 77)-(128 + 20, 76 + 23), BG(0, 1)
GET (128 + 80, 77)-(128 + 80 - 20, 76 + 23), BG(0, 2)
GET (129, 76 + 26)-(128 + 20, 76 + 48), BG2(0, 1)
GET (128 + 80, 76 + 26)-(128 + 80 - 20, 76 + 48), BG2(0, 2)
DO UNTIL T@ + 1 < TIMER: LOOP

LINE (129, 77)-(128 + 80, 143), 0, BF

PUT (129, 77), FG(0, 1)
PUT (192, 77), FG(0, 2)
PUT (128, 102), FG2(0, 1)
PUT (192, 102), FG2(0, 2)

T@ = TIMER
FOR Y = 1 TO 23
    FOR X = 1 TO 16
        READ A$
        A = VAL("&H" + A$)
        PSET (128 + X, Y + 76), A MOD MaxColor
        PSET (128 + 80 - X, Y + 76), A MOD MaxColor
        IF A = 0 THEN A = -1
        PSET (128 + X, Y + 25 + 76), (A MOD MaxColor) + 1
        PSET (128 + 80 - X, 76 + Y + 25), (A MOD MaxColor) + 1
    NEXT X
NEXT Y
GET (129, 77)-(128 + 16, 76 + 23), HG(0, 1)
GET (128 + 80, 77)-(128 + 80 - 16, 76 + 23), HG(0, 2)
GET (129, 76 + 26)-(128 + 16, 76 + 48), HG2(0, 1)
GET (128 + 80, 76 + 26)-(128 + 80 - 16, 76 + 48), HG2(0, 2)
IF NT <> 1 THEN DO UNTIL T@ + 1 < TIMER: LOOP

LINE (129, 77)-(128 + 80, 143), 0, BF

IF NT <> 1 THEN
    GET (143, 37)-(192, 56), T2
    GET (140, 149)-(207, 167), Title
    FOR J = 141 TO 200
        PUT (J - 1, 149), Title, XOR
        PUT (J, 149), Title, XOR
    NEXT J
    FOR J = 38 TO 149
        PUT (143, J - 1), T2, XOR
        PUT (143, J), T2, XOR
    NEXT J
    LOCATE 23, 20: PRINT "by Paul Brannan"
END IF

RESTORE Fence
FOR Y = 1 TO 13
    FOR X = 1 TO 16
        READ A$
        A = VAL("&H" + A$)
        PSET (X, Y + 128), A MOD MaxColor
    NEXT X
NEXT Y
GET (0, 128)-(16, 141), Fence
PUT (0, 128), Fence

DATA 0,7,7,7,0,0,7,0,0,0,7,0,0,0,0,0
DATA 7,F,F,F,7,0,F,0,F,F,7,7,0,7,0,0
DATA F,F,F,7,F,0,F,7,0,0,0,7,F,0,0,0
DATA 7,0,0,F,7,F,7,0,0,0,7,F,0,0,0,0
DATA 0,0,0,7,7,0,7,0,0,0,7,7,0,0,0,0
DATA 0,0,0,7,8,0,8,0,0,0,8,7,0,0,0,0
DATA 0,0,7,8,7,0,7,8,7,8,7,8,0,0,0,0
DATA 0,8,8,8,8,0,0,0,0,0,8,8,0,0,0,0
DATA 0,8,0,8,0,0,0,0,0,0,6,8,0,0,0,0
DATA 0,6,0,6,8,0,8,6,8,6,8,6,0,0,0,0
DATA 0,0,0,6,6,0,6,0,0,0,6,6,0,0,0,0
DATA 0,0,0,6,4,0,4,0,0,0,4,6,0,0,0,0
DATA 0,0,0,4,6,0,6,0,0,0,6,4,0,0,0,0
DATA 0,4,4,4,4,0,4,4,4,4,4,4,4,0,0,0
DATA 0,C,0,C,4,0,4,C,4,0,0,0,0,0,0,0
DATA C,0,0,4,C,0,C,0,0,0,0,0,0,0,0,0
DATA 0,0,0,C,C,0,C,0,0,0,0,0,0,0,0,0
DATA 0,0,0,C,C,0,C,0,0,0,0,0,0,0,0,0
DATA 0,0,0,C,C,C,C,0,0,0,0,0,0,0,0,0
DATA 0,0,C,C,0,0,C,0,0,0,0,0,0,0,0,0

DATA 0,0,0,0,9,9,9,0,0,9,0,0,0,9,0,9
DATA 0,0,0,9,0,7,7,9,9,0,0,9,9,9,9,0
DATA 0,0,0,9,0,0,0,0,0,9,9,0,9,0,0,0
DATA 0,0,0,9,0,0,0,9,0,7,9,0,9,0,0,0
DATA 0,0,0,0,0,0,9,9,0,7,9,0,9,0,0,0
DATA 0,0,0,0,0,0,7,9,0,7,9,0,9,0,0,0
DATA 0,0,0,0,0,9,7,9,0,7,7,9,9,9,0,0
DATA 0,0,0,0,9,7,7,9,0,7,7,7,9,0,0,0
DATA 0,0,0,0,7,0,7,9,0,7,9,0,9,0,0,0
DATA 0,0,0,0,0,0,7,9,0,7,9,0,9,0,0,0
DATA 0,0,0,0,0,0,7,9,0,7,9,0,9,0,0,0
DATA 0,0,0,9,9,0,9,0,0,7,9,0,9,0,0,0
DATA 0,9,9,7,7,9,0,0,0,7,9,0,9,0,0,0
DATA 0,9,0,0,7,7,9,0,0,9,0,0,9,0,0,0
DATA 9,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0
DATA 9,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0
DATA 7,9,0,0,0,0,0,0,0,0,0,0,9,0,0,0
DATA 0,7,9,0,0,0,0,0,0,0,0,0,9,0,0,0
DATA 0,0,7,9,9,0,0,0,0,0,0,9,0,0,0,0

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,4,4,4,4,4,4,4,0,0
DATA 0,0,0,0,0,0,0,0,4,4,4,4,4,4,0,0
DATA 0,0,0,0,0,0,0,0,43,43,42,8,42,42,0,0
DATA 0,0,0,0,0,0,0,43,43,7B,43,43,8,42,0,0
DATA 0,0,0,0,0,0,0,0,43,43,43,8,43,42,0,0
DATA 0,0,0,0,0,0,0,0,4,43,43,43,43,0,0,0
DATA 0,0,0,0,0,0,0,0,8,8,8,8,8,0,0,0
DATA 0,0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,0,0
DATA 0,0,0,43,0,0,7B,7B,43,43,42,43,7B,7B,7B,0
DATA 0,0,43,43,42,7A,43,43,43,42,43,43,43,7B,7B,0
DATA 0,0,42,43,43,43,43,43,43,43,42,43,7B,7B,7B,0
DATA 0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,7B,7B,0
DATA 0,0,0,0,0,43,43,7B,7B,7B,7B,7B,7B,7B,0,0
DATA 0,0,0,0,0,43,43,8,8,8,8,8,8,8,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,8,0,8,8,1,0,0
DATA 0,0,0,0,0,0,8,8,8,8,0,8,8,8,8,0

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,4,4,4,4,4,4,4,0,0
DATA 0,0,0,0,0,0,0,0,4,4,4,4,4,4,0,0
DATA 0,0,0,0,0,0,0,0,43,43,42,8,42,42,0,0
DATA 0,0,0,0,0,0,0,43,43,7B,43,43,8,42,0,0
DATA 0,0,0,0,0,0,0,0,43,43,43,8,43,42,0,0
DATA 0,0,0,0,0,0,0,0,4,43,43,43,43,0,0,0
DATA 0,43,0,0,0,0,0,0,8,8,8,8,8,0,0,0
DATA 43,43,42,42,43,43,43,7B,7B,7B,7B,7B,7B,7B,0,0
DATA 42,43,42,43,42,43,7B,7B,43,43,42,43,7B,7B,7B,0
DATA 0,0,43,43,42,7A,43,43,43,42,43,43,43,7B,7B,0
DATA 0,0,42,43,43,43,43,43,43,43,42,43,7B,7B,7B,0
DATA 0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,7B,7B,0
DATA 0,0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,0,0
DATA 0,0,0,0,0,0,0,8,8,8,8,8,8,8,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,8,0,8,8,1,0,0
DATA 0,0,0,0,0,0,8,8,8,8,0,8,8,8,8,0

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,4,4,4,4,4,4,4,0,0
DATA 0,0,0,0,0,0,0,0,4,4,4,4,4,4,0,0
DATA 0,0,0,0,0,0,0,0,43,43,42,8,42,42,0,0
DATA 0,0,0,0,0,0,0,43,43,7B,43,43,8,42,0,0
DATA 0,0,0,0,0,0,0,0,43,43,43,8,43,42,0,0
DATA 0,0,0,0,0,0,0,0,4,43,43,43,43,0,0,0
DATA 0,0,0,0,0,0,0,0,8,8,8,8,8,0,0,0
DATA 0,0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,0,0
DATA 8,0,0,43,0,0,7B,7B,43,43,42,43,7B,7B,7B,0
DATA 8,1,43,43,42,7A,43,43,43,42,43,43,43,7B,7B,43
DATA 8,8,42,43,43,43,43,43,43,43,42,43,7B,7B,7B,43
DATA 0,8,1,1,1,1,1,1,7B,7B,7B,7B,7B,7B,7B,43
DATA 0,0,8,1,1,1,1,1,1,8,7B,7B,7B,7B,43,42
DATA 0,0,0,0,0,1,1,1,1,1,8,8,8,8,8,0
DATA 0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,0,0,0,1,1,8,8,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,1,8,8,0,0
DATA 0,0,0,0,0,0,0,0,0,0,8,8,8,0,0,0

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,4,4,4,4,4,4,4,0,0
DATA 0,0,0,0,0,0,0,0,4,4,4,4,4,4,0,0
DATA 0,0,0,0,0,0,0,0,43,43,42,8,42,42,0,0
DATA 0,0,0,0,0,0,0,43,43,7B,43,43,8,42,0,0
DATA 0,0,0,0,0,0,0,0,43,43,43,8,43,42,0,0
DATA 0,0,0,0,0,0,0,0,4,43,43,43,43,0,0,0
DATA 0,0,0,0,0,0,0,0,8,8,8,8,8,0,0,0
DATA 0,0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,0,0
DATA 0,0,0,43,0,0,7B,7B,43,43,42,43,7B,7B,7B,0
DATA 0,0,43,43,42,7A,43,43,43,42,43,43,43,7B,7B,0
DATA 0,0,42,43,43,43,43,43,43,43,42,43,7B,7B,7B,0
DATA 0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,7B,7B,0
DATA 0,0,0,0,0,43,43,7B,7B,7B,7B,7B,7B,7B,0,0
DATA 0,0,0,0,0,43,43,8,8,8,8,8,8,8,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,1,1,1,1,0,0,1,1,1,0,0
DATA 0,0,0,0,1,1,1,1,0,0,0,1,1,1,0,0
DATA 0,0,0,0,0,1,1,1,1,0,0,1,1,1,0,0
DATA 0,0,0,0,0,0,1,1,1,8,0,1,1,1,0,0
DATA 0,0,0,0,0,8,8,8,8,8,0,8,8,1,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,0


Block:

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,4,4,4,4,4,4,4,0,0,E,0,0,0
DATA 0,0,0,0,E,0,0,0,4,4,4,4,4,4,0,0,E,0,0,0
DATA 0,0,0,0,E,0,0,0,43,43,42,8,42,42,0,0,E,0,0,0
DATA 0,0,0,E,0,0,0,43,43,7B,43,43,8,42,0,0,0,E,0,0
DATA 0,0,0,E,0,0,0,0,43,43,43,8,43,42,0,0,0,E,0,0
DATA 0,0,E,0,0,0,0,0,4,43,43,43,43,0,0,0,0,E,0,0
DATA 0,0,E,0,0,0,0,0,8,8,8,8,8,0,0,0,0,0,E,0
DATA 0,E,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,0,0,0,0,E,0
DATA 0,E,0,43,0,0,7B,7B,43,43,42,43,7B,7B,7B,0,0,0,E,0
DATA E,0,43,43,42,7A,43,43,43,42,43,43,43,7B,7B,0,0,E,0,0
DATA E,0,42,43,43,43,43,43,43,43,42,43,7B,7B,7B,0,0,E,0,0
DATA E,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,7B,7B,0,0,E,0,0
DATA 0,E,0,0,0,43,43,7B,7B,7B,7B,7B,7B,7B,0,0,E,0,0,0
DATA 0,E,0,0,0,43,43,8,8,8,8,8,8,8,0,0,E,0,0,0
DATA 0,0,E,0,0,0,0,1,1,1,1,1,1,1,0,0,E,0,0,0
DATA 0,0,E,0,0,0,0,1,1,1,1,1,1,1,0,0,E,0,0,0
DATA 0,0,0,E,0,0,0,1,1,1,1,1,1,1,0,E,0,0,0,0
DATA 0,0,0,E,0,0,0,1,1,1,1,1,1,1,0,E,0,0,0,0
DATA 0,0,0,0,E,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0
DATA 0,0,0,0,E,0,0,1,1,8,0,8,8,1,0,0,0,0,0,0
DATA 0,0,0,0,0,0,8,8,8,8,0,8,8,8,8,0,0,0,0,0

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4
DATA 0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4
DATA 0,0,0,0,0,0,0,0,0,0,43,43,42,8,42,42
DATA 0,0,0,0,0,0,0,0,0,43,43,7B,43,43,8,42
DATA 0,0,0,0,0,0,0,0,0,0,43,43,43,8,43,42
DATA 0,0,0,0,0,0,0,0,0,0,4,43,43,43,43,0
DATA 0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,0
DATA 0,0,0,0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B
DATA 0,0,0,0,43,0,0,7B,7B,43,43,42,43,7B,7B,7B
DATA 0,0,0,43,43,42,7A,43,43,43,42,43,43,43,7B,7B
DATA 0,0,0,42,43,43,43,43,43,43,43,42,43,7B,7B,7B
DATA 0,0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,7B,7B
DATA 0,0,0,0,0,0,43,43,7B,7B,7B,7B,7B,7B,7B,0
DATA 0,0,0,0,0,43,43,8,8,8,8,8,8,8,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0
DATA 0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0
DATA 0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0
DATA 0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0
DATA 0,0,0,0,0,1,1,1,8,0,8,8,1,0,0,0
DATA 0,0,0,0,8,8,8,8,0,0,8,8,8,8,0,0

Fire:

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4
DATA 0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4
DATA 0,0,0,0,0,0,0,0,0,0,43,43,42,8,42,42
DATA 0,0,0,0,0,0,0,0,0,43,43,7B,43,43,8,42
DATA 0,0,0,0,0,0,0,0,0,0,43,43,43,8,43,42
DATA 0,0,0,0,0,0,0,0,0,0,4,43,43,43,43,0
DATA 0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,0
DATA 0,0,0,0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B
DATA 0,0,42,43,0,0,0,7B,7B,43,43,42,43,7B,7B,7B
DATA 0,0,0,43,43,42,7A,43,43,43,42,43,43,43,7B,7B
DATA 0,0,0,42,43,43,43,43,43,43,43,42,43,7B,7B,7B
DATA 0,0,42,43,0,0,0,7B,7B,7B,7B,7B,7B,7B,7B,7B
DATA 0,0,0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,0
DATA 0,0,0,0,0,0,0,8,8,8,8,8,8,8,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0
DATA 0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0
DATA 0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0
DATA 0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0
DATA 0,0,0,0,0,0,1,1,8,0,8,8,1,0,0,0
DATA 0,0,0,0,0,8,8,8,0,0,8,8,8,8,0,0

Death:

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,4,4,4,4,4,4,4,0,0
DATA 0,0,0,0,0,0,0,0,4,4,4,4,4,4,0,0
DATA 0,0,0,0,0,0,0,0,43,43,42,8,42,42,0,0
DATA 0,0,0,0,0,0,0,43,43,7B,43,43,8,42,0,0
DATA 0,0,0,0,0,0,0,0,43,43,43,8,43,42,0,0
DATA 0,0,0,0,0,0,0,0,4,43,43,43,43,0,0,0
DATA 0,0,0,0,0,0,0,0,8,8,8,8,8,0,0,0
DATA 0,0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,0,0
DATA 0,0,0,43,0,0,7B,7B,43,43,42,43,7B,7B,7B,0
DATA 0,0,43,43,42,7A,43,43,43,42,43,43,43,7B,7B,0
DATA 0,0,42,43,43,43,43,43,43,43,42,43,7B,7B,7B,0
DATA 0,0,0,0,0,0,7B,7B,7B,7B,7B,7B,7B,7B,7B,0
DATA 0,0,0,0,0,43,43,7B,7B,7B,7B,7B,7B,7B,0,0
DATA 0,0,0,0,0,43,43,8,8,8,8,8,8,8,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,1,1,8,0,8,8,1,0,0
DATA 0,0,0,0,0,0,8,8,8,8,0,8,8,8,8,0

Fence:

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,F,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,F,F,7,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,F,F,7,0,0,0,0,0,0,0,0,0,0
DATA F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F
DATA 7,7,7,F,F,7,7,7,7,7,7,7,7,7,7,7
DATA 0,0,0,F,F,7,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,F,F,7,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,F,F,7,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,F,F,7,0,0,0,0,0,0,0,0,0,0
DATA 0,2,0,F,F,7,0,2,0,0,2,0,0,2,0,0
DATA 2,2,2,F,F,7,2,2,A,2,2,2,2,2,2,2

Iced:

DATA 0,b2,67,1c,0
DATA 0,0,b2,67,1c
DATA 0,0,b2,67,1c
DATA 0,0,b2,67,1c
DATA 0,b2,67,1c,0

LOCATE 2, 1: PRINT "       "
IF MaxColor = 16 THEN
    SCREEN 9
    PALETTE 6, 32
    PALETTE 3, 46
    PALETTE 5, 40
    WINDOW (0, 0)-(319, 199)
    WINDOW (0, 0)-(639, 349)
    WIDTH 40
    MaxColor = 15
END IF

KEY(5) OFF

LOCATE 17, 1
PRINT STRING$(40, "�")

IF INSTR(Com$, "/DEBUG") THEN
    LOCATE 2, 1
    FOR J = 1 TO &HA1
        COLOR J MOD MaxColor
        PRINT HEX$(J); " ";
    NEXT J
    LOCATE 18, 1
    FOR J = &HA2 TO 250
        COLOR J MOD MaxColor
        PRINT HEX$(J); " ";
    NEXT J
END IF

COLOR 15
IF MaxColor < 14 THEN COLOR 0
ON ERROR GOTO 0

P1x = 15: P1d = 2
P2x = 25: P2d = 1
P1e = 120: P1xo = 1
P2e = 120: P2xo = 1
P1eo = P1e
P2eo = P2e
Flag = 1

IF INSTR(Com$, "CHEAT1") THEN P2e = 60
IF INSTR(Com$, "CHEAT2") THEN P1e = 60

IF INSTR(Com$, "C1") THEN C1 = 1
IF INSTR(Com$, "C2") THEN C2 = 1

PLAY OFF

FOR J = 1 TO 19
    PUT (J * 16 - 2, 116), Fence
NEXT J

RESTORE Death

DO
    IF Flag = 1 THEN
        LINE (4, 5)-(4 + P1e, 10), 4, BF
        LINE (4 + P1e, 4)-(124, 11), 0, BF
        C = 12
        IF C MOD MaxColor = 3 OR C MOD MaxColor = 0 THEN C = 1
        LINE (4 + P1e, 4)-(4 + P1e, 11), C MOD MaxColor
        LINE (4, 11)-(4 + P1e, 11), C MOD MaxColor
        C = 111
        IF C MOD MaxColor = 3 OR C MOD MaxColor = 0 THEN C = 1
        LINE (4, 4)-(4 + P1e - 1, 4), C MOD MaxColor
        LINE (4, 4)-(4, 11), C MOD MaxColor
        LINE (315, 5)-(315 - P2e, 10), 5, BF
        LINE (315 - P2e, 4)-(315 - 120, 11), 0, BF
        LINE (315, 4)-(315, 11), 13 MOD MaxColor
        LINE (315, 11)-(316 - (P2e), 11), 13 MOD MaxColor
        LINE (314, 4)-(316 - P2e, 4), 109 MOD MaxColor
        LINE (316 - P2e, 4)-(316 - P2e, 11), 109 MOD MaxColor
        LOCATE 3, 1: PRINT P1e
        LOCATE 3, 35: PRINT P2e
    END IF

    IF P2e < 1 THEN
        DO UNTIL INKEY$ = "": LOOP
        FOR J = 1 TO 4
            LOCATE 12 + J + P2yo, P2xo
            PRINT "    ";
        NEXT J
        FOR Y = 1 TO 23
            FOR X = 1 TO 16
                READ A$
                A = VAL("&H" + A$)
                IF A = 0 THEN A = -1
                PSET (Y + 8 * P2x, 8 * (13 + P2y) + X + 27), (A + 1) MOD MaxColor
            NEXT X
        NEXT Y
        DO WHILE INKEY$ = "": LOOP
        END
    END IF

    IF P1e < 1 THEN
        DO UNTIL INKEY$ = "": LOOP
        FOR J = 1 TO 4
            LOCATE 12 + J + P1yo, P1xo
            PRINT "    ";
        NEXT J
        FOR Y = 1 TO 23
            FOR X = 1 TO 16
                READ A$
                A = VAL("&H" + A$)
                PSET (Y + 8 * P1x, 8 * (13 + P1y) + X + 27), A MOD MaxColor
            NEXT X
        NEXT Y
        DO WHILE INKEY$ = "": LOOP
        END
    END IF

    IF P2xo > 37 THEN P2xo = 36
    IF P1xo > 37 THEN P1xo = 36
    IF P2xo < 1 THEN P2xo = 2
    IF P1xo < 1 THEN P1xo = 2

    IF P2x > 37 THEN P2x = 36
    IF P1x > 37 THEN P1x = 36
    IF P2x < 1 THEN P2x = 2
    IF P1x < 1 THEN P1x = 2

    IF P1x <> P1xo OR P2x <> P2xo OR P1d <> p1do OR P2d <> p2do OR Flag = 1 OR BFlag1 = 1 OR BFlag2 = 1 THEN
        FOR J = 1 TO 4
            IF PFlag1 = 0 THEN
                IF KFlag1 = 0 THEN
                    LOCATE 12 + J + P1yo, P1xo
                    PRINT "    ";
                END IF
            END IF
            IF PFlag2 = 0 THEN
                IF KFlag2 = 0 THEN
                    LOCATE 12 + J + P2yo, P2xo
                    PRINT "    ";
                END IF
            END IF
        NEXT J
        
        IF (PFlag1 = 0 AND KFlag1 = 0) OR (PFlag2 = 0 AND KFlag2 = 0) THEN GOSUB Fencer
        IF PFlag1 = 0 THEN
            IF KFlag1 = 0 THEN
                IF BFlag1 THEN
                    IF P1d = 2 THEN DFactor = -4 ELSE DFactor = 0
                    PUT (8 * P1x + DFactor, 8 * (13 + P1y)), BG(0, P1d), OR
                    IF TB1@ + .5 < TIMER THEN
                        PUT (8 * P1x + DFactor, 8 * (13 + P1y)), BG(0, P1d), XOR
                        BFlag1 = 0
                        Flag = 1
                        PUT (8 * P1x, 8 * (13 + P1y)), FG(0, P1d), OR
                    END IF
                ELSEIF JFlag1 THEN
                    PUT (8 * P1x, 8 * (13 + P1y)), JG(0, P1d), OR
                ELSEIF HFlag1 THEN
                    PUT (8 * P1x, 8 * (13 + P1y)), HG(0, P1d), OR
                ELSE
                    PUT (8 * P1x, 8 * (13 + P1y)), FG(0, P1d), OR
                END IF
            END IF
        END IF
        IF PFlag2 = 0 THEN
            IF KFlag2 = 0 THEN
                IF BFlag2 THEN
                    IF P2d = 2 THEN DFactor = -4 ELSE DFactor = 0
                    PUT (8 * P2x + DFactor, 8 * (13 + P2y)), BG2(0, P2d), OR
                    IF TB2@ + .5 < TIMER THEN
                        PUT (8 * P2x + DFactor, 8 * (13 + P2y)), BG2(0, P2d), XOR
                        BFlag2 = 0
                        Flag = 1
                        PUT (8 * P2x, 8 * (13 + P2y)), FG2(0, P2d), OR
                    END IF
                ELSEIF JFlag2 THEN
                    PUT (8 * P2x, 8 * (13 + P2y)), JG2(0, P2d), OR
                ELSEIF HFlag2 THEN
                    PUT (8 * P2x, 8 * (13 + P2y)), HG2(0, P2d), OR
                ELSE
                    PUT (8 * P2x, 8 * (13 + P2y)), FG2(0, P2d), OR
                END IF
            END IF
        END IF
        Flag = 0
    END IF
    p1do = P1d: p2do = P2d: P1xo = P1x: P2xo = P2x
    P1yo = P1y: P2yo = P2y
    P1eo = P1e
    P2eo = P2e

    DO
    DO
        A$ = UCASE$(INKEY$)
        IF A$ = "" THEN
            IF Com2 THEN
                IF TIMER - .5 > LT1@ THEN
                    RandNum = INT(10 * RND)
                    LT1@ = TIMER
                    IF RandNum <> 0 THEN A$ = MID$("789456123", RandNum, 1)
                    EXIT DO
                END IF
            END IF
            IF Com1 THEN
                IF TIMER - .5 > LT2@ THEN
                    RandNum = INT(10 * RND)
                    LT2@ = TIMER
                    IF RandNum <> 0 THEN A$ = MID$("QWEASDZXC", RandNum, 1)
                    EXIT DO
                END IF
            END IF
        END IF
        IF PFlag1 OR KFlag1 THEN IF INSTR(A$, "789456123") THEN NKFlag = 1
        IF PFlag2 OR KFlag2 THEN IF INSTR(A$, "QWEASDZXC") THEN NKFlag = 1
    LOOP WHILE NKFlag = 1

    SELECT CASE A$
        CASE " "
            Fire1 = Fire1 + 1
            IF Fire1 >= 4 THEN
                IF PFlag1 = 0 THEN
                    IF KFlag1 = 0 THEN
                        FXFlag1 = 1
                        FOR J = 1 TO 4
                            LOCATE 12 + J + P1y, P1x
                            PRINT "    ";
                        NEXT J
                        GOSUB Fencer
                        PUT (8 * P1x + DFactor, 8 * (13 + P1y)), FXG(0, P1d), OR
                        IX1 = 8 * P1x + DFactor: IY1 = 8 * (13 + P1y)
                        ID1 = P1d
                        Fire1 = 0
                        PUT (IX1, IY1 + 9), IG(0, ID1)
                    END IF
                END IF
            END IF
        CASE "+"
            Fire2 = Fire2 + 1
            IF Fire2 >= 4 THEN
                IF PFlag2 = 0 THEN
                    IF KFlag2 = 0 THEN
                        FXFlag2 = 1
                        FOR J = 1 TO 4
                            LOCATE 12 + J + P2y, P2x
                            PRINT "    ";
                        NEXT J
                        GOSUB Fencer
                        PUT (8 * P2x + DFactor, 8 * (13 + P2y)), FXG2(0, P2d), OR
                        IX2 = 8 * P2x + DFactor: IY2 = 8 * (13 + P2y)
                        ID2 = P2d
                        Fire2 = 0
                        PUT (IX2, IY2 + 9), IG2(0, ID2)
                    END IF
                END IF
            END IF
        CASE CHR$(9)
            IF C1 = 1 THEN
                IF P1e < 100 THEN
                    P1e = P1e + 1
                    P2e = P2e - 1
                    Flag = 1
                END IF
            END IF
        CASE CHR$(13)
            IF C2 = 1 THEN
                IF P2e < 100 THEN
                    P2e = P2e + 1
                    P1e = P1e - 1
                    Flag = 1
                END IF
            END IF
        CASE CHR$(27): END
        CASE "A": P1x = P1x - 1: IF P1x < 1 THEN P1x = 2
            IF JFlag1 THEN P1d = 1
        CASE "D": P1x = P1x + 1: IF P1x > 37 THEN P1x = 36
            IF JFlag1 THEN P1d = 2
        CASE "4": P2x = P2x - 1: IF P2x < 1 THEN P2x = 2
            IF JFlag2 THEN P2d = 1
        CASE "6": P2x = P2x + 1: IF P2x > 37 THEN P2x = 36
            IF JFlag2 THEN P2d = 2
        CASE "Z"
            IF BFlag1 <> 1 THEN
                KFlag1 = 1
                Flag = 1
                P1d = 1
                PUT (8 * P1x, 8 * (13 + P1y)), KG(0, P1d), PSET
                tk1@ = TIMER:
                IF P2x < P1x + 4 AND P2x > P1x - 4 AND P2y < P1y + 2 AND P2y > P1y - 2 THEN
                    P2e = P2e - 2
                    IF BFlag2 THEN P2e = P2e + 1
                    IF NOT BFlag2 THEN IF P2x < P1x THEN P2x = P2x - 1 ELSE P2x = P2x + 1
                    IF P2x < 1 THEN P1x = 37
                    IF P2x > 37 THEN P1x = 1
                    SOUND 700, .1: SOUND 600, .1
                END IF
            END IF
        CASE "C"
            IF BFlag1 <> 1 THEN
                KFlag1 = 2
                Flag = 1
                P1d = 2
                PUT (8 * P1x, 8 * (13 + P1y)), KG(0, P1d), PSET
                tk1@ = TIMER:
                IF P2x < P1x + 4 AND P2x > P1x - 4 AND P2y < P1y + 2 AND P2y > P1y - 2 THEN
                    P2e = P2e - 2
                    IF BFlag2 THEN P2e = P2e + 1
                    IF NOT BFlag2 THEN IF P2x < P1x THEN P2x = P2x - 1 ELSE P2x = P2x + 1
                    IF P2x < 1 THEN P2x = 37
                    IF P2x > 37 THEN P2x = 1
                    SOUND 700, .1: SOUND 600, .1
                END IF
            END IF
        CASE "Q"
            IF BFlag1 <> 1 THEN
                tp1@ = TIMER
                Flag = 1
                P1d = 1
                PFlag1 = 1
                PUT (8 * P1x, 8 * (13 + P1y)), PG(0, P1d), PSET
                IF P2x < P1x + 3 AND P2x > P1x - 3 AND P2y < P1y + 2 AND P2y > P1y - 2 THEN
                    P2e = P2e - 2
                    IF BFlag2 THEN P2e = P2e + 1
                    IF NOT BFlag2 THEN IF P2x < P1x THEN P2x = P2x - 1 ELSE P2x = P2x + 1
                    IF P2x < 1 THEN P2x = 37
                    IF P2x > 37 THEN P2x = 1
                    SOUND 700, .1: SOUND 600, .1
                END IF
            END IF
        CASE "E"
            IF BFlag1 <> 1 THEN
                Flag = 1
                P1d = 2
                PFlag1 = 2
                tp1@ = TIMER
                PUT (8 * P1x, 8 * (13 + P1y)), PG(0, P1d), PSET
                IF P2x < P1x + 3 AND P2x > P1x - 3 AND P2y < P1y + 2 AND P2y > P1y - 2 THEN
                    P2e = P2e - 2
                    IF BFlag2 THEN P2e = P2e + 1
                    IF NOT BFlag2 THEN IF P2x < P1x THEN P2x = P2x - 1 ELSE P2x = P2x + 1
                    IF P2x < 1 THEN P2x = 37
                    IF P2x > 37 THEN P2x = 1
                    SOUND 700, .1: SOUND 600, .1
                END IF
            END IF
        CASE "7"
            IF BFlag2 <> 1 THEN
                Flag = 1
                P2d = 1
                PFlag2 = 1
                tp2@ = TIMER
                PUT (8 * P2x, 8 * (13 + P2y)), PG2(0, P2d), PSET
                IF P2x < P1x + 3 AND P2x > P1x - 3 AND P2y < P1y + 2 AND P2y > P1y - 2 THEN
                    P1e = P1e - 2
                    IF BFlag1 THEN P1e = P1e + 1
                    IF NOT BFlag1 THEN IF P1x < P2x THEN P1x = P1x - 1 ELSE P1x = P1x + 1
                    IF P1x < 1 THEN P1x = 37
                    IF P1x > 37 THEN P1x = 1
                    SOUND 700, .1: SOUND 600, .1
                END IF
            END IF
        CASE "9"
            IF BFlag2 <> 1 THEN
                Flag = 1
                P2d = 2
                PFlag2 = 2
                tp2@ = TIMER
                PUT (8 * P2x, 8 * (13 + P2y)), PG2(0, P2d), PSET
                IF P2x < P1x + 3 AND P2x > P1x - 3 AND P2y < P1y + 2 AND P2y > P1y - 2 THEN
                    P1e = P1e - 2
                    IF BFlag1 THEN P1e = P1e + 1
                    IF NOT BFlag1 THEN IF P1x < P2x THEN P1x = P1x - 1 ELSE P1x = P1x + 1
                    IF P1x < 1 THEN P1x = 37
                    IF P1x > 37 THEN P1x = 1
                    SOUND 700, .1: SOUND 600, .1
                END IF
            END IF
        CASE "1"
            IF BFlag2 <> 1 THEN
                KFlag2 = 1
                Flag = 1
                P2d = 1
                PUT (8 * P2x, 8 * (13 + P2y)), KG2(0, P2d), PSET
                tk2@ = TIMER:
                DO WHILE T@ + .1 > TIMER: LOOP
                IF P2x < P1x + 4 AND P2x > P1x - 4 AND P2y < P1y + 2 AND P2y > P1y - 2 THEN
                    P1e = P1e - 2
                    IF BFlag1 THEN P1e = P1e + 1
                    IF BFlag1 = 0 THEN IF P1x < P2x THEN P1x = P1x - 1 ELSE P1x = P1x + 1
                    IF P1x < 1 THEN P1x = 37
                    IF P1x > 37 THEN P1x = 1
                    SOUND 700, .1: SOUND 600, .1
                END IF
            END IF
        CASE "3"
            IF BFlag2 <> 1 THEN
                KFlag2 = 2
                Flag = 1
                P2d = 2
                PUT (8 * P2x, 8 * (13 + P2y)), KG2(0, P2d), PSET
                tk2@ = TIMER
                DO WHILE T@ + .1 > TIMER: LOOP
                IF P2x < P1x + 4 AND P2x > P1x - 4 AND P2y < P1y + 2 AND P2y > P1y - 2 THEN
                    P1e = P1e - 2
                    IF BFlag1 THEN P1e = P1e + 1
                    IF NOT BFlag1 THEN IF P1x < P2x THEN P1x = P1x - 1 ELSE P1x = P1x + 1
                    IF P1x < 1 THEN P1x = 37
                    IF P1x > 37 THEN P1x = 1
                    SOUND 700, .1: SOUND 600, .1
                END IF
            END IF
        CASE "8": JFlag2 = 1: TJ2@ = TIMER - .1
        CASE "W": JFlag1 = 1: TJ1@ = TIMER - .1
        CASE "5": TB2@ = TIMER: BFlag2 = 1
        CASE "S": TB1@ = TIMER: BFlag1 = 1
    END SELECT
    NKFlag = 0
    LOOP UNTIL A$ = ""

    IF FXFlag1 THEN
        PUT (IX1, IY1 + 9), IG(0, ID1)
        IX1 = IX1 + 2 * (2 * (P1d - 1) - 1)
        PXS = 8 * P2x + DFactor: PYS = 8 * (13 + P2y)
        IF PXS < IX1 + 4 AND PXS > IX1 - 4 AND PYS < IY1 + 3 AND PYS > IY1 - 3 THEN
            P2e = P2e - 2
            IF BFlag1 THEN P2e = P2e + 1
            IF NOT BFlag1 THEN IF PXS < IX1 THEN P2x = P2x - 1 ELSE P2x = P2x + 1
            IF P2x < 1 THEN P2x = 37
            IF P2x > 37 THEN P2x = 1
            SOUND 800, .1: SOUND 500, .1
            Flag = 1
            FXFlag1 = 0
        END IF
        IF IX1 < 316 AND IX1 > 0 THEN PUT (IX1, IY1 + 9), IG(0, ID1) ELSE FXFlag1 = 0
    END IF
    IF FXFlag2 THEN
        PUT (IX2, IY2 + 9), IG2(0, ID2)
        IX2 = IX2 + 2 * (2 * (P2d - 1) - 1)
        PXS = 8 * P1x + DFactor: PYS = 8 * (13 + P1y)
        IF PXS < IX2 + 8 AND PXS > IX2 - 8 AND PYS < IY2 + 5 AND PYS > IY2 - 5 THEN
            P1e = P1e - 2
            IF BFlag1 THEN P1e = P1e + 1
            IF NOT BFlag1 THEN IF PXS < IX2 THEN P1x = P1x - 1 ELSE P1x = P1x + 1
            IF P1x < 1 THEN P1x = 37
            IF P1x > 37 THEN P1x = 1
            SOUND 800, .1: SOUND 500, .1
            Flag = 1
            FXFlag2 = 0
        END IF
        IF IX2 < 316 AND IX2 > 0 THEN PUT (IX2, IY2 + 9), IG2(0, ID2) ELSE FXFlag2 = 0
    END IF

    IF HFlag1 = 1 AND TH1@ + .2 < TIMER THEN HFlag1 = 0
    IF HFlag2 = 1 AND TH2@ + .2 < TIMER THEN HFlag2 = 0

    IF P1e <> P1eo THEN
        HFlag1 = 1
        TH1@ = TIMER
    END IF
    IF P2e <> P2eo THEN
        HFlag2 = 1
        TH2@ = TIMER
    END IF

    IF P2xo > 37 THEN P2xo = 36
    IF P1xo > 37 THEN P1xo = 36
    IF P2xo < 1 THEN P2xo = 2
    IF P1xo < 1 THEN P1xo = 2

    IF JFlag1 = 1 AND TJ1@ + .1 < TIMER THEN
        IF Dflag1 <> 1 THEN P1y = P1y - 1
        IF P1y < -5 THEN Dflag1 = 1
        IF Dflag1 = 1 THEN P1y = P1y + 1
        IF P1y = 0 THEN
            JFlag1 = 0
            Dflag1 = 0
        END IF
        TJ1@ = TIMER
        Flag = 1
    END IF

    IF JFlag2 = 1 AND TJ2@ + .1 < TIMER THEN
        IF Dflag2 <> 1 THEN P2y = P2y - 1
        IF P2y < -5 THEN Dflag2 = 1
        IF Dflag2 = 1 THEN P2y = P2y + 1
        IF P2y = 0 THEN
            JFlag2 = 0
            Dflag2 = 0
        END IF
        TJ2@ = TIMER
        Flag = 1
    END IF

    IF KFlag1 THEN
        P1d = KFlag1
        FOR J = 1 TO 4
            LOCATE 12 + J + P1yo, P1xo
            PRINT "    ";
        NEXT J
        PUT (8 * P1x, 8 * (13 + P1y)), KG(0, P1d), PSET
        IF tk1@ + .3 < TIMER THEN
            KFlag1 = 0
            Flag = 1
        END IF
    END IF

    IF KFlag2 THEN
        P2d = KFlag2
        FOR J = 1 TO 4
            LOCATE 12 + J + P2yo, P2xo
            PRINT "    ";
        NEXT J
        PUT (8 * P2x, 8 * (13 + P2y)), KG2(0, P2d), PSET
        IF tk2@ + .3 < TIMER THEN
            KFlag2 = 0
            Flag = 1
        END IF
    END IF

    IF PFlag1 THEN
        P1d = PFlag1
        FOR J = 1 TO 4
            LOCATE 12 + J + P1yo, P1xo
            PRINT "    ";
        NEXT J
        PUT (8 * P1x, 8 * (13 + P1y)), PG(0, P1d), PSET
        IF tp1@ + .1 < TIMER THEN
            PFlag1 = 0
            Flag = 1
        END IF
    END IF

    IF PFlag2 THEN
        P2d = PFlag2
        FOR J = 1 TO 4
            LOCATE 12 + J + P2yo, P2xo
            PRINT "    ";
        NEXT J
        PUT (8 * P2x, 8 * (13 + P2y)), PG2(0, P2d), PSET
        IF tp2@ + .1 < TIMER THEN
            PFlag2 = 0
            Flag = 1
        END IF
    END IF
LOOP

TitleMusic:
PLAY "CCDCECFG"
RETURN

NTSet:
KEY(5) OFF
NT = 1
PLAY OFF
PLAY "T255O3CCCCCCCCCC"
RETURN
Fencer:
QZR = 0
FOR J = 0 TO 19
    IF J = 19 THEN QZR = 2
    PUT (J * 16 - QZR, 116), Fence, PSET
NEXT J
RETURN

