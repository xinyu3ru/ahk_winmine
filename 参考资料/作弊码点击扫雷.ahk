CoordMode, Pixel, Screen


F1::
WinActivate, ahk_exe winmine.exe
WinWaitActive, ahk_exe winmine.exe
WinGetPos,,,width,, ahk_exe winmine.exe
If width=170
	{
		loop1=9
		loop2=9
		back=-144
	}
Else if width=282
	{
		loop1=16
		loop2=16
		back=-256
	}
else if width=506
	{
		loop1=16
		loop2=30
		back=-480
	}
BlockInput, on
send,{x}
send,{y}
send,{z}
send,{z}
send,{y}
send,{Shift}
MouseMove, 23,107
loop, %loop1%
{
	loop, %loop2%
	{
		Gosub,Mine
		Gosub,MoveMouseLeft
	}
	Gosub,MoveMouseDown
}
BlockInput, off
Return

Mine:
PixelGetColor, c, 0, 0, RGB
If c=0x00000000		;color=black
	Click Right
Else ;if c=0xFFFFFFFF		;color=white
	Click
Return


MoveMouseLeft:
MouseMove,16,0,,R
Return

MoveMouseDown:
MouseMove,%back%,16,,R
Return