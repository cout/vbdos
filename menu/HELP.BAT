LOCATE 1
ECHO OFF
:DTOP
LOCATE 1
TYPE HELP.DSP
:START
GETLETR
IF ERRORLEVEL 27 GOTO END
IF ERRORLEVEL 13 GOTO START
IF ERRORLEVEL 12 GOTO END
IF ERRORLEVEL 11 GOTO LABELK
IF ERRORLEVEL 10 GOTO LABELJ
IF ERRORLEVEL 9 GOTO LABELI
IF ERRORLEVEL 8 GOTO LABELH
IF ERRORLEVEL 7 GOTO LABELG
IF ERRORLEVEL 6 GOTO LABELF
IF ERRORLEVEL 5 GOTO LABELE
IF ERRORLEVEL 4 GOTO LABELD
IF ERRORLEVEL 3 GOTO LABELC
IF ERRORLEVEL 2 GOTO LABELB
:LABELA
ECHO This is a game in which you must attempt
ECHO to catch flies (which actually look like
ECHO little  floating  eyeballs)  with   your
ECHO tongue.  Press F10  to stretch out  your
ECHO tongue in  an attempt  to  catch a  fly.
ECHO The  computer  automatically tracks  the
ECHO highest score.
PAUSE
GOTO TOP
:LABELB
ECHO This is a version of ping pong which you
ECHO play against  the computer.   Use the up
ECHO and down arrow keys  at the right of the
ECHO keyboard  (marked  8 and 2)  to move the
ECHO paddle  up  and  down.   As  your  score
ECHO increases,  the  computer plays  harder.
ECHO Press  CTRL + BREAK  at any time to stop
ECHO the game.
PAUSE
GOTO TOP
:LABELC
ECHO This is  a game  similar to  Breakout or
ECHO Brickles  (also there  are Alleyway  and
ECHO Break the Bricks).   To start, CAPS LOCK
ECHO and NUM LOCK  must be  turned off.   Use
ECHO the  number  keys at the  right  of  the
ECHO keyboard to move the paddle.  Keys 7 and
ECHO 9 move the paddle one space.  Keys 4 and
ECHO 6 move the  paddle two  spaces.   Keys 1
ECHO and 2 move the paddle four spaces.   The
ECHO object of the game is to break as may of
ECHO the bricks as possible.  When all of the
ECHO bricks  are broken,  the ball begins  to
ECHO move faster.   Press  F10  to change the
ECHO difficulty  level  (shown as  L=EASY  or
ECHO L=HARD at the top of the screen).
PAUSE
GOTO TOP
:LABELD                                      
ECHO Sufficient    instructions    are    not
ECHO available at this time.  Only by playing
ECHO game can one discover how to play.
PAUSE
GOTO TOP
:LABELE
ECHO This is a shoot-em-up type game in which
ECHO the  object is  to shoot  as many  happy
ECHO faces as possible.   A darkened-in happy
ECHO face will also  move up and down  and is
ECHO worth 5 points instead  of the usual  1.
ECHO When a darkened-in happy face is shot, a
ECHO pretty  red balloon  will appear  in the
ECHO middle  of  the  screen.   Shooting  the
ECHO balloon  is  worth 20  points,  but  the
ECHO faces will begin to move faster.
PAUSE
GOTO TOP
:LABELF
ECHO This is a paint  program.   Mouse support
ECHO not yet available,  but a joystick may be
ECHO used instead.  Save  and  Load options do
ECHO not  yet  work either.   The  program  is
:TOP
CLS
GOTO DTOP
ECHO designed to work with a CGA monitor,  but
ECHO an EGA or VGA  monitor is required due to
ECHO a bug in the program.
PAUSE
GOTO TOP
:LABELG
ECHO This is a flight simulator which does not
ECHO presently operate correctly.
PAUSE
GOTO TOP
:LABELH                                       
ECHO This is a flight simulator.  Press A and
ECHO D to move the  plane left and right.   X
ECHO will move the plane up.  W will move the
ECHO plane down. - decreases air speed, while
ECHO = increases air speed.   0  will put the
ECHO gear (undercarriage) up or down. To land
ECHO air speed must be less than 20, altitude
ECHO must be  less than 5,  and undercarriage
ECHO must be down.   Press F2  to exit at any
ECHO time.  See also FLIGHT3.
PAUSE
GOTO TOP
:LABELI
ECHO This  is a  flight simulator  similar  to
ECHO FLIGHT2, except that  it has an  aircraft
ECHO carrier  to land on  (it is also possible
ECHO to land in the water).   See instructions
ECHO for FLIGHT3 for full details."
PAUSE
GOTO TOP
:LABELJ
ECHO This is a simulation of a jogger trying
ECHO to  escape  dogs.  Press  SPACE BAR  to
ECHO change direction.  Press ESC to exit.
PAUSE
GOTO TOP
:LABELK
ECHO This is the help utility, which you are
ECHO currently using.
PAUSE
GOTO TOP
:END

