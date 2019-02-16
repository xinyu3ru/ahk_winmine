#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Include %A_ScriptDir%\include\FindText.ahk


maxR := 9
maxL := 9

maxRL[1] := 9
maxRL[2] := 9

statusOK := statusOK()
if statusOK
{
    middleXY := middleXY()
    leftupperXY := leftupperXY()
    maxRL := maxRowLine(middleXY[1], leftupperXY[1])
    matrixR := maxRL[1]
    MsgBox %matrixR%
    matrixL := maxRL[2]
    j := matrixR
    MsgBox %j%
    while matrixR > 1
    {
        MsgBox 44444
        i := matrixL
        while matrixL >1
        {
            matrixRL[%j%, %i%] := 0
            i-=1
        }
        j-=1
    }
}
kk := matrixRL[3, 3]
MsgBox %kk%


statusOK()
{

Text:="|<正常>*96$17.0y0630E11014018lWVX300600A00MU8cUWEy4E0EE10MA0DUE"

if (ok:=FindText(307-150000//2, 645-150000//2, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
  ; Click, %X%, %Y%
  ;MsgBox, "OK"
  return 1
}
else
return 0

}

middleXY()
{
Text:="|<正常>*96$17.0y0630E11014018lWVX300600A00MU8cUWEy4E0EE10MA0DUE"
if (ok:=FindText(413-150000//2, 515-150000//2, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5
  ; Click, %X%, %Y%
}

arr[1] := %X%
arr[2] := %Y%
MsgBox %arr%

return, arr
}


leftupperXY()
{
Text:="|<未点开>0xC0C0C0@1.00$16.00400XzwDzkzz3zwDzkzz3zwDzkzz3zwDzkzz400U02"
if (ok:=FindText(413-150000//2, 515-150000//2, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5,  X1 := X + W//2, Y1 := Y + H//2
  ; Click, %X%, %Y%
}
arr[1] := X
arr[2] := Y
arr[3] := X1
arr[4] := Y1
return, arr
}


maxRowLine(MX, SX)
{
px := MX - SX
if px > 190
{
R := 16, L := 30
}
else if px < 80
{
R := 16, L := 16
}
else
{
R := 9, L := 9
}
arr[1] := R
arr[2] := L

return, arr
}