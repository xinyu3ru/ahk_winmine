#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, Force
#KeyHistory 0
#NoEnv

Process, Priority, , A
;~ SetControlDelay,-1
SetBatchLines, -1
SetMouseDelay, -1
;~ SetKeyDelay, -1
;~ SetWinDelay, -1
ListLines Off

;Ctrl + e 退出
^e::
Gosub, Sub2
return

Sub2:
Exit  ; 终止当前子程序以及调用它的子程序.

;自动读取内存，扫雷
F1::
VarSetCapacity(va, 4, 0)
WinGet, pid, PID, A
hw := DllCall("OpenProcess", "UInt", 24, "Int", false, "UInt", pid)
DllCall("ReadProcessMemory", "UInt", hw, "UInt", 0x01005338, "Str", va, "UInt", 4, "UIntP", 0)
h:=NumGet(va)
DllCall("ReadProcessMemory", "UInt", hw, "UInt", 0x01005334, "Str", va, "UInt", 4, "UIntP", 0)
w := NumGet(va)
VarSetCapacity(va, 1, 0)

Loop % h
{
    _h:=A_Index
    Loop % w
    {
        DllCall("ReadProcessMemory", "UInt", hw, "UInt", 0x01005340+32*_h+A_Index, "Str", va, "UInt", 1, "UIntP", 0)
        if (NumGet(va)=0x0f)
        {
            MouseClick, l, % 16*A_Index+6, % 16*_h+92, ,0
            ;~ x:=16*A_Index+6,y:=16*_h+92
            ;~ Click, %x%,%y%
        }
    }
}
return