' ------------------------------------------------------------------------
' Visual Basic for MS-DOS Mouse Toolkit
'
' The Mouse Toolkit (MOUSE.BAS) provides mouse support
' for text-mode and graphics programs when Visual Basic
' forms are not showing.  The Mouse Toolkit provides
' these procedures:
'       MouseBorder - sets mouse movement boundaries.
'       MouseDriver - checks for presence of mouse and
'                     provides access to mouse functions.
'       MouseHide   - hides mouse pointer.
'       MouseInit   - intializes mouse driver.
'       MousePoll   - get mouse pointer location and button
'                     status.
'       MouseShow   - displays mouse location.
'       SetHigh     - sets highest resolution video mode available.
'       ScrSettings - gets current Basic screen mode and screen width.
'
' See the"Microsoft Mouse Programmer's Guide" (Microsoft Press) for
' extensive information on programming for the mouse in Basic and
' other languages.
'
' To use the Mouse ToolKit routines in your program,
' include MOUSE.BAS in your program and call the
' appropriate procedures.  Note, if you use MOUSE.BAS
' in your program, you will also have to use VBDOS.LIB
' and VBDOS.QLB for the required CALL INTERRUPT support.
'
' A toolkit library (MOUSE.LIB) and Quick
' library (MOUSE.QLB) can be created from MOUSE.BAS
' as follows:
'    BC  mouse.bas /X;
'    DEL mouse.lib
'    LIB mouse.lib + mouse.obj + vbdos.lib;
'    LINK /Q mouse.lib, mouse.qlb,,vbdosqlb.lib;
'
' MOUSE.COM or MOUSE.SYS must be loaded to access the
' mouse.
'
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

DEFINT A-Z

' Include files containing declarations for called procedures.
'$INCLUDE: 'MOUSE.BI'
'$INCLUDE: 'VBDOS.BI'

CONST FALSE = 0
CONST TRUE = NOT FALSE

'--------------------------------------------------
' Sample usage of the mouse routines. This code is
' only executed if MOUSE.BAS is the start-up file.
' Parameter information for each mouse procedure
' appears in the header comments for the procedure.
' Note, to call mouse procedures, you should first
' hide all visible forms (SCREEN.HIDE) -- using the
' mouse procedures while forms are showing may
' yield unpredictable results.
'--------------------------------------------------

CLS

' Change to highest resolution graphics mode available.
' Note that the Mouse Toolkit works in text mode (SCREEN 0)
' as well as graphics modes.
SetHigh
							  
' Check if mouse driver is installed.
MouseInit

' Display mouse pointer.
MouseShow

LOCATE 20, 1: PRINT "Press right mouse button or any key to end program."

DO UNTIL rButton OR INKEY$ <> ""
	' Get mouse location and button status.
	MousePoll row, col, lButton, rButton
						
	IF lButton THEN lState$ = "is" ELSE lState$ = "is not"
	LOCATE 21, 1: PRINT "The left mouse button " + lState$ + " pressed.     "
	LOCATE 22, 1: PRINT "Mouse position: "; row; ", "; col; "    "
LOOP

' MouseBorder procedure.
'
' Sets vertical and horizontal boundaries for
' mouse pointer travel.
'
' Parameters:
'   row1, row2 - begining and ending vertical
'                boundaries.
'   col1, col2 - beginning and ending horizontal
'                boundaries.
'
' Row and column coordinates are determined by
' current screen mode and width -- returned by
' the ScrSettings procedure.
'
STATIC SUB MouseBorder (row1, col1, row2, col2)

	ScrSettings sMode, sWidth           ' Get current screen mode
										'  to determine coordinate settings.

	SELECT CASE sMode
		CASE 0                          ' Text-mode coordinates
			row1 = row1 - 1 * 8
			col1 = col1 - 1 * 8
			row2 = row2 - 1 * 8
			col2 = col2 - 1 * 8
		CASE 1, 7, 13                   ' Graphic mode coordinates
			col1 = col1 * 2
			col2 = col2 * 2
		CASE 2, 3, 4, 8, 9, 10, 11, 12
										' No adjustment needed
	END SELECT

	MouseDriver 7, 0, col1, col2
	MouseDriver 8, 0, row1, row2

END SUB

