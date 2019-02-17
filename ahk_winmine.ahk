#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Window

#Include %A_ScriptDir%\include\FindText.ahk


start:
maxR := 9
maxL := 9
fail := "|<失败>*96$17.0y0630E11014cd8UWWWX00600A00MDUcUWG0YE0EE10MA0DUE"


maxRL1 := 9
maxRL2 := 9


;查询扫雷界面的笑脸，获取坐标
if (middleXY := middleXY())
{
    ;MsgBox 44444
    ;middleXY := middleXY()
    ;MsgBox, % middleXY.1
    ;获取第一个方格的坐标
    if (leftupperXY := leftupperXY())
    {
        matrixRL := []
        ;MsgBox, % leftupperXY.1
        ;获取扫雷初级、高级还是中级，根据第一个空格和笑脸的距离来判断
        if (maxRL := maxRowLine(middleXY.1, leftupperXY.1))
        {
            matrixR := maxRL.1
            ;MsgBox, % matrixR
            matrixL := maxRL.2
            j := matrixR
            
            ;MsgBox % matrixL
            while j > 99
            {
                i := matrixL
                while i >0
                {
                    ji := j + i
                    
                    matrixRL[ji] := 0
                    i := i-1
                    ;MsgBox, % i
                }
                ;MsgBox, % matrixRL[ji]
                ;MsgBox, % ji
                j := j-100
            }
            ;MsgBox, % matrixRL1629
        }
        else
        {
        MsgBox, 初始化数组失败
        }
    }
    else
    {
        MsgBox, 可能软件已经不行了，再试几次吧
    }
    leftupperXY3 := leftupperXY.3
leftupperXY4 := leftupperXY.4
;开局随机点击4次
a := 4
while a > 0
{
    ;MsgBox % a
    if (rand_XY := rand_XY(matrixRL))
    {
        ;MsgBox % rand_XY.1
        ;cd := 100*rand_XY.1 + rand_XY.2
        ;MsgBox % cd
        ;MsgBox % matrixRL[cd]
        if (real_click_XY := real_click_XY(rand_XY.1,rand_XY.2,leftupperXY3,leftupperXY4))
        {
            CoordMode, Mouse
            ;MsgBox % rand_XY.1 "   " rand_XY.2 "    " leftupperXY.3 "    " leftupperXY.4 "    " real_click_XY.1 "    " real_click_XY.2
            ;MouseMove real_click_XY.1, real_click_XY.2
            ;sleep 300
            real_click_X := real_click_XY.1, real_click_Y := real_click_XY.2
            Click, %real_click_X%, %real_click_Y%
        }
    else
    {
        MsgBox, 哇喔，生成随机点，这也能出错
    }
    a := a-1
    }
}
}
else
{
MsgBox, 没有找到扫雷窗口
}

if (failed := FindText(413-150000//2, 515-150000//2, 150000, 150000, 0, 0, fail))
{
CoordMode, Mouse
X:=failed.1.1, Y:=failed.1.2, W:=failed.1.3, H:=failed.1.4, Comment:=failed.1.5, X+=W//2, Y+=H//2
MsgBox % X "  " Y
Click, %X%, %Y%
sleep 200
Goto start
}



real_click_XY(x,y,x1,y1)
{
    arr := []
    X := x1 + x*16
    Y := y1 + y*16
    
    arr.push( X,Y )
    return, arr.MaxIndex() ? arr:0

}


rand_XY(matrixRL)
{
arr := []
kkkk :=[]
clone_mat := matrixRL.Clone()

for index, element in clone_mat
{
    if element=0
    {
        kkkk.push( index )
        ;MsgBox, % index " " element
    }
}

random, kkk, 1, kkkk.Length()


X := Floor(kkkk[kkk]/100)
Y := Mod(kkkk[kkk], 100)
;MsgBox, % kkkk.Length() "   " kkk "   " kkkk[kkk] "   " X "   " Y
arr.push( Y, X )

return, arr.MaxIndex() ? arr:0
}

middleXY()
{
arr := []
Text:="|<正常>*96$17.0y0630E11014018lWVX300600A00MU8cUWEy4E0EE10MA0DUE"
if (ok:=FindText(413-150000//2, 515-150000//2, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5
  ; Click, %X%, %Y%
  arr.push( X,Y )
  ;MsgBox, % X

}

return, arr.MaxIndex() ? arr:0
}


leftupperXY()
{
arr := []
Text:="|<未点开>0xC0C0C0@1.00$16.00400XzwDzkzz3zwDzkzz3zwDzkzz3zwDzkzz400U02"
if (ok:=FindText(413-150000//2, 515-150000//2, 150000, 150000, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5,  X1 := X + W//2, Y1 := Y + H//2
  ; Click, %X%, %Y%
  arr.push( X,Y,X1,Y1 )
  ;MsgBox, % X "   " Y "   " X1 "  " Y1
}

return, arr.MaxIndex() ? arr:0
}


maxRowLine(MX, SX)
{
arr := []
px := MX - SX
;MsgBox, % px
if px > 190
{
arr.push( 1600,30 )
}
else if px < 80
{
arr.push( 1600,16 )
}
else
{
arr.push( 900,9 )
}

return, arr.MaxIndex() ? arr:0
}