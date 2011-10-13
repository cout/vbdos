DECLARE FUNCTION VALUE@ (ST$)
DECLARE SUB push (VALU@)
DECLARE FUNCTION POP! ()
DECLARE SUB EXECUTE (c$)
COMMON SHARED BAAD, STCK(), TheData(), PSC, THESTR$
OPTION BASE 0
DIM STCK(26), TheData(26)
'$DYNAMIC
DIM SHARED Temp(32000)
STACK 20000
PSC = 1
KEY 15, CHR$(4) + CHR$(46)
KEY 16, CHR$(4) + CHR$(31)
KEY 17, CHR$(4) + CHR$(225)
KEY 18, CHR$(8) + CHR$(56)
ON KEY(1) GOSUB Break
ON KEY(15) GOSUB Break
ON KEY(16) GOSUB Break
ON KEY(17) GOSUB Break
ON KEY(18) GOSUB Break
KEY(1) ON
KEY(15) ON
KEY(16) ON
KEY(17) ON
KEY(18) ON
ON ERROR GOTO FOO
SCREEN 13
GOGO:
VIEW PRINT 23 TO 25
EXECUTE ("QT")
PRINT "Paul Brannan's Programming Language"
PRINT "PBPL Ready - Type HE for help"
ON ERROR GOTO GraphErr
Start:
DO WHILE UCASE$(A$) <> "QT"
KEY(0) OFF
LINE INPUT "?"; A$
KEY(0) ON
EXECUTE (UCASE$(A$))
ECTR = 0
LOOP
KEY(0) OFF
LINE INPUT "Quit interpreter (Y/N)?"; A$
KEY(0) ON
IF UCASE$(LEFT$(A$, 1)) <> "Y" THEN GOTO Start
SCREEN 0
WIDTH 80
END
FOO:
ON ERROR GOTO BAR
SCREEN 7
GOTO GOGO
BAR:
ON ERROR GOTO BAD3
SCREEN 1
GOTO GOGO
BAD3: ON ERROR GOTO BAD4
SCREEN 3
GOTO GOGO
BAD4: ON ERROR GOTO BADSCRN
SCREEN 4
GOTO GOGO
BADSCRN: PRINT "CGA, EGA, VGA, MCGA, Hercules,"
PRINT "AT&T or compatible required": END
INITERR: PRINT "INITIALIZATION ERROR": END
GraphErr:
ECTR = ECTR + 1
IF ECTR = 20 THEN
PRINT "UNRECOVERABLE ERROR" + SPACE$(65)
CLOSE
GOTO Start
END IF
RESUME NEXT
Break:
PRINT "Break!"
RETURN Start

REM $STATIC
SUB EXECUTE (c$)
KEY 15, CHR$(4) + CHR$(46)
KEY 16, CHR$(4) + CHR$(31)
KEY 17, CHR$(4) + CHR$(225)
KEY 18, CHR$(8) + CHR$(56)
ON KEY(1) GOSUB Break
ON KEY(15) GOSUB Break
ON KEY(16) GOSUB Break
ON KEY(17) GOSUB Break
ON KEY(18) GOSUB Break
KEY(1) ON
KEY(15) ON
KEY(16) ON
KEY(17) ON
KEY(18) ON
STATIC X, Y, DEG, CO, RDWX, TURTLE, PX, PY, MODE
DIM L(2)
PI = 3.141592654#
RDWX = RDWX + 1
IF RDWX = 1 THEN
    TURTLE = -1
    X = 160
    Y = 100
    DEG = 0
    CO = 3
    PX = 1
    PY = 1
END IF
IF MID$(c$, 2, 1) = "=" THEN
    c = ASC(MID$(c$, 1, 1)) - ASC("A")
    TheData(c) = VALUE@(RIGHT$(c$, LEN(c$) - 2))
NOERROR = 1
END IF
IF TURTLE = -1 THEN
    IF CO <> 1 THEN
        PSET (X, Y), 1
    ELSE
        PSET (X, Y), 2
    END IF
ELSE
    PSET (X, Y), 0
