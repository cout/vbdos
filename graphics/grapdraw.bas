' ------------------------------------------------------------------------
' Visual Basic for MS-DOS Graphics Program Support Module
'
' Provides routines for creating bar chart and pattern
' editor.
'
' Copyright (C) 1982-1992 Microsoft Corporation
'
' You have a royalty-free right to use, modify, reproduce
' and distribute the sample applications and toolkits provided with
' Visual Basic for MS-DOS (and/or any modified version)
' in any way you find useful, provided that you agree that
' Microsoft has no warranty, obligations or liability for
' any of the sample applications or toolkits.
' ------------------------------------------------------------------------

CONST FALSE = 0
CONST TRUE = NOT FALSE

' Bar Graph Declarations:
' Define type for the titles:
TYPE TitleType
   MainTitle AS STRING * 40
   XTitle AS STRING * 40
   YTitle AS STRING * 18
END TYPE
DIM Titles AS TitleType, Label$(1 TO 5), Value(1 TO 5)
DECLARE FUNCTION DrawGraph (T AS TitleType, Label$(), Value!(), N%)

' Shared variable passes pattern from the Pattern Editor to
' the Bar Chart demo.
DIM SHARED Tile$

'Pattern Editor Declarations:
DIM SHARED Bit%(0 TO 7)
DECLARE SUB DrawPattern (Pattern$)
DECLARE SUB EditPattern (Pattern$, PatternSize%)

