OPTION EXPLICIT
DIM in  AS STRING * 1
DIM tmp AS STRING * 1
OPEN COMMAND$ FOR BINARY AS #1
WHILE NOT EOF(1)
    GET #1, , in
    IF in >= "0" AND in <= "}" THEN
        tmp = in
        GET #1, , in
        IF in >= "0" AND in <= "}" THEN
            PRINT tmp;
            WHILE in >= " " AND in <= "}"
                PRINT in;
                GET #1, , in
            WEND
        PRINT
        END IF
    END IF
WEND

