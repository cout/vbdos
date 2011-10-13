DECLARE SUB pke (Pnt&, Value%)
DEFINT A-O
DEFINT Q-Z
DEFLNG P
'$DYNAMIC
DIM SHARED PCXFile(32000) AS INTEGER
Pt = 0
a$ = SPACE$(128)
DEF SEG = &HA000
Com$ = UCASE$(COMMAND$)
IF RIGHT$(Com$, 4) <> ".PCX" THEN Com$ = Com$ + ".PCX"
OPEN Com$ FOR BINARY AS #1
GET #1, , a$
a$ = " "
SCREEN 13
GET (0, 0)-(319, 99), PCXFile
SCREEN 0
WHILE Pt < 32000
    GET #1, , a$
    ct = ASC(a$)
    LOCATE 1, 1: PRINT Pt
    IF (ct AND 192) <> 192 THEN
        pke Pt, ct
        Pt = Pt + 1
    ELSE
        ct = (ct AND 63)
        GET #1, , a$
        dat = ASC(a$)
        WHILE ct AND (Pt < 64000)
            ct = ct - 1
            pke Pt, dat
            Pt = Pt + 1
        WEND
    END IF
WEND
SCREEN 13
CLS
PUT (0, 0), PCXFile
GET #1, , a$
OUT &H3C8, 0
FOR I = 1 TO 768
    GET #1, , a$
    OUT &H3C9, ASC(a$)
NEXT I
CLOSE #1
a$ = ""
WHILE a$ = "": a$ = INKEY$: WEND
SCREEN 0
WIDTH 80

REM $STATIC
SUB pke (Pnt, Value)
    IF Pnt / 2 = INT(Pnt / 2) THEN
        PCXFile(Pnt / 2 + 1) = Value + PCXFile(Pnt / 2 + 1)
    ELSE
        IF Value > 127 THEN
            PCXFile(INT(Pnt / 2 + 1)) = (Value - 196) * 255
        ELSE
            PCXFile(INT(Pnt / 2 + 1)) = Value * 255
        END IF
    END IF
END SUB

