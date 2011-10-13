    ' FROG.BAS -- by Paul Somerson
    ' (c) 1987 Ziff Communications Co.
    '
    ' --- set up, define frog and bug parts ---
    '
    DEFINT A-Z
    SCREEN 0
    COLOR 6, 0, 0
5   pts = 0
    X = 20     ' Change from 20 to any number up to 99 for more chances
    Z = 15     ' Change from 15 to any number up to 59 for more time
    R$ = TIME$
    RANDOMIZE TIMER
    TIME$ = LEFT$(R$, 6) + "00"
    KEY 10, ""
    ON KEY(10) GOSUB 570
    VV = 1: HH = 1
    T$ = CHR$(222) + CHR$(221): UT$ = STRING$(2, 32)
    E$ = CHR$(32) + STRING$(2, 147): B$ = CHR$(243) + STRING$(2, 234) + CHR$(242)
    F$ = B$ + CHR$(30) + STRING$(4, 29) + E$ + CHR$(32): G$ = CHR$(236)
    UF$ = STRING$(4, 32) + CHR$(30) + STRING$(3, 29) + UT$
    '
    ' --- draw the screen ---
    '
10  CLS
    FOR a = 1 TO 3: LOCATE 13 + a, 1, 0
        PRINT STRING$(40, 175 + a)
    NEXT
    FOR a = 17 TO 25
        COLOR 6
        LOCATE a, 1
        PRINT STRING$(40, 219);
        COLOR 3
        PRINT STRING$(37, 247);
    NEXT
    COLOR 2
    LOCATE 19, 13: PRINT "Seconds left: "; : PRINT USING "##"; Z
    LOCATE 20, 13: PRINT "Tongues left: "; : PRINT USING "##"; X
    LOCATE 21, 13: PRINT "Points:       "; : PRINT USING "##"; pts
    LOCATE 22, 13: PRINT "High Score:   "; : PRINT USING "##"; hi
    LOCATE 23, 13: PRINT "<F10> for tongue"
    '
    ' --- move frog right then left ---
    '
360 KEY(10) OFF
    FOR C = 1 TO 33 STEP 4
        SOUND 37, 2
        GOSUB 470
        LOCATE 13, C: PRINT UF$;
        GOSUB 510
        LOCATE 11, C + 2
        PRINT F$;
        GOSUB 510
        LOCATE 11, C + 2
        PRINT UF$;
        GOSUB 510
        LOCATE 13, C + 4
        PRINT F$;
        GOSUB 510
        J = C + 5
        KEY(10) ON
    NEXT
    KEY(10) OFF
    FOR C = 37 TO 5 STEP -4
        SOUND 37, 2
        GOSUB 470
        LOCATE 13, C
        PRINT UF$;
        GOSUB 510
        LOCATE 11, C - 2
        PRINT F$;
        GOSUB 510
        LOCATE 11, C - 2
        PRINT UF$;
        GOSUB 510
        LOCATE 13, C - 4
        PRINT F$;
        GOSUB 510
        J = C - 3
        KEY(10) ON
    NEXT
    GOTO 360
    '
    ' --- delay ---
    '
470 a! = TIMER
    DO WHILE TIMER < a! + .61: LOOP
    KEY(10) OFF
    RETURN             ' Changing 600 to 50 speeds up
    '
    ' --- bug mover ---
    '
510 V = INT(RND * 10) + 1
    H = INT(RND * 39) + 1
    W = VAL(RIGHT$(TIME$, 2))
    LOCATE 19, 27: PRINT USING "##"; Z - W
    IF W = Z THEN 660
    LOCATE VV, HH: PRINT CHR$(32)
    LOCATE V, H: PRINT G$: VV = V: HH = H
    RETURN
    '
    ' --- tongue ---
    '
570 X = X - 1
    LOCATE 20, 27: PRINT USING "##"; X
    IF X = 0 THEN 660
    COLOR 4
    FOR Q = 11 TO 1 STEP -1
        IF SCREEN(Q, J) = 236 OR SCREEN(Q, J + 1) = 236 THEN 670
        LOCATE Q, J: PRINT T$
    NEXT
    FOR a = 1 TO 11
        LOCATE a, J: PRINT UT$
    NEXT
    COLOR 2
620 I$ = INKEY$: IF I$ <> "" THEN 620 ELSE RETURN
    '
    ' --- lose/win ---
    '
660 FOR P = 200 TO 37 STEP -4: SOUND P, 1: NEXT: LOCATE 1, 1
    IF pts > hi THEN hi = pts
    LOCATE 1, 1
    PRINT "Play Again (Y/N)";
    a$ = ""
    DO UNTIL a$ = "Y" OR a$ = "N": a$ = UCASE$(INKEY$): LOOP
    IF a$ = "N" THEN END
    IF a$ = "Y" THEN GOTO 5
670 FOR P = 400 TO 2900 STEP 100: SOUND P, 1: NEXT
    FOR a = Q TO 11: LOCATE a, J: PRINT UT$: NEXT
    pts = pts + 1
    GOTO 10

