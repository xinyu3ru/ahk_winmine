#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Window
#SingleInstance force

#Include %A_ScriptDir%\include\FindText.ahk


start:
;maxR := 9
;maxL := 9
global fail := "|<失败>*96$17.0y0630E11014cd8UWWWX00600A00MDUcUWG0YE0EE10MA0DUE"
global Text_to_find :="|<空格>0xC0C0C0@1.00$16.001zzrzzTzxzzrzzTzxzzrzzTzxzzrzzTzxzzrzzTzy|<雷>*96$13.0U0E2yUzUnsNwzzbz3zUzUjc100UE|<1>*96$7.677bksQC78|<2>*96$10.Tvzy70Q7VwT3kDzzy|<3>*96$10.zvzk70QTVy0Q1zzzu|<4>*96$10.CsvbCQvzzz0s3UC0u|<5>*96$10.zzzy0s3zjz0Q1zzzu|<6>*96$10.Tvzi0s3zjzsTVzzTu|<红旗>*96$8.67XsS1U823nzzs|<失败>*96$17.0y0630E11014cd8UWWWX00600A00MDUcUWG0YE0EE10MA0DUE|<胜利>*96$17.0y0630E11014019zmbrnLjL6AQ00M00cUWEy4E0EE10MA0DUE"
global flag_pic := "|<红旗>*96$8.67XsS1U823nzzs"
global is_random_click
global game_over
global game_end
game_over := 0
game_end := 0
;maxRL1 := 9
;maxRL2 := 9


