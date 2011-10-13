    DEFINT A-Z
    maxmenus = 10: maxitems = 10
    DIM mtitle$(maxmenus, maxitems), mflags(maxmenus, maxitems), mitems(maxmenus), msave(800 * maxitems + 8), mx(maxmenus): topid = 0: menuinit = -1
    ega = 0: ON ERROR GOTO 150: SCREEN 7: ega = -1
150 IF NOT ega THEN RESUME 160
160 ON ERROR GOTO 0
    DIM arrow(32), zztemp(648)
    XMax = 250: ymax = 230: xoff = 7: yoff = 7
    highlight = 2
    true = -1: false = NOT true: cursor = true
    SCREEN 0, 0, 0: WIDTH 40: COLOR , 1, 1: CLS : LOCATE 4, 11, 0: COLOR 12: PRINT "SCREEN MACHINE II"
    COLOR 14: LOCATE 13, 10: PRINT "One moment please..."
    GOSUB 9000
    smode = 5: colr = 1: GOSUB 3000
    sndfx = true
    acc = 1: dacc = 5
    frozen = 0
    colr = 1: tool = 1
    mx = XRes / 2: my = yres / 2: nx = mx: ny = my: GOSUB 18000
    DIM undo(15000)
    WHILE true
     GOSUB 18000: mb = 0: mnid = 0
     WHILE mnid = 0 AND mb = 0
      GOSUB 14000
     WEND
     IF mb <> 0 THEN GOSUB 1000
     IF mnid THEN GOSUB 2000
    WEND
1000 WHILE mb: GOSUB 20000: WEND
     GOSUB 19000
     IF my > cy THEN colr = INT(mx / xrs): GOSUB 6000: RETURN
     GET (1, 8)-(XRes - 2, cy - 1), undo
     scm$ = cm$: cm$ = ""
     ON tool GOSUB 1070, 1170, 1300, 1430, 1560, 1630
     cm$ = scm$
     RETURN
1070 IF penup AND NOT keymode THEN RETURN
     cursor = 0
     WHILE mb = 0 AND (NOT penup OR keymode)
      sx = mx: sy = my: GOSUB 20000: my = -my * (my > 7 AND my < cy) - 8 * (my < 8) - (cy - 1) * (my >= cy)
      LINE (sx, sy)-(mx, my), colr
     WEND
     WHILE mb: GOSUB 20000: WEND
     cursor = true
     RETURN
1170 sx = mx: sy = my: cursor = 0
     WHILE mb = 0
      LINE (sx, sy)-(mx, my), 0
      GOSUB 20000: my = -my * (my > 7 AND my < cy) - 8 * (my < 8) - (cy - 1) * (my >= cy)
      LINE (sx, sy)-(mx, my), colr
      ex = mx: ey = my
     WEND
     WHILE mb: GOSUB 20000: WEND
     PUT (1, 8), undo, PSET
     LINE (sx, sy)-(ex, ey), colr
     cursor = true
     RETURN
1300 sx = mx: sy = my: cursor = 0
     WHILE mb = 0
      LINE (sx, sy)-(mx, my), 0, B
      GOSUB 20000: my = -my * (my > 7 AND my < cy) - 8 * (my < 8) - (cy - 1) * (my >= cy)
      LINE (sx, sy)-(mx, my), colr, B
      ex = mx: ey = my
     WEND
     WHILE mb: GOSUB 20000: WEND
     PUT (1, 8), undo, PSET
     LINE (sx, sy)-(ex, ey), colr, B
     cursor = true
     RETURN
1430 sx = mx: sy = my: cursor = 0
     WHILE mb = 0
     CIRCLE (sx, sy), SQR(ABS(sx - mx) ^ 2 + ABS(sy - my) ^ 2), 0
      GOSUB 20000: my = my * (my > 7 AND my < cy) - 8 * (my < 8) - (cy - 1) * (my >= cy)
     CIRCLE (sx, sy), SQR(ABS(sx - mx) ^ 2 + ABS(sy - my) ^ 2), colr
      ex = mx: ey = my
     WEND
     WHILE mb: GOSUB 20000: WEND
     GOSUB 3000: PUT (1, 8), undo, PSET
     CIRCLE (sx, sy), SQR(ABS(sx - ex) ^ 2 + ABS(sy - ey) ^ 2), colr
     cursor = true: GOSUB 12000: GOSUB 6000
     RETURN