END IF
SELECT CASE LEFT$(c$, 2)
    CASE "CD"
        CHDIR RIGHT$(c$, LEN(c$) - 3)
    CASE "MD"
        MKDIR RIGHT$(c$, LEN(c$) - 3)
    CASE "CI"
        IF c$ <> "CI" THEN
            CIRCLE (X, Y), VALUE@(RIGHT$(c$, LEN(c$) - 3)), CO
        END IF
    CASE "LX"
        PX = VALUE@(RIGHT$(c$, LEN(c$) - 3))
    CASE "LY"
        PY = VALUE@(RIGHT$(c$, LEN(c$) - 3))
    CASE "RT"
        IF c$ <> "RT" THEN
            DEG = DEG + VALUE@(RIGHT$(c$, LEN(c$) - 3))
            WHILE DEG > 360: DEG = DEG - 360: WEND
        END IF
    CASE "LT"
        IF c$ <> "LT" THEN
            DEG = DEG - VALUE@(RIGHT$(c$, LEN(c$) - 3))
            WHILE DEG < 0: DEG = 360 + DEG: WEND
        END IF
    CASE "FD"
        IF c$ <> "FD" THEN
            PSET (X, Y), 0
            DRAW "C=" + VARPTR$(CO)
            DRAW "TA=" + VARPTR$(DEG)
            LENGTH = VALUE@(RIGHT$(c$, LEN(c$) - 3))
            DRAW "U=" + VARPTR$(LENGTH)
            X = POINT(0)
            Y = POINT(1)
        END IF
    CASE "MK", "TO"
        IF c$ <> "MK" THEN
            F = FREEFILE
            Q = INSTR(c$, "-")
            IF Q = 0 THEN
                Q = LEN(c$)
                OPEN MID$(c$, 4, Q - 2) FOR OUTPUT AS #F
            ELSE
                OPEN MID$(c$, 4, Q - 5) FOR OUTPUT AS #F
                PRINT #1, RIGHT$(c$, LEN(c$) - Q + 1)
            END IF
            WHILE A$ <> "QT"
                KEY(0) OFF
                LINE INPUT ":", A$
                KEY(0) ON
                A$ = UCASE$(A$)
                IF A$ <> "QT" THEN EXECUTE (A$)
                IF BAAD <> 1 THEN PRINT #F, A$
                BAAD = 0
            WEND
            CLOSE #F
        END IF
    CASE "GO", "RU"
        IF c$ <> "GO" AND c$ <> "TO" THEN
            F = FREEFILE
            Q = INSTR(c$, "-")
            IF Q = 0 THEN Q = LEN(c$)
            ON LOCAL ERROR GOTO FileErr
            OPEN MID$(c$, 4, Q - J) FOR INPUT AS #F
            ON LOCAL ERROR GOTO 0
            WHILE NOT EOF(F)
                INPUT #F, A$
                IF LEFT$(A$, 1) = "-" THEN
                    TheData(ASC(MID$(A$, 2)) - 65) = VALUE@(RIGHT$(c$, LEN(c$) - Q))
                ELSE
                    EXECUTE (A$)
                END IF
            WEND
            CLOSE #F
        END IF
    CASE "SX"
        PSET (X, Y), 0
        X = VALUE@(RIGHT$(c$, LEN(c$) - 3))
    CASE "SY"
        PSET (X, Y), 0
        Y = VALUE@(RIGHT$(c$, LEN(c$) - 3))
    CASE "SH"
        DEG = VALUE@(RIGHT$(c$, LEN(c$) - 3))
    CASE "MO"
        MODE = (VAL(RIGHT$(c$, LEN(c$) - 3)) - 1) * 6 + 1
        SCREEN MODE
        VIEW PRINT 23 TO 25
    CASE "ED"
        IF c$ <> "ED" THEN
            FL = FREEFILE
            OPEN "TMP" FOR OUTPUT AS #FL
                F = FREEFILE
                OPEN RIGHT$(c$, LEN(c$) - 3) FOR INPUT AS #F
                DO WHILE A$ <> "QT"
                    IF NOT EOF(F) THEN INPUT #F, B$
                    IF NOT EOF(F) THEN PRINT B$
                    KEY(0) OFF
                    LINE INPUT ":", A$
                    KEY(0) ON
                    IF A$ <> "" THEN
                        EXECUTE (A$)
                        IF BAAD <> 1 THEN WRITE #FL, A$
                    ELSE
                        EXECUTE (B$)
                        IF BAAD <> 1 THEN WRITE #FL, B$
                    END IF
                    BAAD = 0
                    IF B$ = "QT" AND A$ = "" THEN EXIT DO
                LOOP
            CLOSE F, FL
                KILL RIGHT$(c$, LEN(c$) - 3)
                SHELL "COPY TMP " + RIGHT$(c$, LEN(c$) - 3) + ">NUL"
                KILL "TMP"
        END IF
    CASE "IN"
        X$ = INPUT$(1)
        SELECT CASE X$
            CASE "0" TO "9"
                TheData(ASC(MID$(c$, 4, 1))) = (VAL(X$))
            CASE ELSE
                TheData(ASC(MID$(c$, 4, 1))) = (ASC(RIGHT$(c$, 1)))
        END SELECT
    CASE "GV"
        INPUT "-", X$
        TheData(ASC(MID$(c$, 4, 4))) = VALUE@(X$)
    CASE "PT"
        PSET (X, Y), CO
    CASE "IF"
        c = POP
        IF c = VALUE@(RIGHT$(c$, LEN(c$) - 3)) THEN
            push (c)
            push (1)
        ELSE
            push (c)
            push (0)
        END IF
    CASE "PV"
        EXECUTE ("PR " + STR$(VALUE@(RIGHT$(c$, LEN(c$) - 3))))
    CASE "PC"
        EXECUTE ("PR " + CHR$(VALUE@(RIGHT$(c$, LEN(c$) - 3))))
    CASE "PS"
        EXECUTE ("PR " + THESTR$)
    CASE "CR"
        EXECUTE ("PR " + CHR$(13))
    CASE "IS"
        P = POS(0)
        c = CSRLIN
        VIEW PRINT 1 TO 22
        LOCATE PY, PX
        INPUT "", THESTR$
        PX = POS(0)
        PY = CSRLIN
        VIEW PRINT 23 TO 25
        LOCATE c, P
        
    CASE "RE"
        IF c$ <> "RE" THEN
            CTR = 2
            WHILE T$ <> " "
                CTR = CTR + 1
                T$ = MID$(c$, CTR + 1, 1)
                TMP$ = TMP$ + T$
            WEND
            CTR = CTR + 1
            DCTR = CTR
            FOR J = 1 TO VALUE@(TMP$)
                CTR = DCTR
                DO UNTIL CTR >= LEN(c$)
                    T$ = ""
                    WHILE T$ <> ":" AND CTR <= LEN(c$)
                        CTR = CTR + 1
                        T$ = MID$(c$, CTR, 1)
                        TMP2$ = TMP2$ + T$
                    WEND
                    IF RIGHT$(TMP2$, 1) = ":" THEN TMP2$ = LEFT$(TMP2$, LEN(TMP2$) - 1)
                    PRINT TMP2$
                    IF LEFT$(TMP2$, 2) <> "RE" AND LEFT$(TMP2$, 2) <> "ED" AND TMP2$ <> "" THEN
                        EXECUTE (TMP2$)
                    END IF
                    TMP2$ = ""
                LOOP
            NEXT J
        END IF
    CASE "SD"
        SOUND VALUE@(RIGHT$(c$, LEN(c$) - 3)), 10
    CASE "PR"
        P = POS(0)
        c = CSRLIN
        VIEW PRINT 1 TO 22
        LOCATE PY, PX
        PRINT RIGHT$(c$, LEN(c$) - 3);
        PX = POS(0)
        PY = CSRLIN
        VIEW PRINT 23 TO 25
        LOCATE c, P
    CASE "CL"
        VIEW PRINT 1 TO 22
        CLS
        VIEW PRINT 23 TO 25
        TURTLE = -1
        RDWX = 0
    CASE "HO"
        RDWX = 0
    CASE "ST"
        TURTLE = -1
    CASE "HT"
        TURTLE = 0
    CASE "CO"
        CO = VALUE@(RIGHT$(c$, LEN(c$) - 3))
        IF MODE <> 1 THEN COLOR CO
    CASE "QT"
    CASE "HE"
        GET (0, 0)-(319, 175), Temp
        VIEW PRINT 1 TO 25
        LOCATE 1, 1
        PRINT "CI - Circle          IS - Input String"
        PRINT "PT - Point           PR - Print"
        PRINT "LX - Locate X        SD - Sound"
        PRINT "LY - Locate Y        RE - Repeat"
        PRINT "SX - Set X           CL - Clear"
        PRINT "SY - Set Y           HO - Home"
        PRINT "SH - Set heading     ST - Show turtle"
        PRINT "RT - Right           HT - Hide turtle"
        PRINT "LT - Left            CO - Color"
        PRINT "MO - Screen mode     QT - Quit"
        PRINT "FD - Forward         HE - Help"
        PRINT "IF - If (decision)   MK - Make program"
        PRINT "PV - Print value     TO - Make Program"
        PRINT "PC - Print character GO - Go (RUN)"
        PRINT "PS - Print string    RU - Run program"
        PRINT "IN - Input value     ED - Edit prigram"
        PRINT "CD - Change dir      MD - Make dir"
        PRINT "GV - Get value"
        PRINT "Press a key to continue..."
        DO WHILE INKEY$ = "": LOOP
        EXECUTE "CL"
        VIEW PRINT 23 TO 25
        PUT (0, 0), Temp, PSET
    CASE ""
    CASE ELSE
        NE = 1
        ON LOCAL ERROR GOTO FNF
        F2 = FREEFILE
        OPEN c$ FOR INPUT AS #F2
        CLOSE #F2
        IF NE = 1 THEN
            EXECUTE "GO " + c$
        ELSEIF NOERROR <> 1 THEN
            SOUND 600, .5
            SOUND 500, .5
            PRINT "INVALID COMMAND!"
            BAAD = 1
        END IF
    END SELECT
