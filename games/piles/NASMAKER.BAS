DEFLNG A-Z
SCREEN 12
'$DYNAMIC
DIM a(255)
DIM filebyte(640)
DIM Pic(16383)

top:
OPEN COMMAND$ FOR BINARY AS #1

FOR i = 0 TO 53
    a$ = INPUT$(1, #1)
    filebyte(i) = ASC(a$)
NEXT i

height = filebyte(22) + 256 * filebyte(23)
wid = INT(((filebyte(2) + filebyte(3) * 256 + filebyte(4) * 65536 - 110) / height) * 2)
tilewid = filebyte(18) + 256 * filebyte(19)
colors = (2 ^ filebyte(28))
IF colors <> 16 OR wid > 640 OR height > 480 THEN END
col(0) = 65536: col(1) = 256: col(2) = 1: col(3) = 0

J = col(3)
FOR i = 0 TO 255
    a(i) = J
NEXT i

FOR i = 1 TO (4 * colors)
    a$ = INPUT$(1, #1)
    a(INT(J / 4)) = a(INT(J / 4)) + (col(J AND 3) * (INT(ASC(a$) / 4)) AND (col(J AND 3) * 63))
    J = J + 1
NEXT i

indent = (640 - wid) / 2: i = indent: J = (480 - height) / 2
PALETTE USING a(0)

WHILE NOT EOF(1)
    a$ = INPUT$(wid, #1)
    FOR i = 2 TO INT(wid / 2) STEP 2
        i = i - 1
        a1$ = MID$(a$, i, 1)
        a2$ = MID$(a$, i + INT(wid / 2), 1)
        IF a2$ = "" THEN a2$ = CHR$(0)
        a2 = ASC(a2$)
        IF a1$ = "" THEN a1$ = CHR$(0)
        a1 = ASC(a1$)
        C(1) = (a1 AND 240) / 16
        C(2) = a1 AND 15
        C(3) = (a2 AND 240) / 16
        C(4) = a2 AND 15
        FOR Q = 1 TO 4
            IF C(Q) = 7 THEN
                C(Q) = 7
            ELSEIF C(Q) = 0 THEN
            ELSEIF C(Q) = 8 THEN
                C(Q) = 8
            END IF
        NEXT Q
        PRESET ((i * 2) - 2, 480 - J), C(1)
        PRESET ((i * 2) - 1, 480 - J), C(2)
        PRESET ((i * 2), 480 - J), C(3)
        PRESET ((i * 2) + 1, 480 - J), C(4)
        i = i + 1
        a1$ = MID$(a$, i, 1)
        a2$ = MID$(a$, i + INT(wid / 2), 1)
        IF a2$ = "" THEN a2$ = CHR$(0)
        a2 = ASC(a2$)
        IF a1$ = "" THEN a1$ = CHR$(0)
        a1 = ASC(a1$)
        C(1) = (a1 AND 240) / 16
        C(2) = a1 AND 15
        C(3) = (a2 AND 240) / 16
        C(4) = a2 AND 15
        FOR Q = 1 TO 4
            IF C(Q) = 7 THEN
                C(Q) = 7
            ELSEIF C(Q) = 0 THEN
            ELSEIF C(Q) = 8 THEN
                C(Q) = 8
            END IF
        NEXT Q
        PRESET ((i * 2) - 2, 480 - J), C(1)
        PRESET ((i * 2) - 1, 480 - J), C(2)
        PRESET ((i * 2), 480 - J), C(3)
        PRESET ((i * 2) + 1, 480 - J), C(4)
        IF i >= (wid / 2) + indent THEN
            i = indent
            J = J + 1
            flag = 1
        END IF
    NEXT i
    IF flag <> 1 THEN
        i = indent
        J = J + 1
    ELSE
        flag = 0
    END IF
WEND
CLOSE

a$ = INPUT$(1)
GET (0, 227)-(319, 426), Pic(0)
SCREEN 7
PUT (0, 0), Pic(0)

a$ = INPUT$(1)
OPEN "NewPiles.NAS" FOR OUTPUT AS #1
FOR J = 0 TO 8192
    PRINT #1, Pic(J)
NEXT J
CLOSE

a$ = INPUT$(1)
OPEN "NewPiles.NAS" FOR INPUT AS #1
FOR J% = 0 TO 8192
    INPUT #1, Pic(J%)
NEXT J%
CLS
PUT (0, 0), Pic(0)
CLOSE