1560 WHILE mb = 0 AND (NOT penup OR keymode)
      GOSUB 20000: IF my = 12 OR my > cy - 5 THEN 1590
      GOSUB 19000: PSET (mx + 4 - 8 * RND, my + 4 - 8 * RND), colr
1590 WEND
     WHILE mb: GOSUB 20000: WEND
     RETURN
1630 ON ERROR GOTO 1660: PAINT (mx, my), colr: LINE (0, 0)-(XRes - 1, yres - 1), , B: GOSUB 20000
     ON ERROR GOTO 0: WHILE mb: GOSUB 20000: WEND
     RETURN
1660 RESUME NEXT
2000 ON mnid GOSUB 2030, 2320, 2390
     RETURN
2030 ON mnit GOSUB 2060, 2080, 2100, 2170, 2240, 2300
     RETURN
2060 GOSUB 19000: PUT (1, 8), undo, PSET: RETURN
2080 GOSUB 3000: RETURN
2100 REM Open file
     RETURN
2170 REM Save file
     RETURN
2240 GOSUB 19000: cursor = 0
     GET (1, 8)-(XRes - 2, cy - 1), undo: CLS : PUT (1, 8), undo, PSET
     WHILE mb = 0: GOSUB 20000: WEND
     WHILE mb: GOSUB 20000: WEND
     GOSUB 3000: PUT (1, 8), undo, PSET: cursor = -1: RETURN
2300 SCREEN 0, 0, 0, 0: END
2320 mflags(mnid, tool) = 1
     mflags(mnid, mnit) = 2: tool = mnit
     RETURN
     STOP
     IF mnit < 4 THEN smode = mnit: IF smode = 3 THEN smode = 5: GOSUB 3000
2390 IF mnit = 4 THEN COLOR , 1: mflags(mnid, 4) = 2: mflags(mnid, 5) = 1
     IF mnit = 5 THEN COLOR , 2: mflags(mnid, 4) = 1: mflags(mnid, 5) = 2
     IF mnit = 6 THEN bg = (bg + 1) AND 15: IF smode = 1 THEN COLOR bg ELSE COLOR , bg
     IF mnit = 7 THEN frozen = NOT frozen: mflags(mnid, mnit) = 1 - frozen
     IF mnit <> 8 THEN RETURN
     GOSUB 19000: LOCATE 1, 1: msg$ = LEFT$("Move stick to upper left, press nutton." + SPACE$(80), swidth): GOSUB 13000
     WHILE STRIG(1) = 0: xoff = STICK(0): yoff = STICK(1): WEND
     WHILE STRIG(1) <> 0: WEND
     LOCATE 1, 1: msg$ = LEFT$("Move stick to lower right, press button." + SPACE$(80), swidth): GOSUB 13000
     WHILE STRIG(1) = 0: XMax = STICK(0): WHILE STRIG(1) <> 0: WEND
     XMax = STICK(1): WEND
     xratio@ = XRes / XMax: yratio@ = yres / ymax
     GOSUB 12000: RETURN
3000 GOSUB 19000
     IF smode = pmode THEN 3030
     ON smode GOSUB 3110, 3150, 3030, 3030, 3190
3030 pmode = smode
     xrs = XRes / MaxColor
     swidth = INT(XRes / 8): xratio@ = XRes / XMax: yratio@ = yres / ymax
     CLS : PSET (10, 10): DRAW "bm10,10d3e313f5": GET (10, 10)-(17, 17), arrow
     xarrow = 8: yarrow = 8
     CLS : LINE (0, 0)-(XRes - 1, yres - 1), , B
     GOSUB 6000: GOSUB 12000
     RETURN
3110 SCREEN 1: COLOR 0, 1: colr = 1: XRes = 320: yres = 200: bg = 0: MaxColor = 4
     GOSUB 3230: mflags(3, 1) = 2: segadr = &HB800: scrlen = 16384
     mflags(3, 4) = 2: mfalgs(3, 5) = 1: mflags(3, 6) = 1
     RETURN