' MouseDriver procedure.
'
' Provides a Basic language interface to
' the mouse routines in MOUSE.COM or MOUSE.SYS.
'
' Parameters:
'   m0     - mouse task to perform:
'              0 - initialize mouse routines.
'              1 - display mouse pointer.
'              2 - hide mouse pointer.
'              3 - poll mouse location and
'                  button status.
'              7 - set horizontal boundary for mouse
'                  travel.
'              8 - set vertical boundary for mouse
'                  travel.
'   m1, m2, - these vary for different mouse tasks.
'   and m3    See MouseInit, MouseShow, MouseHide,
'             MouseShow, MousePoll, and MouseBorder
'             procedures for valid settings.
'
' The Mouse Toolkit provides access to the mouse routines
' listed above. For information on other mouse routines
' and other valid settings for m0, m1, m2, and m3, see
' the "Microsoft Mouse Programmer's Guide" (Microsoft
' Press).
'
STATIC SUB MouseDriver (m0, m1, m2, m3)

	DIM regs AS RegType

	IF MouseChecked = FALSE THEN
		DEF SEG = 0

		MouseSegment& = 256& * PEEK(207) + PEEK(206)
		MouseOffset& = 256& * PEEK(205) + PEEK(204)

		DEF SEG = MouseSegment&

		IF (MouseSegment& = 0 AND MouseOffset& = 0) OR PEEK(MouseOffset&) = 207 THEN
			MousePresent = FALSE
			MouseChecked = TRUE
			DEF SEG
		END IF
	END IF

	IF MousePresent = FALSE AND MouseChecked = TRUE THEN
		EXIT SUB
	END IF

	' Calls interrupt 51 to invoke mouse functions in the MS Mouse Driver.
	
	regs.ax = m0
	regs.bx = m1
	regs.cx = m2
	regs.dx = m3

	INTERRUPT 51, regs, regs

	m0 = regs.ax
	m1 = regs.bx
	m2 = regs.cx
	 m3 = regs.dx

	IF MouseChecked THEN EXIT SUB

	' Check for successful mouse initialization

	IF m0 AND NOT MouseChecked THEN
		MousePresent = TRUE
		DEF SEG
	END IF

	MouseChecked = TRUE
	
END SUB

' MouseHide procedure.
'
' Hides the mouse pointer.
'
SUB MouseHide ()

   MouseDriver 2, 0, 0, 0

END SUB

' MouseInit procedure.
'
' Initializes the mouse driver.
'
SUB MouseInit ()

	MouseDriver MousePresent%, 0, 0, 0

	IF MousePresent% = FALSE THEN
		ERROR 68
	END IF

END SUB

' MousePoll procedure.
'
' Gets the mouse pointer location and button
' status.
'
' Parameters:
'   row     - vertical location of mouse pointer.
'   col     - horizontal location of mouse pointer.
'   lButton - status of left mouse button:
'                0 - not pressed.
'                1 - pressed.
'   rButton - status of right mouse button:
'                0 - not pressed.
'                1 - pressed.
'
' The valid range for row and col are determined
' by the current screen mode and width returned
' by the ScrSettings procedure.
'
STATIC SUB MousePoll (row, col, lButton, rButton)

	MouseDriver 3, button, col, row

	ScrSettings sMode, sWidth   ' Get current screen mode to determine coordinate
								' settings.
	SELECT CASE sMode
		CASE 0                  ' Text-mode coordinates
			row = row / 8 + 1
			col = col / 8 + 1
		CASE 1, 7, 13           ' Graphic mode coordinates
			col = col / 2
		CASE 2, 3, 4, 8, 9, 10, 11, 12
								' No adjustment needed.
	END SELECT

	IF button AND 1 THEN
		lButton = TRUE
	ELSE
		lButton = FALSE
	END IF

	IF button AND 2 THEN
		rButton = TRUE
	ELSE
		rButton = FALSE
	END IF

END SUB

' MouseShow procedure.
'
' Displays mouse pointer.
'
SUB MouseShow ()

	MouseDriver 1, 0, 0, 0

END SUB

' ScrSettings procedure.
'
' Gets the current Basic screen mode setting and width.
'
' Parameters:
'   sMode  - the current Basic screen mode. See the
'            SCREEN statement for valid return values
'            (0-13).
'   sWidth - the current width of the display in
'            characters.
'
SUB ScrSettings (sMode AS INTEGER, sWidth AS INTEGER)

	' =======================================================================
	' Gets current Basic screen mode and width setting.
	' =======================================================================

	DIM regs AS RegType

	regs.ax = &HF00

	INTERRUPT &H10, regs, regs          ' &H10 returns video
										' information.

	sWidth = (regs.ax AND &HFF00) \ 256 ' High byte of AX (AH).
	sMode = regs.ax AND &HFF            ' Low byte of AX (AL).

	SELECT CASE sMode                   ' Map MS-DOS video mode
		CASE 3                          '  number to Basic screen
			sMode = 0                   '  modes.
		CASE 4
			sMode = 1
		CASE 6
			sMode = 2
		CASE 13
			sMode = 7
		CASE 14
			sMode = 8
		CASE 15
			sMode = 10
		CASE 16
			sMode = 9
		CASE 17
			sMode = 11
		CASE 18
			sMode = 12
		CASE 19
			sMode = 13
		CASE ELSE
			sMode = 3
	END SELECT


END SUB

' SetHigh procedure.
'
' Sets the highest-resolution graphics screen mode
' that is available for the current hardware.
'
SUB SetHigh ()

ON LOCAL ERROR RESUME NEXT

' Step through video modes (12-0) until
' one works.

FOR Mode = 12 TO 0 STEP -1
	SCREEN Mode
	IF ERR = 0 THEN EXIT SUB
NEXT Mode

END SUB

