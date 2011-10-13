DEFINT A-Z
DIM starx(20), stary(20), starm(20), ship(900)
DIM enemy(32), shot(4), enx(20), eny(20), enflag(20)
level = 7
enemies = level
SCREEN 1
    LINE (20, 0)-(23, 0), 1
    LINE -(28, 5), 1
    LINE (20, 0)-(20, 3), 1
    LINE -(22, 5), 1
    LINE (20, 5)-(40, 6), 1
    LINE -(50, 9), 1
    LINE -(35, 9), 1
    LINE -(25, 15), 1
    LINE -(30, 8), 1
    LINE (37, 9)-(42, 12), 1
    LINE -(32, 10), 1
    LINE (28, 9)-(22, 9), 1
    LINE -(19, 8), 1
    LINE (20, 7)-(18, 7), 1
    LINE -(20, 5), 1
    LINE (29, 13)-(33, 13)
    LINE (40, 11)-(44, 11)
    LINE (5, 6)-(15, 6), 2
    LINE (6, 8)-(16, 8), 2
GET (0, 0)-(60, 30), ship
CLS
LINE (2, 0)-(2, 7), 1
LINE (4, 0)-(4, 7), 1
LINE (6, 0)-(6, 7), 1
LINE (0, 2)-(7, 2), 2
LINE (0, 4)-(7, 4), 2
GET (0, 0)-(7, 7), enemy
LINE (0, 0)-(7, 0), 2
GET (0, 0)-(7, 0), shot
CLS
FOR j = 1 TO 20
    starx(j) = INT(300 * RND)
    stary(j) = j * 10 + INT(10 * RND) - 4
    starm(j) = INT(5 * RND) + 1
NEXT j
FOR j = 1 TO level
    enx(j) = INT(150 * RND) + 150
    eny = (j * 1000 / level) * 19
    PUT (enx(j), eny(j)), enemy
    enflag(j) = 1
NEXT j
px = 0
py = 89
pxo = px
pyo = py
PUT (px, py), ship
DO
    LOCATE 1, 1
    PRINT score
    PUT (pxo, pyo), ship
    FOR j = 1 TO level
        IF enflag(j) <> 0 THEN PUT (enx(j), eny(j)), enemy
    NEXT j
    FOR j = 1 TO 20
        PSET (starx(j), stary(j)), 0
    NEXT j
    pyo = py: pxo = px
    FOR j = 1 TO 20
        starx(j) = starx(j) - starm(j)
        IF starx(j) < 0 THEN
            starx(j) = 300
            starm(j) = INT(5 * RND) + 1
        END IF
        PSET (starx(j), stary(j)), 3
    NEXT j
    PUT (px, py), ship
    FOR j = 1 TO level
        IF enflag(j) = 1 THEN
            enx(j) = enx(j) + (INT(3 * RND) - 1) * 3
            eny(j) = eny(j) + (INT(3 * RND) - 1) * 3
            IF eny(j) < 0 THEN eny(j) = 190
            IF eny(j) > 190 THEN eny(j) = 0
            IF enx(j) < 0 THEN enx(j) = 0
            IF enx(j) > 300 THEN enx(j) = 300
            IF enx(j) > shotx AND enx(j) - 8 < shotx THEN
                IF eny(j) + 8 > shoty AND eny(j) - 4 < shoty THEN
                    enflag(j) = 0
                    score = score + 5
                    shotflag = 0
                    PUT (shotx, shoty), shot
                    enemies = enemies - 1
                END IF
            END IF
            IF enx(j) > px AND px(j) + 60 < px THEN
                IF eny(j) + 15 > py AND eny(j) - 15 < py THEN
                    SOUND 50, 1
                    SOUND 100, 1
                    SOUND 200, 1
                    SOUND 100, 1
                    SOUND 50, 1
                    FOR i = 1 TO 5
                        SOUND 50 + i, 1
                    NEXT i
                    dflag = 1
                END IF
            END IF
            IF enflag(j) <> 0 THEN PUT (enx(j), eny(j)), enemy
        END IF
    NEXT j
    SELECT CASE INKEY$
        CASE "8"
            py = py - 4
            IF py < 0 THEN py = 169
        CASE "2"
            py = py + 4
            IF py > 169 THEN py = 1
        CASE "4"
            px = px - 6
            IF px < 0 THEN px = 0
        CASE "6"
            px = px + 6
            IF px > 260 THEN px = 260
        CASE " "
            IF shotflag = 1 THEN PUT (shotx, shoty), shot
            shotflag = 1
            shotx = px + 60
            shoty = py + 15
            PUT (shotx, shoty), shot
    END SELECT
    IF shotflag = 1 THEN
        PUT (shotx, shoty), shot
        shotx = shotx + 4
        IF shotx > 300 THEN
            shotflag = 0
        ELSE
            PUT (shotx, shoty), shot
        END IF
    END IF
    IF enemies < 1 THEN
        level = level + 1
        score = score * 3
        enemies = level
        FOR j = 1 TO level
            enx(j) = INT(150 * RND) + 150
            eny = (j * 1000 / level) * 19
            PUT (enx(j), eny(j)), enemy
            enflag(j) = 1
        NEXT j
    END IF
LOOP WHILE dflag = 0
LOCATE 2, 1
PRINT "Play again (Y/N)?"
top:
a$ = ""
DO WHILE a$ = "": a$ = INKEY$: LOOP
IF UCASE$(a$) = "Y" THEN RUN
IF UCASE$(a$) = "N" THEN END
SOUND 600, 2
SOUND 500, 2
GOTO top