3150 SCREEN 2: XRes = 640: yres = 200: MaxColor = 2: colr = 1
     GOSUB 3230: mflags(3, 5) = 0: mfalgs(3, 6) = 1
     mflags(3, 4) = 0: mflags(3, 5) = 0: mflags(3, 6) = 1
     RETURN
3190 SCREEN 7: XRes = 320: yres = 200: MaxColor = 16: colr = 1
     GOSUB 3230: mflags(3, 3) = 2: segadr = &HA000: scrlen = 32767
     mflags(3, 4) = 0: mflags(3, 5) = 0: mflags(3, 6) = 1
     RETURN
3230 mflags(3, 1) = 1: mflags(3, 2) = 1: mflags(3, 3) = -ega: RETURN
     GOSUB 19000
     msg1$ = "Please enter name of picture to " + typ$
     tw = swidth / 2 - 10: LINE (tw * 8 - 10, 50)-(tw * 8 + 160, 100), 0, BF: LINE (tw * 8 - 10, 50)-(tw * 8 + 160, 100), , B: LINE (tw * 8 - 8, 52)-(tw * 8 + 150, 98), , B
     LOCATE 8, swidth2 - LEN(msg1$) / 2: PRINT msg1$: LOCATE 9, swidth / 2 - LEN(msg2$) / 2: PRINT msg2$
     RETURN
     edt$ = "": ix = POS(0): iy = CSRLIN: xi = ix: kbd = -1: IF maxlen = 0 THEN maxlen = 79 - ix
     WHILE kbd <> 13
      xi = LEN(edt$) + ix: LOCATE iy, xi: PRINT "_"; : kbd$ = INPUT$(1)
      kbd = ASC(kbd$): LOCATE iy, xi: PRINT " ";
      IF kbd = 8 AND LEN(edt$) > 0 THEN edt$ = LEFT$(edt$, LEN(edt$) - 1)
      IF LEN(edt$) < maxlen AND (kbd AND 127) > 32 THEN edt$ = edt$ + kbd$: LOCATE iy, xi: PRINT kbd$;
     WEND
     RETURN
6000 xrs = XRes / MaxColor: ch = 11: cy = yres - ch - 1
     LINE (0, cy)-(XRes - 1, yres - 1), 0, BF
     FOR i = 0 TO MaxColor - 1
      LINE (i * xrs - 2, cy + 3)-(i * xrs + xrs - 3, cy + ch - 3), i, BF
     NEXT
     LINE (0, cy)-(XRes - 1, yres - 1), , B
     LINE (colr * xrs, cy + 2)-(colr * xrs + xrs - 1, cy + ch - 2), , B
     RETURN
9000 RESTORE 9090
     WHILE mnstr$ <> "x"
      READ mnid, mnit, mflag, mnstr$
      IF mnstr$ <> "x" THEN GOSUB 11000
     WEND
     mflags(3, 3) = -ega
     cm$ = "u11" + CHR$(14) + "12o13s14v15" + CHR$(17) + "16d21l22r23c24a25p26b36k37j38"
     RETURN
9090 DATA 1,0,2,"Picture "
     DATA 1,1,1,"Undo   U"
     DATA 1,2,1,"New   ^N"
     DATA 1,3,1,"Open   O"
     DATA 1,4,1,"Save   S"
     DATA 1,5,1,"View   V"
     DATA 1,6,1,"Quit  ^Q"
     DATA 2,0,1," Tools       "
     DATA 2,1,2," Draw       D"
     DATA 2,2,1," Line       L"
     DATA 2,3,1," Recatangle R"
     DATA 2,4,1," Circle     C"
     DATA 2,5,1," Airbrish   A"
     DATA 2,6,1," Paint      P"
     DATA 3,0,1,"Preferences  "
     DATA 3,1,1," 320 x 200   "
     DATA 3,2,1," 640 x 200   "
     DATA 3,3,0," 320 x 200ega"
     DATA 3,4,2," cyn/mag/wht "
     DATA 3,5,1," red/grn/yel "
     DATA 3,6,1," Bkgd color B"
     DATA 3,7,1," Keyboard   K"
     DATA 3,8,1," Calibrate  J"
     DATA ,,,x
