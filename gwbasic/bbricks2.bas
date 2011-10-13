DEFINT A-Z
DIM a(2 TO 17, 2 TO 40)
KEY 15, CHR$(0) + CHR$(71)
KEY 16, CHR$(0) + CHR$(73)
KEY 17, CHR$(0) + CHR$(79)
KEY 18, CHR$(0) + CHR$(81)
ON KEY(12) GOSUB 1000
ON KEY(13) GOSUB 2000
ON KEY(15) GOSUB 3000
ON KEY(16) GOSUB 4000
ON KEY(17) GOSUB 5000
ON KEY(18) GOSUB 6000
ON KEY(10) GOSUB 20000
WIDTH 40
Easy = 0
G = 1
10 Pts = 0
spd = 7500
20 FOR J = 6 TO 14
    FOR I = 3 TO 40
        a(J, I) = 35
    NEXT I
NEXT J
b = 108
Ball = 4
PX = 20
DelX = 0: DelY = 1
pad = -1: Brd = -1
S$ = SPACE$(40)
210 KEY(12) ON
KEY(13) ON
KEY(15) ON
KEY(16) ON
KEY(17) ON
KEY(18) ON
KEY(10) ON
X = 20: Y = 22
xold = X: yold = Y
IF Easy = 1 THEN
    IF DelX > 0 THEN DelX = 1
    IF DelX < 0 THEN DelX = -1
END IF
COLOR 0, 0
CLS
COLOR 1, 1
LOCATE 1, 1: PRINT S$
FOR J = 1 TO 25
    LOCATE J, 1: PRINT CHR$(219);
    LOCATE J, 40: PRINT CHR$(219);
NEXT J
DEF SEG = &HB800
COLOR 7, 0
FOR J = 3 TO 17
    FOR I = 1 TO 12
        LOCATE J, I * 3
        IF a(J, I + 2) <> 0 THEN PRINT "{|}";
    NEXT
NEXT
IF G = 1 THEN
    G = 0
    COLOR 5
    LOCATE 8, 7
    PRINT "Bricks! ";
    COLOR 4
    PRINT "v. 2.01 written by"
    LOCATE 9, 5
    PRINT "Paul Brannan, November 12, 1992"
    COLOR 2
    LOCATE 11, 3
    PRINT "Make sure Caps and Num Lock are off."
END IF
DO
    COLOR 3, 1: LOCATE 1, 1: PRINT "Score"; Pts; "Ball"; Ball; "   High Score"; Score; "L=";
    IF Easy = 1 THEN PRINT "Easy";  ELSE PRINT "Hard";
    IF b < 1 THEN
        spd = spd - 500
        IF spd < 0 THEN spd = 0
        GOTO 20
    END IF
    FOR J = 1 TO spd: NEXT J
    IF pad THEN
        COLOR 3, 0
        LOCATE 25, 1: PRINT S$;
        COLOR 3, 4
        LOCATE 25, PX - 2: PRINT "     ";
    END IF
    IF X < 39 AND Y < 18 AND X > 2 AND Y > 2 THEN
        IF a(Y, X / 3) <> 0 THEN
            a(Y, X / 3) = 0
            IF Easy = 1 AND LI = 1 THEN
                DelY = -DelY
            ELSEIF Easy = 1 AND LI = 2 THEN
                DelY = -DelY
            ELSEIF LH = 3 THEN
                DelY = -1
            ELSEIF LH = 4 THEN
                DelY = 1
            END IF
            LOCATE Y, INT(X / 3) * 3
            COLOR 0, 0: PRINT "   ";
            X = X + DelX: Y = Y + DelY
            Snd = 500
            Pts = Pts + 1
            b = b - 1
            Brd = -1
        END IF
    END IF
    IF Y > 23 THEN
        DelY = -1: LH = 4: LI = 0
        IF X = PX - 1 THEN
            DelX = -1
            Snd = 1000
        ELSEIF X = PX + 1 THEN
            DelX = 1
            Snd = 1000
        ELSEIF X = PX THEN
            DelX = 0
            Snd = 500
        ELSEIF X = PX - 2 THEN
            DelX = -2
            Snd = 400
        ELSEIF X = PX + 2 THEN
            DelX = 2
            Snd = 400
        ELSEIF X = PX - 3 THEN
            DelX = -3
            Snd = 700
        ELSEIF X = PX + 3 THEN
            DelX = 3
            Snd = 700
        ELSE
            COLOR 3, 0
            LOCATE yold, 3, 0: PRINT " ";
            GOTO 1620
        END IF
    END IF
    IF X = 2 THEN DelX = -DelX: Snd = 600: LI = 1
    IF X = 39 THEN DelX = -DelX: Snd = 600: LI = 2
    IF Y = 2 THEN DelY = 1: Snd = 600: LH = 3: LI = 0
    X = xold + DelX
    Y = yold + DelY
    IF X > 39 THEN X = 39
    IF X < 2 THEN X = 2
    COLOR 14, 0
    LOCATE yold, xold: PRINT " ";
    LOCATE Y, X: PRINT "*";
    xold = X: yold = Y
    IF Snd THEN SOUND Snd, 2
    Snd = 0
LOOP
1620 KEY(12) OFF
     KEY(13) OFF
     KEY(15) OFF
     KEY(16) OFF
     KEY(17) OFF
     KEY(18) OFF
     FOR I = 2000 TO 400 STEP -100: SOUND I, 1: NEXT I
     DO UNTIL a$ = "": a$ = INKEY$: LOOP
     Ball = Ball - 1
     IF Ball < 0 THEN GOTO 7000
     LOCATE 25, 1
     PRINT "Press any key to restart";
     a$ = INPUT$(1)
     GOTO 210
1000 PX = PX - 2
     IF PX < 2 THEN PX = 38
     pad = -1
     RETURN
2000 PX = PX + 2
     IF PX > 38 THEN PX = 3
     pad = -1
     RETURN
3000 PX = PX - 1
     IF PX < 2 THEN PX = 38
     pad = -1
     RETURN
4000 PX = PX + 1
     IF PX > 38 THEN PX = 3
     pad = -1
     RETURN
5000 PX = PX - 4
     IF PX < 2 THEN PX = 38
     pad = -1
     RETURN
6000 PX = PX + 4
     IF PX > 38 THEN PX = 3
     pad = -1
     RETURN
7000 LOCATE 18, 3: PRINT "Your Score is"; Pts
     LOCATE 19, 3
     IF Pts = Score THEN PRINT "You have tied the highest score."
     IF Pts > Score THEN PRINT "You have the highest score so far.": Score = Pts
     IF Pts < Score THEN PRINT "The highest score so far is"; Score
     LOCATE 20, 3: PRINT "Do you wish to play again (Y/N)?"
     DO: a$ = UCASE$(INKEY$): LOOP UNTIL a$ = "N" OR a$ = "Y"
     IF a$ = "Y" THEN GOTO 10
     END
20000 IF Easy = 0 THEN Easy = 1 ELSE IF Easy = 1 THEN Easy = 0
      RETURN

