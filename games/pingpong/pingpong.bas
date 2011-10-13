SCREEN 0, 1
WIDTH 40
KEY OFF
s$ = SPACE$(37)
ON KEY(11) GOSUB 1610
ON KEY(14) GOSUB 1670
L = 1
210 KEY(11) ON
KEY(14) ON
Y1 = 12: y1scr = Y1
y2 = 12: y2scr = Y1
xold = 20: yold = 12
delx = 1: dely = 0
Pad1 = -1: pad2 = -1
bcount = 0
COLOR 15, 0
CLS
LOCATE 1, 1: PRINT Player1;
LOCATE 1, 35: PRINT Player2;
LOCATE 1, 14: PRINT "Level"; L
COLOR 1, 1
LOCATE 2, 2: PRINT s$;
LOCATE 24, 2: PRINT s$;
COLOR 15, 0
DO
snd = 0
IF L > 5 THEN spd = L * 10 ELSE spd = 50
FOR J = 1 TO spd: NEXT J
GOSUB 9000
yo = y
IF (Pad1 OR pad2) THEN
    IF Pad1 THEN
        Pad1 = 0
        COLOR 15, 0
        LOCATE y1scr - 1, 1, 0: PRINT " ";
        LOCATE y1scr, 1, 0: PRINT " ";
        LOCATE y1scr + 1, 1, 0: PRINT " ";
        y1scr = Y1
        COLOR 15, 4
        LOCATE y1scr - 1, 1, 0: PRINT " ";
        LOCATE y1scr, 1, 0: PRINT " ";
        LOCATE y1scr + 1, 1, 0: PRINT " ";
    ELSE
        pad2 = 0
        COLOR 15, 0
        LOCATE y2scr - 1, 39, 0: PRINT " ";
        LOCATE y2scr, 39, 0: PRINT " ";
        LOCATE y2scr + 1, 39, 0: PRINT " ";
        y2scr = y2
        COLOR 15, 2
        LOCATE y2scr - 1, 39, 0: PRINT " ";
        LOCATE y2scr, 39, 0: PRINT " ";
        LOCATE y2scr + 1, 39, 0: PRINT " ";
    END IF
END IF
IF bcount = 0 THEN
    X = xold + delx
    y = yold + dely
END IF
bcount = (bcount + 1) MOD 2
IF X = 2 THEN
    snd = 500
    delx = 1
    IF y < y1scr - 1 OR y > y1scr + 1 THEN
        COLOR 15, 0
        LOCATE yold, 3, 0: PRINT " ";
        LOCATE y, 2, 0: PRINT "*out";
        Player2 = Player2 + 1
        GOTO 1320
    ELSEIF y = y1scr - 1 THEN
        dely = -1
        snd = 1000
    ELSEIF y = y1scr + 1 THEN
        dely = 1
        snd = 1000
    ELSE
        dely = 0
        snd = 500
    END IF
ELSEIF X = 38 THEN
    snd = 500
    delx = -1
    IF y < y2scr - 1 OR y > y2scr + 1 THEN
        COLOR 15, 0
        LOCATE yold, 37, 0: PRINT " "
        LOCATE y, 35, 0: PRINT "out*"
        Player1 = Player1 + 1
        GOTO 1320
    END IF
    IF y = y2scr - 1 THEN
        dely = -1
        snd = 1000
    ELSEIF y = y2scr + 1 THEN
        dely = 1
        snd = 1000
    ELSE
        dely = 0
        snd = 500
    END IF
END IF
IF y = 3 THEN
    dely = 1
    snd = 600
END IF
IF y = 23 THEN
    dely = -1
    snd = 600
END IF
COLOR 14, 0
LOCATE yold, xold, 0: PRINT " ";
LOCATE y, X, 0: PRINT "*";
xold = X: yold = y
IF snd THEN SOUND snd, 2
LOOP
1320 KEY(1) OFF
     KEY(3) OFF
     KEY(11) OFF
     KEY(14) OFF
     FOR i = 2000 TO 400 STEP -100
        SOUND i, 1
     NEXT i
     DEF SEG : POKE 106, 0
     LOCATE 25, 1
     IF Player2 > 10 * L AND Player2 > Player1 THEN L = L + 1
     IF Player1 > 19 + Player2 AND L * 10 < Player2 + 20 THEN L = L - 1
     PRINT "Press any key to restart";
     a$ = INPUT$(1)
     GOTO 210
1610 y2 = y2 - 1
     IF y2 < 2 THEN y2 = 24
     pad2 = -1
     RETURN
1670 y2 = y2 + 1
     IF y2 > 24 THEN y2 = 2
     pad2 = -1
     RETURN
9000
     a$ = UCASE$(INKEY$)
     SELECT CASE a$
        CASE "W"
            Y1 = Y1 - 1
            IF Y1 < 2 THEN Y1 = 24
            Pad1 = -1
        CASE "X"
            Y1 = Y1 + 1
            IF Y1 > 24 THEN Y1 = 2
            Pad1 = -1
     END SELECT
     RETURN