11000 maxmenus = 8: maxitems = 8
      IF mnid < 1 OR mnid > maxmenus OR menit < 0 OR mnit > maxitems THEN PRINT "Illegal menu parameters": STOP
      mtitle$(mnid, mnit) = mnstr$: mflags(mnid, mnit) = mflag
      IF mnit > mitems(mnid) THEN mitems(mnid) = mnit
      IF mnid > topid THEN topid = mnid
      RETURN
12000 IF swidth = 0 THEN IF xsize THEN swidth = INT(xsize / 8 + .5) ELSE swidth = 80
      msg$ = " ": mx(0) = 8: svx = POS(0): svy = CSRLIN
      FOR mi = 1 TO topid: mx(mi) = mx(mi - 1) + 8 + LEN(mtitle$(mi, 0)) * 8: msg$ = msg$ + " " + mtitle$(mi, 0): NEXT: msg$ = msg$ + SPACE$(swidth - LEN(msg$))
      LOCATE 1, 1: GOSUB 13000
      LOCATE svy, svx: RETURN
13000 x1 = POS(0) * 8 - 8: y1 = CSRLIN * 8 - 8: PRINT msg$; : x2 = x1 + LEN(msg$) * 8 - 1: IF x2 >= swidth * 8 THEN x2 = swidth * 8 - 1
      GET (x1, y1)-(x2, y1 + 7), zztemp: PUT (x1, y1), zztemp, PRESET: RETURN
14000 xsave = POS(0): ysave = CSRLIN
      mnit = 0: mnid = 0: GOSUB 20000
      IF my > 7 OR mb = 0 THEN RETURN
      WHILE mb: GOSUB 20000: WEND
       mi = 1: WHILE mi < topid AND NOT (mx > mx(mi - 1) AND mx <= mx(mi)): mi = mi + 1: WEND
       IF mi > topid THEN RETURN
       mnid = mi
       IF sndfx THEN SOUND 10000, .5
       GOSUB 16000: GOSUB 20000
       savdacc = dacc: sav$ = cm$: cm$ = "": IF keymode THEN my = 2: ny = my: dacc = -8
       WHILE mx >= mx(mnid - 1) AND mx <= mx(mnid) AND mb = 0
        GOSUB 20000
        mi = INT(my / 8): IF mi > mitems(mnid) THEN GOTO 14150
        IF mi = mnit OR mflags(mnid, mi) = 0 THEN LOCATE mnit + 1, INT(mx(mnid - 1) / 8 + 2): PRINT mtitle$(mnid, mnit)
14150   IF mnit > 0 THEN LOCATE mnit + 1, INT(mx(mnid - 1) / 8 + 2): PRINT mtitle$(mnid, mnit)
        IF mi > 0 AND mi <= mitems(mnid) THEN mnit = mi: LOCATE mnit + 1, INT(mx(mnid - 1) / 8) + 2: msg$ = mtitle$(mnid, mnit): GOSUB 13000: IF sndfx THEN SOUND 20000, .1
        IF mi > mitems(mnid) THEN mnit = 0
       WEND
      IF mx < mx(mnid - 1) OR mx > mx(mnid) THEN mnit = 0
      IF mnit THEN GOSUB 15000
      GOSUB 17000
      WHILE mb: GOSUB 20000: WEND
      IF mnit = 0 THEN mnid = 0: IF sndfx THEN SOUND 150, 2: SOUND 50, 1
      GOSUB 18000: dacc = savdacc: cm$ = sav$: LOCATE ysave, xsave
      RETURN
15000 IF mnit = 0 OR highlight = 0 THEN RETURN
      msg$ = mtitle$(mnid, mnit): FOR mi = 1 TO highlight: LOCATE mnit + 1, xp: GOSUB 13000
       IF sndfx THEN SOUND 10000 + mi * 500, .1
       LOCATE mnit + 1, xp: PRINT msg$
      NEXT: RETURN
