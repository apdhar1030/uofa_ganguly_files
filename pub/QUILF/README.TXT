this is the readme file for quilf

This version of quilf runs under Windows 3.1 and Windows-95. There is an OS/2 version available
from D. Andersen (andersen@agate.net). The files are protected under the GNU copyleft agreement
which is described in the file COPYING.

The following function keys have been mapped
  F1 - help contents
  F2 - start the LSQ calculation (the original was F1, but Microsoft suggests F1 = HELP)
  F3 - Test the reactions with the solution parameters
  F4 - Select a subset of reactions to use
  F6 - Dump the screen to the printer (actually the entire worksheet)
  F9 - Set the Watch flag on/off

The Windows-95 version also includes a button bar and a status bar

Changes:
	The temperature is now in CELSIUS instead of Kelvin.
	The screen colors can be changed, and stored with the file.
	The printing routines use black and white regardless of the screen colors.

Installation:

Unfortunately there is no installation program, so to install them copy the files to an
appropriate place on your hard disk.

For Windows-95
  Readme.txt (this file)
  copying
  quilf95.exe
  quilf.hlp
  quilf.sln
  quilf.rct

For Windows 3.1
  Readme.txt	(this file)
  copying
  quilf31.exe
  quilf31.hlp
  quilf.sln
  quilf.rct

Because of the way the windows compiler for Windows 3.1 works, the help file
for quilf31.hlp is shipped as a zip file, it must be unzipped. The command is
  unzip help31.zip
which will create quilf31.hlp.

The source files are in the zip file (QUILF.ZIP) which can be unziped using unzip (the command is)
  unzip quilf.zip
and this will place the files in the appropriate directories.

The programs were compiled using version 11 of the Watcom C/C++  compiler. If you recompile
them there are numerous warnings that appear, and these can be ignored. I haven't bothered
to clean up the code that much from a translation from the original pascal version, so
consider this fair warning that the code isn't pretty.

Bugs:
  If you find one, I would appreciate it if you let me know either by
e-mail (andersen@mfx.net) or the U.S. Postal service (D. Andersen, 10 Jackson St.,
Van Buren ME 04785). Be sure to include a COMPLETE description of what caused the bug (what keys
did you press) and a copy of the mineral compositions used.

D. Andersen February 15, 1998
