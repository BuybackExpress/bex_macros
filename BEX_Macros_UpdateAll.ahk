/*
 #####################################################################

    Version 1.7.2.1606 ncm

 #####################################################################
*/


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
#NoTrayIcon
#include BEX_Macros_Globals.ahk
#include BEX_Macros_Functions.ahk


/*
ERROR CODE LEGEND
3130 = Couldn't delete local app.
7963 = Couldn't copy app.
6929 = Source app file not found.
*/

showError = true

Gui, SPLASH: Font, s14
Gui, SPLASH: Margin, 5, 5
Gui, SPLASH: +Disabled
Gui, SPLASH: Add, Text, x10 y20 w335 Center, Buyback Express Macro Launcher
Gui, SPLASH: Font, s12
Gui, SPLASH: Add, Text, cRed w900 x10 y45 w335 Center, Refreshing Version
Gui, SPLASH: Add, Text, x10 y93 w335 Center, Progress:
Gui, SPLASH: Font, s16
Gui, SPLASH: Add, Progress, vUpStat backgroundCCCCCC cGreen Center x10 y120 w330 h20, 0
Gui, SPLASH: Font, s10

Update() {
global


; Show the Splash Wx`indow
Gui, SPLASH: Show, w350 h200, Updating BEX Macros Launcher

; Update Progress Bar to 10%
GuiControl, SPLASH:,UpStat,10

; Kill the currently running app process
Process, Close, BEX_Macros.exe

; Update Progress Bar to 20%
GuiControl, SPLASH:,UpStat,20

; Wait for the process to finish closing before continuing
Process, WaitClose, BEX_Macros.exe

; Update Progress Bar to 30%
GuiControl, SPLASH:,UpStat,30

; Kill the currently running app process
Process, Close, BEX_Macros_Launcher.exe

; Update Progress Bar to 20%
GuiControl, SPLASH:,UpStat,40

; Wait for the process to finish closing before continuing
Process, WaitClose, BEX_Macros_Launcher.exe

; If source exists, update progress bar to 45%
GuiControl, SPLASH:,UpStat,50

; If the BEX folder DOES exist, update progress bar to 50% and continue
GuiControl, SPLASH:,UpStat,60

Try {
	FileCopy, % sfiles[3], % dfiles[3], 1
}
Catch {
	Msgbox, ,Error!,There was a problem copying the launcher.`nPlease alert management.
	Run % dfiles[3]
	Process, Wait, BEX_Macros_Launcher.exe, 30
	return
}

GuiControl, SPLASH:,UpStat,70

Run % dfiles[3]

Sleep, 1500

GuiControl, SPLASH:,UpStat,85

; Wait until the new app is running before continuing
Process, Wait, BEX_Macros_Launcher.exe, 30

; Update is complete, update progress bar to 100%
GuiControl, SPLASH:,UpStat,100

; Wait 2 seconds before closing for good measure
Sleep, 2000

Gui, SPLASH: Hide

return
}

if (CheckSourceFiles(True))
	Update()
ExitApp