16000 wx1 = mx(mnid - 1): wx2 = mx(mnid): wy1 = 8: wy2 = 8 + 8 * mitems(mnid): xp = INT(wx1 / 8) + 2
      GOSUB 19000
      LOCATE 1, xp - 1: PRINT " " + mtitle$(mnid, 0)
      GET (wx1 - 2, wy1)-(wx2 + 2, wy2 + 2), msave
      LINE (wx1 - 2, wy1)-(wx2 + 2, wy2 + 2), , B
      LINE (wx1 - 1, wy1)-(wx2 + 1, wy2 + 1), 0, BF
      FOR mi = 1 TO mitems(mnid)
       LOCATE mi + 1, xp: PRINT mtitle$(mnid, mi)
       IF mfalgs(mnid, mi) = 2 THEN PSET (wx1, mi * 8 + 5): DRAW "f2o5"
       IF mflags(mnid, mi) = 0 THEN GET (wx1, mi * 8)-(wxi + LEN(mtitle$(mnid, mi)) * 8 + 7, mi * 8 + 7), zztemp: PUT (wx1, mi * 8), zztemp, PSET: PUT (wx1 + 1, mi * 8), zztemp
      NEXT mi
      RETURN
17000 GOSUB 19000
      PUT (wx1 - 2, wy1), msave, PSET
      LOCATE 1, xp - 1: msg$ = " " + mtitle$(mnid, 0): GOSUB 13000
      RETURN
18000 IF cursor = 0 OR toggle = 1 THEN RETURN
      PUT (mx, my), arrow: toggle = 1: RETURN
19000 IF cursor = 0 OR toggle = 0 THEN RETURN
      PUT (mx, my), arrow: toggle = 0: RETURN
20000 mb = 0: penup = 0
      frozen = -1
      IF NOT frozen THEN s0 = STICK(0): s1 = STICK(1): mb = STRIG(1): IF s0 <> xoff OR s1 <> yoff THEN nx = INT((s0 - xoff) * xratio): ny = INT((s1 - yoff) * yratio): keymode = 0:  ELSE penup = -1
      mk$ = INKEY$: ky = 0: IF mk$ = "" THEN IF TIMER >= tm! THEN acc = ABS(dacc): tm! = TIMER + .1: GOTO 20060 ELSE 20060
      ky = ASC(MID$(mk$, 2) + CHR$(0)): mb = mb OR -(ky = 82): keymode = -1
      IF mk$ = CHR$(13) THEN mb = 1
      IF mk$ = CHR$(27) THEN
        IF dacc = 5 THEN
            dacc = 12
        ELSEIF dacc = 1 THEN
            dacc = 5
        ELSEIF dacc = 12 THEN
            dacc = 1
        END IF
      END IF
      nx = -(nx + acc * (ky = 75) - acc * (ky = 77)) * (ky <> 71): ny = -(ny + acc * (ky = 72) - acc * (ky = 80)) * (ky <> 71)
      IF ky = pk THEN acc = acc + 2 * (acc < 13) * (dacc > 0): pk = ky:  ELSE acc = ABS(dacc): pk = ky
      ky = ASC(mk$): IF NOT (ky > 47 AND ky < 58) THEN where = INSTR(cm$, CHR$(ky + 32 * (ky > 96 AND ky < 123))): IF where THEN mnid = VAL(MID$(cm$, where + 1, 1)): mnit = VAL(MID$(cm$, where + 2, 1)): IF mflags(mnid, mnit) = 0 THEN mnit = 0: mnid  _
= 0 ELSE GOSUB 21010
20060 IF nx = mx AND ny = my THEN RETURN
      xbound = XRes - xarrow: ybound = yres - yarrow
      nx = -nx * (nx > 0 AND nx <= xbound) - xbound * (ny > xbound) - (ny < 1)
      ny = -ny * (ny > 0 AND ny <= ybound) - ybound * (ny > ybound) - (ny < 1)
      GOSUB 19000: mx = nx: my = ny: GOSUB 18000
      RETURN
21010 xp = INT(mx(mnid - 1) / 8) + 2: msg$ = " " + mtitle$(mnid, 0): GOSUB 19000
      LOCATE 1, xp - 1: PRINT msg$
      IF sndfx THEN SOUND 10000, .1
      LOCATE 1, xp - 1: GOSUB 13000
      RETURN

