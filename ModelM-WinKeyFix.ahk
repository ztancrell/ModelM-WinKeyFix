#Requires AutoHotkey v2.0
#SingleInstance

; <Environment Setup>
Persistent
SetTitleMatchMode 2
SetWorkingDir A_InitialWorkingDir
InstallMouseHook
DetectHiddenWindows True
DetectHiddenText True
; </Environment Setup>

; Custom tray menu
Tray := A_TrayMenu
Tray.Delete()
Tray.Add("About", About)
Tray.Add("")
Tray.Add("Exit", Exit)

CheckAdmin()

; TODO: Allow users to choose the key to remap to RWIN, if possible.
RCTRL::RWin

; Functions & Handlers
CheckAdmin()
{
    full_command_line := DllCall("GetCommandLine", "str")
    if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
    {
        try
        {
            if A_IsCompiled
                Run '*RunAs "' A_ScriptFullPath '" /restart'
            else
                Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
        }
        catch
        {
            MsgBox "Error: Unable to obtain administrative privileges."
            ExitApp
        }
        ExitApp
    }
}

Exit(*)
{
    ExitApp
}

About(*)
{
    MsgBox "
        (
            Developer: Zach Tancrell <github.com/ztancrell>
            Creation Date: 11/18/2023

            This AutoHotkey v2 script rebinds RCTRL to RWIN, designed for IBM Model M keyboards and other keyboards without a Windows key.

        )", "About Script", ""
}
