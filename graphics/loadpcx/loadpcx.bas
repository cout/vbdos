DEFINT A-O
DEFINT Q-Z
DEFLNG P
DIM st AS STRING * 1
Pt = 0
a$ = SPACE$(128)
DEF SEG = &HA000
Com$ = UCASE$(COMMAND$)
IF RIGHT$(Com$, 4) <> ".PCX" THEN Com$ = Com$ + ".PCX"
OPEN Com$ FOR BINARY AS #1
GET #1, , a$
st = " "
SCREEN 13
WHILE Pt < 64000
    GET #1, , st
    ct = ASC(st)
    IF (ct AND 192) <> 192 THEN
        IF Pt <> 0 THEN POKE Pt, ct
        Pt = Pt + 1
    ELSE
        ct = (ct AND 63)
        GET #1, , st
        Dat = ASC(st)
        IF Dat <> 0 THEN
            WHILE ct AND (Pt < 64000)
                ct = ct - 1
                POKE Pt, Dat
                Pt = Pt + 1
            WEND
        ELSE
            Pt = Pt + ct
        END IF
    END IF
WEND
GET #1, , st
OUT &H3C8, 0
FOR I = 1 TO 768
    GET #1, , st
    OUT &H3C9, ASC(st) \ 4
NEXT I
CLOSE #1
a$ = ""
WHILE a$ = "": a$ = INKEY$: WEND
SCREEN 0
WIDTH 80

