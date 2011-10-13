rpt = 0
ld = INT(RND(1) * 360)
DIM e$(1000)
DIM a$(7), c$(7)
70 CLS
RANDOMIZE TIMER
q$ = "---------------------"
uflag = 1
eflag = 0
ang = 0: takeov = 0: land = 0
airspeed = 0
dist = 0
altimeter = 0
elevate = 0
wa = 0
fuel = 750: crash = 0: f2 = 0: f1 = 0
x$ = ""
DO WHILE crash = 0
90 GOSUB 500
IF ABS(INT(wa + .5)) = 3 THEN
    a$(1) = "           *  "
    a$(2) = "          **  "
    a$(3) = "        **    "
    a$(4) = "      **      "
    a$(5) = "    **        "
    a$(6) = "  **          "
    a$(7) = "**            "
ELSEIF ABS(INT(wa + .5)) = 2 THEN
    a$(1) = "              "
    a$(2) = "           ** "
    a$(3) = "        ***   "
    a$(4) = "     ***      "
    a$(5) = "  ***         "
    a$(6) = "***           "
    a$(7) = "              "
ELSEIF ABS(INT(wa + .5)) = 1 THEN
    a$(1) = "              "
    a$(2) = "              "
    a$(3) = "         *****"
    a$(4) = "   ******     "
    a$(5) = "****          "
    a$(6) = "              "
    a$(7) = "              "
ELSEIF INT(wa + .5) = 0 THEN
    a$(1) = "              "
    a$(2) = "              "
    a$(3) = "              "
    a$(4) = "**************"
    a$(5) = "              "
    a$(6) = "              "
    a$(7) = "              "
END IF
IF wa > 0 THEN wa = wa - .2
IF wa < 0 THEN wa = wa + .2
IF NOT (wa > .2) THEN
    FOR z = 1 TO 7
        m$(8 - z) = a$(z)
    NEXT z
    FOR z = 1 TO 7
        a$(z) = m$(z)
    NEXT z
END IF
f2 = ang = f1
IF f2 < 0 THEN fa = INT((f2 + 375) / 30)
IF f2 >= 0 THEN fa = INT((f2 + 15) / 30)
IF fa = 12 THEN fa = 0
c$(1) = "   .N.  "
IF fa = 11 THEN
    c$(2) = "  .@:.. "
ELSEIF fa = 0 THEN
    c$(2) = "  ..@.. "
ELSEIF fa = 1 THEN
    c$(2) = "  ..:@. "
ELSE
    c$(2) = "  ..:.. "
END IF
IF fa = 10 THEN
    c$(3) = " .@ : .."
ELSEIF fa = 2 THEN
    c$(3) = " .. : @."
ELSE
    c$(3) = " .. : .."
END IF
IF fa = 9 THEN
    c$(4) = " W@-X--E"
ELSEIF fa = 3 THEN
    c$(4) = " W--X-@E"
ELSE
    c$(4) = " W--X--E"
END IF
IF fa = 8 THEN
    c$(5) = " .@ : .."
ELSEIF fa = 4 THEN
    c$(5) = " .. : @."
ELSE
    c$(5) = " .. : .."
END IF
IF fa = 7 THEN
    c$(6) = "  .@:.. "
ELSEIF fa = 6 THEN
    c$(6) = "  ..@.."
ELSEIF fa = 5 THEN
    c$(6) = "  ..:@. "
ELSE
    c$(6) = "  ..:.. "
END IF
c$(7) = "   .S.  "
IF ang > 360 THEN ang = ang - 360
f2 = ang
IF w > 0 THEN w = w - .4
IF w < 0 THEN w = w + .4
IF land = 1 AND uflag = 1 THEN PRINT "Well done.  A perfect landing!!": END
IF land = 1 AND uflag = 0 THEN PRINT "Your wheels are up": GOSUB 1780: GOTO 90
t = airspeed: stall = 0
140 x$ = UCASE$(INKEY$)
IF x$ = "1" THEN
    IF uflag = 1 THEN
        uflag = 0
    ELSEIF uflag = 0 THEN
        uflag = 1
    END IF
END IF
IF x$ = "R" THEN rpt = 1: GOTO 70
IF rpt = 1 AND e$(clock + 1) = "" THEN rpt = 0: GOTO 140
IF x$ = "" THEN 140
IF clock < 999 THEN x$ = e$(clock + 1)
IF takeov = 1 THEN elevate = INT(elevate + RND(1) * 2 - RND(1) * 3)
IF NOT (airspeed < 3) THEN
    IF x$ = "Q" THEN
        elevate = elevate + 5
        eflag = 5
        IF elevate > 60 THEN stall = 1
    ELSEIF x$ = "A" THEN
        elevate = elevate - 5
        eflag = -5
        IF elevate < -70 THEN stall = -1
    END IF
    IF stall <> 0 THEN
        IF stall <> -1 THEN
            FOR j = 1 TO 10
                PRINT TAB(j); "You have stalled!"
            NEXT j
            airspeed = airspeed / 4
        ELSE
            FOR j = 1 TO 10
                PRINT "Uncontrolled dive!!"
                PRINT TAB(21 - j); "Pull Up!!"
            NEXT j
            altimeter = 4 * altimeter / 5
        END IF
    END IF
    IF NOT (altimeter < 1) THEN
        IF x$ = "Z" THEN
            wa = wa - .5
            ang = ang - 6
            IF wa < -3 THEN wa = -3
        ELSEIF x$ = "M" THEN
            wa = wa + .5
            ang = ang + 6
            IF wa > 3 THEN wa = 3
        END IF
    END IF