' ======================== DRAWGRAPH ======================
' Draws a bar graph
' =========================================================
STATIC FUNCTION DrawGraph (T AS TitleType, Label$(), Value(), N%)

   ' Set size of graph:
   CONST GRAPHTOP = 24, GRAPHBOTTOM = 171
   CONST GRAPHLEFT = 48, GRAPHRIGHT = 624
   CONST YLENGTH = GRAPHBOTTOM - GRAPHTOP

   ' Calculate maximum and minimum values:
   YMax = 0
   YMin = 0
   FOR I% = 1 TO N%
	  IF Value(I%) < YMin THEN YMin = Value(I%)
	  IF Value(I%) > YMax THEN YMax = Value(I%)
   NEXT I%

   ' Calculate width of bars and space between them:
   BarWidth = (GRAPHRIGHT - GRAPHLEFT) / N%
   BarSpace = .2 * BarWidth
   BarWidth = BarWidth - BarSpace

   SCREEN 2
   CLS

   ' Draw y-axis:
   LINE (GRAPHLEFT, GRAPHTOP)-(GRAPHLEFT, GRAPHBOTTOM), 1

   ' Draw main graph title:
   Start% = 44 - (LEN(RTRIM$(T.MainTitle)) / 2)
   LOCATE 2, Start%
   PRINT RTRIM$(T.MainTitle);

   ' Annotate y-axis:
   Start% = CINT(13 - LEN(RTRIM$(T.YTitle)) / 2)
   FOR I% = 1 TO LEN(RTRIM$(T.YTitle))
	  LOCATE Start% + I% - 1, 1
	  PRINT MID$(T.YTitle, I%, 1);
   NEXT I%

   ' Calculate scale factor so labels aren't bigger than four digits:
   IF ABS(YMax) > ABS(YMin) THEN
	  Power = YMax
   ELSE
	  Power = YMin
   END IF
   Power = CINT(LOG(ABS(Power) / 100) / LOG(10))
   IF Power < 0 THEN Power = 0

   ' Scale minimum and maximum values down:
   ScaleFactor = 10 ^ Power
   YMax = CINT(YMax / ScaleFactor)
   YMin = CINT(YMin / ScaleFactor)
   ' If power isn't zero then put scale factor on chart:
   IF Power <> 0 THEN
	  LOCATE 3, 2
	  PRINT "x 10^"; LTRIM$(STR$(Power))
   END IF

   ' Put tic mark and number for Max point on y-axis:
   LINE (GRAPHLEFT - 3, GRAPHTOP)-STEP(3, 0)
   LOCATE 4, 2
   PRINT USING "####"; YMax

   ' Put tic mark and number for Min point on y-axis:
   LINE (GRAPHLEFT - 3, GRAPHBOTTOM)-STEP(3, 0)
   LOCATE 22, 2
   PRINT USING "####"; YMin

   YMax = YMax * ScaleFactor ' Scale minimum and maximum back
   YMin = YMin * ScaleFactor ' up for charting calculations.

   ' Annotate x-axis:
   Start% = 44 - (LEN(RTRIM$(T.XTitle)) / 2)
   LOCATE 25, Start%
   PRINT RTRIM$(T.XTitle);

   ' Calculate the pixel range for the y-axis:
   YRange = YMax - YMin

   ' If no pattern has been created using the Pattern Editor...
   IF Tile$ = "" THEN
	' Define a diagonally striped pattern:
	Tile$ = CHR$(1) + CHR$(2) + CHR$(4) + CHR$(8) + CHR$(16) + CHR$(32) + CHR$(64) + CHR$(128)
   END IF
   ' Draw a zero line if appropriate:
   IF YMin < 0 THEN
	  Bottom = GRAPHBOTTOM - ((-YMin) / YRange * YLENGTH)
	  LOCATE INT((Bottom - 1) / 8) + 1, 5
	  PRINT "0";
   ELSE
	  Bottom = GRAPHBOTTOM
   END IF

   ' Draw x-axis:
   LINE (GRAPHLEFT - 3, Bottom)-(GRAPHRIGHT, Bottom)
   ' Draw bars and labels:
   Start% = GRAPHLEFT + (BarSpace / 2)
   FOR I% = 1 TO N%

	  ' Draw a bar label:
	  BarMid = Start% + (BarWidth / 2)
	  CharMid = INT((BarMid - 1) / 8) + 1
	  LOCATE 23, CharMid - INT(LEN(RTRIM$(Label$(I%))) / 2)
	  PRINT Label$(I%);

	  ' Draw the bar and fill it with the striped pattern:
	  BarHeight = (Value(I%) / YRange) * YLENGTH
	  LINE (Start%, Bottom)-STEP(BarWidth, -BarHeight), , B
	  PAINT (BarMid, Bottom - (BarHeight / 2)), Tile$, 1

	  Start% = Start% + BarWidth + BarSpace
   NEXT I%
   LOCATE 1, 1
   PRINT "Press any key to return";
   Answer$ = INPUT$(1)

END FUNCTION

' ======================= DRAWPATTERN ====================
' Draws a patterned rectangle on the right side of screen
' ========================================================
STATIC SUB DrawPattern (Pattern$)
   VIEW (320, 24)-(622, 160), 0, 1  ' Set view to rectangle.
   PAINT (1, 1), Pattern$       ' Use PAINT to fill it.
   VIEW                 ' Set view to full screen.
   Tile$ = Pattern$     ' Set Tile$ for Bar Chart Demo.
END SUB