;查询扫雷界面的笑脸，获取坐标
IfWinExist, ahk_exe ms_arbiter.exe
{
    WinActivate
    middleXY := middleXY()
    ;MsgBox, % middleXY.1
    ;获取第一个方格的坐标
    global leftupperXY
    if (leftupperXY := leftupperXY())
    {
        global matrixRL
        matrixRL := []
        ;MsgBox, % leftupperXY.1
        ;获取扫雷初级、高级还是中级，根据第一个空格和笑脸的距离来判断
        if (maxRL := maxRowLine(middleXY.1, leftupperXY.1))
        {
            global matrixR := maxRL.1
            ;MsgBox, % matrixR
            global matrixL := maxRL.2
            j := matrixR
            
            ;MsgBox % matrixR "   "matrixL
            ;MsgBox % j 
            while j > 0
            {
                i := matrixL
                while i >0
                {
                    matrixRL[j, i] := 0
                    i := i-1
                    ;MsgBox, % i
                }
                ;MsgBox, % matrixRL[ji]
                ;MsgBox, % ji
                j := j-1
            }
            ;MsgBox % matrixRL[12, 12]
            ;MsgBox % matrixRL[12][13]
            ;MsgBox, %matrixRL%
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
    leftupperXY0 := leftupperXY.clone()
    global leftupperXY3 := leftupperXY0.3
    global leftupperXY4 := leftupperXY0.4
    ;MsgBox % "leftupperXY3是" leftupperXY3 "   leftupperXY4是" leftupperXY4
    ;开局随机点击4次
    random_click(3)
    random_clic1:
    random_click(1)
    while true
    {
        red_flag()
        ;MsgBox % "第一次循环插旗" 
        red_flag()
        ;MsgBox % "第二次循环插旗"
        click_blank()
        ;MsgBox "点击空格"
        if (is_random_click = 0)
        {
            ;Break
            random_click(1)

        }   
    }
    ;Goto, random_clic1

}
else
{
    MsgBox, 没有找到扫雷窗口   
}


;失败返回1，成功返回0
red_flag()
{
    global matrixRL, matrixR, matrixL, leftupperXY
    WinActivate, ahk_exe ms_arbiter.exe
    blocks_x := matrixL
    blocks_y := matrixR
    leftupperXY3 := leftupperXY.clone()
    if (kk := show_matrixRL(1))
    ;matrixRL, leftupperXY
        {
            MsgBox % "这里是red_flag" kk
            return 1
        }
    else
    {
        ;MsgBox % "插旗中" matrixRL " "blocks_x "  " blocks_y
        y := blocks_y
        ;MsgBox % y
        while y >= 0
        {
            x := blocks_x
            ;MsgBox % y " ,,,, " x
            while x >= 0
            {
                ;MsgBox % y "  " x
                if (1 <= matrixRL[y][x] <= 6)
                {
                    boom_number := matrixRL[y][x]
                    block_white := 0
                    block_qi := 0
                    yy := y+1
                    ;MsgBox % y "," x "处的值是" matrixRL[y][x] ";" block_white ";" block_qi ";" yy
                    while (yy >= (y-1))
                    {
                        xx := x+1
                        ;MsgBox % yy "  " xx
                        while (xx >= (x-1))
                        {
                            ;MsgBox % yy " ,, " xx
                            ;if (0 < yy and 0 < xx and yy <= blocks_y and xx <= blocks_x)
                            if ((0 <= yy <= blocks_y) and (0 <= xx <= blocks_x))
                            {
                                ;MsgBox % yy " 8888 " xx ";;" matrixRL[yy][xx]
                                ;if (not (yy = y and xx = x))
                                ;{
                                    if (matrixRL[yy][xx] = 0)
                                    {
                                        block_white := block_white+1
                                    }
                                    else if (matrixRL[yy][xx]=-4)
                                    {
                                        block_qi := block_qi+1
                                    }
                                ;}
                                ;MsgBox % "空白数量 "block_white " 插旗数量 " block_qi
                            }
                            xx := xx-1
                        }
                        yy := yy-1
                    }
                    boom_sum := block_white + block_qi
                    ;MsgBox % "boom_sum " boom_sum "  boom_number " boom_number
                    if (boom_number = boom_sum)
                    {
                        ;MsgBox % boom_number
                        yy := y+1
                        while (yy >= (y-1))
                        {
                            xx := x+1
                            while (xx >= (x-1))
                            {
                                ;MsgBox % "雷数" boom_number ",  "y "," x "循环标雷中" yy "," xx
                                ;if ((1 <= yy) and (1 <= xx) and (yy <= blocks_y) and (xx= < blocks_x))
                                if ((0 <= yy <= blocks_y) and (0 <= xx <= blocks_x))
                                {
                                    ;MsgBox % "是这儿的问题？"
                                    if (not (yy = y and xx = x))
                                    {
                                        ;MsgBox % yy "," xx ";;;;" blocks_y "," blocks_x "matrixRL[yy][xx]" matrixRL[yy][xx]
                                        if (matrixRL[yy][xx] = 0)
                                        {
                                            real_to_click_XY := real_click_XY(yy-1, xx-1, leftupperXY3.3, leftupperXY3.4)
                                            ;real_to_click_X := real_click_XY.1, real_to_click_Y := real_click_XY.2
                                            ;MsgBox % y "," x ";;;" yy "," xx ";;" leftupperXY3.3 "," leftupperXY3.4 ";;;" real_to_click_XY.1 ",," real_to_click_XY.2
                                            real_to_click_X1 := real_to_click_XY.1, real_to_click_Y1 := real_to_click_XY.2
                                            CoordMode, Mouse
                                            MouseMove, %real_to_click_X1%, %real_to_click_Y1%
                                            Sleep, 10
                                            Click right
                                            Sleep, 10
                                            MouseMove, leftupperXY3.3, leftupperXY3.4 - 30
                                            Sleep, 10
                                            matrixRL[yy][xx] := -4
                                            Sleep, 10
                                        }
                                    }
                                }
                                xx := xx-1
                            }
                            yy := yy-1
                        }
                    }
                }
                x := x-1
            }
            y := y-1
        }

    }
    return 0
}
;失败返回1，成功返回0


click_blank()
{
    global matrixRL, matrixR, matrixL, leftupperXY
    WinActivate, ahk_exe ms_arbiter.exe
    blocks_x := matrixL
    blocks_y := matrixR
    leftupperXY5 := leftupperXY.clone()
    leftupperX5 := leftupperXY5.3, leftupperY5 := leftupperXY5.4
    show_matrixRL(3)
    global is_random_click := 0
    y := blocks_y
    while y >= 0
    {
        x := blocks_x
        while x >= 0
        {
            ;MsgBox % "digging" y "  " x
            if (1 <= matrixRL[y][x] <= 6)
            {
                boom_number := matrixRL[y][x]
                block_white := 0
                block_qi := 0
                yy := y+1
                while (yy >= (y-1))
                {
                    xx := x+1
                    ;MsgBox % yy "," xx "boom_number " boom_number
                    while (xx >= (x-1))
                    {
                        ;MsgBox % yy "," xx "雷数 " boom_number "blocky" blocks_y "blockx" blocks_x
                        if ((0 <= yy <= blocks_y) and (0 <= xx <= blocks_x))
                        {
                            ;MsgBox % yy "," xx "boom_number " boom_number
                            if (yy = y and xx = x)
                            {
                                nothing := 0
                            }
                            else
                            {
                                if (matrixRL[yy][xx] = 0)
                                {
                                    block_white := block_white+1
                                }else if (matrixRL[yy][xx] = -4)
                                {
                                    block_qi := block_qi+1
                                }
                                ;MsgBox % "空白数量 " block_white " 插旗数量 " block_qi
                            }
                        }
                        xx := xx-1
                    }
                    yy := yy-1
                }
                ;MsgBox % y "," x "雷数 " boom_number "；未点开数量 " block_white " 插旗数量 " block_qi
                if ((boom_number = block_qi) and (1 <= block_white) and (boom_number <>0))
                {
                    yy := y+1
                    while (yy >= (y-1))
                    {
                        xx := x+1
                        while (xx >= (x-1))
                        {
                            ;
                            if ((0 <= yy <= blocks_y) and (0 <= xx <= blocks_x))
                            {
                                ;MsgBox "找到需要点击的方块附近"
                                if ((yy = y) and (xx = x))
                                {
                                    xx := xx-1
                                    Continue
                                }
                                else if (matrixRL[yy][xx] = 0)
                                    {
                                        real_to_click_XY := real_click_XY(yy-1, xx-1, leftupperXY3.3, leftupperXY3.4)
                                        ;MsgBox % yy "," xx ";;;;" leftupperXY3.3 "," leftupperXY3.4 ";;;" real_to_click_XY.1 ",," real_to_click_XY.2
                                        real_to_click_X1 := real_to_click_XY.1, real_to_click_Y1 := real_to_click_XY.2
                                        CoordMode, Mouse
                                        Click %real_to_click_X1%, %real_to_click_Y1%
                                        Sleep, 10
                                        MouseMove, leftupperXY3.3, leftupperXY3.4 - 30
                                        Sleep, 10
                                        is_random_click := 1
                                        Sleep, 10
                                    }
                            }
                            xx := xx-1
                        }
                        yy := yy-1
                    }
                }
            }
            x := x-1
        }
        y := y-1
    }
}

    ;return 1
















            

;截图识别图中内容，并放入数组
;失败返回1，成功返回0
show_matrixRL(meaning_less_num)
;matrixRL, leftupperXY
{
    meaning_less := meaning_less_num
    global matrixRL
    global leftupperXY
    ;MsgBox % "判断读取界面是否正常"
    if (all_text := FindText(10-150000//2, 10-150000//2, 150000, 150000, 0, 0, Text_to_find))
    {
        ;MsgBox % "经过这里"
        for index, element in all_text
        {
            CoordMode, Mouse
            X:=element[1], Y:=element[2], W:=element[3], H:=element[4], Comment:=element.5, X+=W//2, Y+=H//2
            ;MsgBox % Comment
            if (Comment = "失败")
            {
                send {F2}
                Reload
                return 1
            }
            else if (Comment = "胜利")
            {
                ExitApp
            }
            else if (Comment = "雷")
            {
                send {F2}
                Reload
                return 1
            }else if (Comment = 1)
            {
                update_list(1, element, leftupperXY)
            }else if (Comment = 2)
            {
                update_list(2, element, leftupperXY)
            }else if (Comment = 3)
            {
                update_list(3, element, leftupperXY)
            }else if (Comment = 4)
            {
                update_list(4, element, leftupperXY)
            }else if (Comment = 5)
            {
                update_list(5, element, leftupperXY)
            }else if (Comment = 6)
            {
                update_list(6, element, leftupperXY)
            }else if (Comment = 7)
            {
                update_list(7, element, leftupperXY)
            }else if (Comment = 8)
            {
                update_list(8, element, leftupperXY)
            }else if (Comment = "红旗")
            {
                update_list(-4, element, leftupperXY)
                ;MsgBox % "红旗"
            }else if (Comment = "空格")
            {
                update_list(-1, element, leftupperXY)
            }
        }
        ;MsgBox % "here 5.5  " matrixRL.5.5 "  10.7 " matrixRL.10.7 " 13.13  " matrixRL.13.13 " 15.9   " matrixRL.15.9
        return 0
    }
    else
    {
        MsgBox % "这个函数出错啦"
        return 0
    }
}


update_flag()
;matrixRL, leftupperXY
{
    global matrixRL
    global leftupperXY
    ;MsgBox % "更新插旗后的数组"
    if (flags := FindText(10-150000//2, 10-150000//2, 150000, 150000, 0, 0, flag_pic))
    {
        ;MsgBox % "找到红旗"
        for element in flags
        {
            Comment:=element.5
            if (Comment = "红旗")
            {
                update_list(-4, element, leftupperXY)
                MsgBox % "更新插旗后的数组:红旗"
            }
        }
        ;MsgBox % "here 5.5  " matrixRL.5.5 "  10.7 " matrixRL.10.7 " 13.13  " matrixRL.13.13 " 15.9   " matrixRL.15.9
        return 0
    }
    else
    {
        MsgBox % "这个函数出错啦"
    }
}

;根据坐标更新list
update_list(num3, element, leftupperXY)
{
    global matrixRL
    X:=element[1], Y:=element[2], W:=element[3], H:=element[4], Comment:=element[5]
    ;, X+=W//2, Y+=H//2
    leftupperXY3 := leftupperXY.clone()
    X5 := leftupperXY3.1, Y5 := leftupperXY3.2
    matrixR_num1 := round((X-X5)/16)+1, matrixL_num1 := round((Y-Y5)/16)+1
    ;MsgBox % num3 ",坐标 " matrixR_num1 " , " matrixL_num1 " ，原始坐标 " X5 "," Y5 " 格子坐标" X "," Y "," W "," H
    matrixRL[matrixR_num1, matrixL_num1] :=num3
    ;MsgBox % "经过这里" num3
}


;随机点击
random_click(numb)
{
    global matrixRL, leftupperXY3, leftupperXY4, matrixR, matrixL
    ;WinActivate, ahk_exe ms_arbiter.exe
    while (numb >= 0)
    {
        Random, xxxx, 1, matrixL
        Random, yyyy, 1, matrixR
        ;xxxx := 15, yyyy := 16
        ;Sleep 3000
        if matrixRL[xxxx][yyyy]
        {
            nothing := 0
        }
        else
        {
            CoordMode, Mouse
            real_click_X := leftupperXY3 + (xxxx-1)*16 - 2 , real_click_Y := leftupperXY4 + (yyyy-1)*16 - 2
            Click, %real_click_X%, %real_click_Y%
            Sleep, 10
            numb := numb-1
            ;MsgBox % "随机点击一次，" xxxx "，" yyyy ";;" matrixL "," matrixR ";;" leftupperXY3 "    " leftupperXY4 "    " real_click_X "    " real_click_Y

        }
    }
}


;返回相对于桌面的坐标，方便后续点击
real_click_XY(x, y, x1, y1)
{
    
    arr := []
    X := x1 + x*16
    Y := y1 + y*16
    
    arr.push( X,Y )
    return, arr.MaxIndex() ? arr:0

}



;返回中间笑脸的坐标
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

;返回第一个方块的坐标
leftupperXY()
{
    
    arr := []
    Text:="|<未点开>0xC0C0C0@1.00$16.00400XzwDzkzz3zwDzkzz3zwDzkzz3zwDzkzz400U02"
    if (ok:=FindText(0-150000//2, 0-150000//2, 150000, 150000, 0, 0, Text))
    {
      CoordMode, Mouse
      X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5,  X1 := X + W//2, Y1 := Y + H//2
      ; Click, %X%, %Y%
      arr.push( X,Y,X1,Y1 )
      ;MsgBox, % X "   " Y "   " X1 "  " Y1
    }

    return, arr.MaxIndex() ? arr:0
}

;返回格子最大坐标
;没有找到array[][]这样的操作方法，不好push操作
maxRowLine(MX, SX)
{
    
    arr := []
    px := MX - SX
    ;MsgBox, % "MX" MX "-SX" SX "=PX" px
    if px > 190
    {
    arr.push( 16,30 )
    }
    else if px < 80
    {
    arr.push( 8,8 )
    }
    else
    {
    arr.push( 16,16 )
    }

    return, arr.MaxIndex() ? arr:0
}