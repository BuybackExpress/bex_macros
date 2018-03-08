/*
 #####################################################################

    Version 1.7.3.1150 ncm

 #####################################################################
*/


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
#NoTrayIcon
#include BEX_Macros_globals.ahk
#include BEX_Macros_Functions.ahk

showError = True

Gui, SPLASH: Font, s14
Gui, SPLASH: Margin, 5, 5
Gui, SPLASH: +Disabled
Gui, SPLASH: Add, Text, x10 y20 w335 Center, Buyback Express Macros
Gui, SPLASH: Font, s12
Gui, SPLASH: Add, Text, cRed w900 x10 y45 w335 Center, Refreshing Version
Gui, SPLASH: Add, Text, x10 y93 w335 Center, Progress:
Gui, SPLASH: Font, s16
Gui, SPLASH: Add, Progress, vUpStat backgroundCCCCCC cGreen Center x10 y120 w330 h20, 0
Gui, SPLASH: Font, s10
Gui, SPLASH: Add, Text, cGray x10 y175 w335 Center, Press Alt+ESCAPE to Exit

; This function replaces (updates) the BEX_Macros file and the Changelog
UpdateNow() {
global

;BlockInput, On

; Show the Splash Wx`indow
Gui, SPLASH: Show, w350 h200, Updating BEX Macros

; Update Progress Bar to 10%
GuiControl, SPLASH:,UpStat,10

; Kill the currently running app process
Process, Close, BEX_Macros.exe

; Update Progress Bar to 20%
GuiControl, SPLASH:,UpStat,20

; Wait for the process to finish closing before continuing
Process, WaitClose, BEX_Macros.exe

GuiControl, SPLASH:,UpStat,30

GuiControl, SPLASH:,UpStat,40

GuiControl, SPLASH:,UpStat,45

FileCreateDir, % dpath
GuiControl, SPLASH:,UpStat,60

; Copy the Changelog, overwriting the existing file if it exists...
Try {
	FileCopy, % sfiles[1], % dfiles[1], 1
}
Catch {
	if (ShowError) 
		Msgbox, ,Error!,There was a problem copying the ChangeLog.`nPlease alert management.

	return false
}
GuiControl, SPLASH:,UpStat,70

; Copy the App, overwriting the existing file if it exists...
Try {
	FileCopy, % sfiles[2], % dfiles[2], 1
}
Catch {
	if (ShowError)
		Msgbox, ,Error!,There was a problem copying the main app.`nPlease alert management.

	return false
}

GuiControl, SPLASH:,UpStat,80

Run % dfile[2]

Sleep, 1500

GuiControl, SPLASH:,UpStat,90
	
; Wait until the new app is running before continuing
Process, Wait, BEX_Macros.exe, 30

; Update is complete, update progress bar to 100%
GuiControl, SPLASH:,UpStat,100

; Wait 2 seconds before closing for good measure
Sleep, 2000

Gui, SPLASH: Hide

return true

}

CheckVer()
{
	global

	if not (CheckSourceFiles(showError))
	{
		showError = false
		return
	}

	FileReadLine, myVer, % clog, 10
	myVer := SubStr(myVer, 5, 5)

	FileReadLine, mainVer, % sfiles[1], 10
	mainVer := SubStr(mainVer, 5, 5)

	if (mainVer <> myVer) {
		if (UpdateNow())
			reload
	}
	
	return
}

UpdateAll(){
	Run, % dfiles[4]
	return
}

if(FileExist(dfiles[2])) 
{
	Run % dfiles[2]
	Sleep, 1500
}

; Open up About Window and then exit
Send, !2

Loop
{
	CheckVer()
	Sleep, 60000
}


!Escape::
ExitApp

!3::CheckVer()

^!9::UpdateAll()