' ======================= EDITPATTERN =====================
' Edits a tile-byte pattern
' =========================================================
STATIC SUB EditPattern (Pattern$, PatternSize%)

   ByteNum% = 1     ' Starting position.
   BitNum% = 7
   Null$ = CHR$(0)  ' CHR$(0) is the first byte of the
					' two-byte string returned when a
					' direction key such as UP or DOWN is
					' pressed.
   DO

	  ' Calculate starting location on screen of this bit:
	  X% = ((7 - BitNum%) * 16) + 80
	  Y% = (ByteNum% + 2) * 8

	  ' Wait for a key press (flash cursor each 3/10 second):
	  State% = 0
	  RefTime = 0
	  DO

	 ' Check timer and switch cursor state if 3/10 second:
	 IF ABS(TIMER - RefTime) > .3 THEN
		RefTime = TIMER
		State% = 1 - State%

		' Turn the  border of bit on and off:
		LINE (X% - 1, Y% - 1)-STEP(15, 8), State%, B
	 END IF

	 Check$ = INKEY$    ' Check for keystroke.

	  LOOP WHILE Check$ = ""    ' Loop until a key is pressed.

	  ' Erase cursor:
	  LINE (X% - 1, Y% - 1)-STEP(15, 8), 0, B

	  SELECT CASE Check$    ' Respond to keystroke.

	  CASE CHR$(27)     ' ESC key pressed:
		 EXIT SUB       ' exit this subprogram.
	  CASE CHR$(32)     ' SPACEBAR pressed:
						' reset state of bit.

		 ' Invert bit in pattern string:
		 CurrentByte% = ASC(MID$(Pattern$, ByteNum%, 1))
		 CurrentByte% = CurrentByte% XOR Bit%(BitNum%)
		 MID$(Pattern$, ByteNum%) = CHR$(CurrentByte%)

		 ' Redraw bit on screen:
		 IF (CurrentByte% AND Bit%(BitNum%)) <> 0 THEN
			 CurrentColor% = 1
		 ELSE
			 CurrentColor% = 0
		 END IF
		 LINE (X% + 1, Y% + 1)-STEP(11, 4), CurrentColor%, BF

	  CASE CHR$(13)      ' ENTER key pressed: draw
		 DrawPattern Pattern$         ' pattern in box on right.

	  CASE Null$ + CHR$(75)  ' LEFT key: move cursor left.

		 BitNum% = BitNum% + 1
		 IF BitNum% > 7 THEN BitNum% = 0

	  CASE Null$ + CHR$(77)  ' RIGHT key: move cursor right.

		 BitNum% = BitNum% - 1
		 IF BitNum% < 0 THEN BitNum% = 7

	  CASE Null$ + CHR$(72)  ' UP key: move cursor up.

		 ByteNum% = ByteNum% - 1
		 IF ByteNum% < 1 THEN ByteNum% = PatternSize%

	  CASE Null$ + CHR$(80)  ' DOWN key: move cursor down.

		 ByteNum% = ByteNum% + 1
		 IF ByteNum% > PatternSize% THEN ByteNum% = 1
	  END SELECT
   LOOP
END SUB

' ======================= INITIALIZE ======================
' Sets up starting pattern and screen for pattern editor
' =========================================================
STATIC SUB Initialize (Pattern$, PatternSize%)
SHARED Bit%()
   ' Set up an array holding bits in positions 0 to 7:
   FOR I% = 0 TO 7
	  Bit%(I%) = 2 ^ I%
   NEXT I%

   CLS

' Set initial pattern to all bits set:
   Pattern$ = STRING$(PatternSize%, 255)

   SCREEN 2     ' 640 x 200 monochrome graphics mode

   ' Draw dividing lines:
   LINE (0, 10)-(635, 10), 1
   LINE (300, 0)-(300, 199)
   LINE (302, 0)-(302, 199)

   ' Print titles:
   LOCATE 1, 13: PRINT "Pattern Bytes"
   LOCATE 1, 53: PRINT "Pattern View"


' Draw editing screen for pattern:
   FOR I% = 1 TO PatternSize%

	  ' Print label on left of each line:
	  LOCATE I% + 3, 8
	  PRINT USING "##:"; I%

	  ' Draw "bit" boxes:
	  X% = 80
	  Y% = (I% + 2) * 8
	  FOR J% = 1 TO 8
		LINE (X%, Y%)-STEP(13, 6), 1, BF
		X% = X% + 16
	  NEXT J%
   NEXT I%

   DrawPattern Pattern$     ' Draw  "Pattern View" box.

   LOCATE 21, 1
   PRINT "DIRECTION keys........Move cursor"
   PRINT "SPACEBAR............Changes point"
   PRINT "ENTER............Displays pattern"
   PRINT "ESC.........................Quits";

END SUB