END IF
ang = INT(ang + RND(1) * 2 - RND(1) * 2)
IF x$ = " " THEN airspeed = airspeed + 8.5
IF x$ = "." THEN airspeed = airspeed - 7
airspeed = airspeed - elevate / 5
IF uflag = 1 THEN
    airspeed = airspeed - 1
    fuel = fuel - .5
END IF
IF airspeed < 0 THEN airspeed = 0
IF airspeed > 400 THEN airspeed = 400
fuel = fuel - (ABS(t - airspeed) / 10) - 3.75
IF fuel < 1 THEN GOSUB 1780
IF takeov <> 1 THEN
    IF elevate > 10 AND airspeed > 45 AND airspeed < 60 AND uflag = 1 THEN takeov = 1
    IF takeov <> 0 AND takeov <> 1 THEN altimeter = 0: GOTO 450
END IF
IF land = 0 AND airspeed < 30 THEN elevate = elevate - 5: altimeter = 9 * altimeter / 10
altimeter = altimeter + INT((elevate + .1) * airspeed / 1000) / 80
IF altimeter < 300 AND takeov = 1 THEN altimeter = altimeter + airspeed / 30 + elevate
450 IF altimeter < 0 THEN GOSUB 1780
IF altimeter > 15 AND airspeed > 20 OR takeov = 0 THEN 90
IF ABS(ang - ld) < 13 OR ABS(ang + 360 - ld) < 13 THEN land = 1: GOTO 90
LOOP
IF crash = 1 THEN END
500 CLS
    PRINT "   Horizon"; TAB(20); "Heading"
    ev = INT(elevate / 10)
    IF ev > 2 THEN ev = 2
    IF ev < -2 THEN ev = -2
    IF ev <> 0 AND takeov = 1 AND crash = 0 THEN
        g$ = "              "
        ON ev + 3 GOSUB 1960, 2020, 2070, 2080, 2140
    END IF
    PRINT ":---------------:---------:"
    FOR j = 1 TO 7
        PRINT ": "; a$(j); " :"; c$(j); " :"
        a$(j) = ""
    NEXT j
    PRINT ":-------------------------:"
    dist = dist + ABS((COS(elevate)) * airspeed) / 360
    clock = clock + 1
    PRINT "Range"; INT(dist * 10) / 10; ": Time"; INT(clock) / 10; ":"; ld
    PRINT ":-------------------------:"
    PRINT ":Airspeed :"; INT(airspeed)
    PRINT ":"; LEFT$(q$, INT(airspeed / 20)); ">"
    PRINT "Altimeter:"; INT(altimeter);
    IF ang < 0 THEN PRINT TAB(19); 360 + ang; "Deg."
    IF ang >= 0 THEN PRINT TAB(19); ang; "Deg."
    mr = INT(altimeter / 30): IF mr > 20 THEN mr = 20
    PRINT ":"; LEFT$(q$, mr); ">"
    PRINT ":Fuel      :"; INT(fuel)
    PRINT ":"; LEFT$(q$, 20 - INT(fuel / 750)); ">"
    PRINT ":-------------------------:"
    PRINT "Elevation:"; elevate; ": "; : GOSUB 2210: PRINT u$
    IF uflag = 1 THEN PRINT ":"; TAB(5); "> Undercarriage Down < :"
    IF uflag <> 1 THEN PRINT ":"; TAB(6); "> Undercarriage Up <   :"
    IF crash = 1 THEN END
    RETURN

RETURN
1960 FOR j = 1 TO 4
        a$(j) = a$(j + 3)
     NEXT j
     a$(5) = g$: a$(6) = g$: a$(7) = g$
     RETURN
2020 FOR j = 1 TO 6
        a$(j) = a$(j + 1)
     NEXT j
     a$(7) = g$
     RETURN
2070 RETURN
2080 FOR j = 6 TO 1 STEP -1
        a$(j + 1) = a$(j + 3)
     NEXT j
     a$(1) = g$
     RETURN
2140 FOR j = 4 TO 1 STEP -1
        a$(j + 3) = a$(j)
     NEXT j
     a$(1) = g$: a$(2) = g$: a$(3) = g$
     RETURN
1780 crash = 1
     altimeter = 0
     m$ = "** *C R**  A ** S* H* !!*"
     FOR j = 1 TO 20
        PRINT TAB(j); "CRASH!"
        PRINT TAB(21 - j); "CRASH!"
     NEXT j
     FOR j = 1 TO 7
        g = INT(RND(1) * 11) + 1
        a$(j) = MID$(m$, g, 14)
     NEXT j
     RETURN
2210 u$ = "-------"
     IF x$ = " " THEN u$ = "Throttle On"
     IF x$ = "." THEN u$ = "Throttle Off"
     IF x$ = "Q" AND altimeter > 0 THEN u$ = "Climb"
     IF x$ = "Q" AND altimeter = 0 THEN u$ = "Nose Up"
     IF x$ = "A" THEN u$ = "Nose Down"
     IF x$ = "Z" THEN u$ = "Bank Left"
     IF x$ = "M" THEN u$ = "Bank Right"
     RETURN