IF RDWX = 1 THEN
    TURTLE = -1
    X = 160
    Y = 100
    DEG = 0
    CO = 3
END IF
EXIT SUB
FileErr:
J = J + 1
IF J = LEN(c$) THEN
    PRINT "File not found"
    ON ERROR GOTO GraphErr
    RESUME BadFile
END IF
RESUME
BadFile: EXIT SUB
FNF: NE = 0: RESUME NEXT
END SUB

FUNCTION POP ()
POP = STCK(PSC)
PSC = PSC - 1
IF PSC < 1 THEN PSC = 1
END FUNCTION

SUB push (VALU@)
PSC = PSC + 1
IF PSC > 20 THEN
    PSC = 20
    EXIT SUB
END IF
STCK(PSC) = VALU@
END SUB

FUNCTION VALUE@ (ST$)
    DO WHILE COUNTER <= LEN(ST$)
        IF COUNTER > LEN(ST$) THEN EXIT DO
        CTR = CTR + 1
        COUNTER = COUNTER + 1
        CH$ = UCASE$(MID$(ST$, COUNTER, 1))
        Temp = 0
BGN:
        IF CH$ >= "0" AND CH$ <= "9" THEN
            WHILE CH$ >= "0" AND CH$ <= "9"
                Temp = 10 * Temp + VAL(CH$)
                COUNTER = COUNTER + 1
                CH$ = MID$(ST$, COUNTER, 1)
            WEND
            CH$ = MID$(ST$, COUNTER, 1)
            IF CH$ >= "0" AND CH$ <= "9" THEN GOTO BGN
            push (Temp)
        END IF
        IF CH$ >= "A" AND CH$ <= "Z" THEN push (TheData(ASC(CH$) - 65))
        IF CTR = 1 THEN X = POP
        SELECT CASE CH$
            CASE "+": F = 1
            CASE "-": F = 2
            CASE "*": F = 3
            CASE "/": F = 4
            CASE "\": F = 5
            CASE "<": F = 6
            CASE "=": F = 7
            CASE ">": F = 8
            CASE "!": F = 9
        END SELECT
        IF CTR <> 1 THEN
            SELECT CASE F
                CASE 1: X = X + POP
                CASE 2: X = X - POP
                CASE 3: X = X * POP
                CASE 4
                    L = POP
                    IF L <> 0 THEN
                        push (L)
                        X = X / POP
                    ELSE
                        push (L)
                    END IF
                CASE 5
                    L = POP
                    IF L <> 0 THEN
                        push (L)
                        X = X MOD POP
                    ELSE
                        push (L)
                    END IF
                CASE 6: X = X < POP
                CASE 7: X = X = POP
                CASE 8: X = X > POP
                CASE 9: X = X <> POP
            END SELECT
        END IF
    LOOP
    VALUE@ = X
    FOR J = 1 TO 20
        T = POP
    NEXT J
END FUNCTION

