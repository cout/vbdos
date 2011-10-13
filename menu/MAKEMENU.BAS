100 ' MENUMAKE.BAS -- creates variable-sized menus -- Paul Somerson
110 ' (c) 1987 Ziff Communications Co.
120 '
130 ' --- Setup ---
140 '
150 KEY OFF:COLOR 2,0:CLS:DEFINT A-Z
160 DEF FNST$(Y)=RIGHT$(STR$(Y),LEN(STR$(Y))-SGN(Y)):S$=STRING$(2,32)
170 '
180 ' --- Ask user for size of menu, type of box ---
190 '
200 LINE INPUT "How many choices (2-26)? ",C$
210 C=VAL(C$):IF C<2 OR C>26 THEN BEEP:GOTO 200
220 PRINT "Single or Double line box (S/D)?:"
230 L$=INKEY$:IF L$="" THEN 230
240 B=INSTR("SsDd",L$):IF B=0 THEN BEEP:GOTO 220            
250 IF B<3 THEN P=218:Q=191:R=192:S=217:T=196:U=179:GOTO 300
260 P=201:Q=187:R=200:S=188:T=205:U=186                     
270 '
280 ' --- Open file and create top part of menu ---
290 '
300 PRINT "Now creating main MENU.BAT batch file..."
310 OPEN "MENU.BAT" FOR OUTPUT AS #1
320 PRINT #1,"ECHO OFF"
330 PRINT #1,":TOP"
340 PRINT #1,"ECHO";S$;CHR$(P);STRING$(76,T);CHR$(Q)
350 PRINT #1,"ECHO";S$;CHR$(U);SPC(33);"** MENU **";SPC(33);CHR$(U)
360 PRINT #1,"ECHO";S$;CHR$(U);SPC(76);CHR$(U)
370 '
380 ' --- Create menu choices ---
390 '
400 FOR A=1 TO CINT(C/2)
410 PRINT #1,"ECHO";S$;CHR$(U);S$;CHR$(A+64);SPC(2);STRING$(31,"X");
420 IF A<>CINT(C/2) THEN 440
430 IF CINT(C/2)<>C/2 THEN PRINT #1,SPC(40);CHR$(U):GOTO 450
440 PRINT #1,SPC(4);CHR$(C/2+A+64);SPC(2);STRING$(31,"X");S$;CHR$(U)
450 NEXT
460 '
470 ' --- Create bottom part of menu ---
480 '
490 PRINT #1,"ECHO";S$;CHR$(U);SPC(76);CHR$(U)
500 PRINT #1,"ECHO";S$;CHR$(U);SPC(14);"Enter a letter from A to ";
510 PRINT #1,CHR$(C+64);" (or type Esc to quit)";SPC(14);CHR$(U)
520 PRINT #1,"ECHO";S$;CHR$(R);STRING$(76,T);CHR$(S)
530 '
540 ' --- Create top part of tests ---
550 '
560 PRINT #1,":START"
570 PRINT #1,"GETLETR"
580 PRINT #1,"IF ERRORLEVEL ";FNST$(27);" GOTO END"
590 PRINT #1,"IF ERRORLEVEL ";FNST$(C+1);" GOTO START"
600 '
610 ' --- Create main cascade of tests ---
620 '
630 FOR A=C TO 2 STEP -1
640 PRINT #1,"IF ERRORLEVEL ";FNST$(A);" GOTO LABEL";CHR$(A+64)
650 NEXT
660 '
670 ' --- Create labels and dummy ECHOs ---
680 '
690 FOR A=1 TO C
700 PRINT #1,":LABEL";CHR$(A+64)
710 PRINT #1,"ECHO (this simulates menu choice ";CHR$(A+64);")"
720 PRINT #1,"PAUSE":PRINT #1,"GOTO TOP"
730 NEXT
740 PRINT #1,":END"
750 CLOSE
760 '
770 ' --- Create GETLETR.COM ---
780 '
790 PRINT "Now creating GETLETR.COM utility..."
800 TOTAL=0:FOR A=1 TO 34:READ B:TOTAL=TOTAL+B:NEXT
810 IF TOTAL<>3543 THEN PRINT "Check figures in last two lines":END
820 RESTORE:OPEN "GETLETR.COM" AS #1 LEN=1:FIELD #1,1 AS D$
830 FOR A=1 TO 34:READ A$:LSET D$=CHR$(VAL(A$)):PUT #1:NEXT
840 DATA 180,8,205,33,60,27,116,22,60,122,119,246,60,96,118,4,36
850 DATA 223,235,8,60,90,119,234,60,65,114,230,36,63,180,76,205,33
860 CLOSE:PRINT
870 '
880 ' --- Final message ---
890 '
900 PRINT "This created a batch file called MENU.BAT.  Use your"
910 PRINT "pure-ASCII word processor or EDLIN to replace the XXXXXXs"
920 PRINT "in the MENU.BAT menu with your real choices, then put your" 
930 PRINT "commands below the appropriate labels in the bottom half."
940 PRINT:PRINT "(Now hit a key to return to DOS and then type: MENU)"
950 WHILE INKEY$="":WEND:SYSTEM
