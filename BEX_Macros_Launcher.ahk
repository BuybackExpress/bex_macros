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
#include BEX_Macros_globals.ahk

/*
ERROR CODE LEGEND
3108 = Couldn't delete local app.
5098 = Couldn't copy app.
9136 = Source app file not found.
5731 = Couldn't delete local changelog
5894 = Couldn't copy CHANGELOG
7634 = Source CHANGELOG not found
*/

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


Updater() {
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

; Update Progress Bar to 30%
GuiControl, SPLASH:,UpStat,30

; Check to see if the source file changelog exists.
if (FileExist(sfiles[1])) {
	; If source exists, update progress bar to 45%
	GuiControl, SPLASH:,UpStat,50
} else {
	MsgBox,,Error!, Code: 7634,30
	return
}

; Check to see if the source file app exists.
if (FileExist(sfiles[2])) {
	; If source exists, update progress bar to 45%
	GuiControl, SPLASH:,UpStat,55
} else {
	MsgBox,,Error!, Code: 9136,30
	return
}

; Check to see if the local copy of the app exists. If so, delete it.
if (FileExist(dfiles[2])) {
	FileDelete, % dfiles[2]

	; Check to see if the delete command was successful.
	if (ErrorLevel) {
		; If delete failed, display error code.
		MsgBox,,Error!, Code: 3108,30
		return
	} else {
		; If it did delete, update progress bar to 40%
		GuiControl, SPLASH:,UpStat,40
	}
}

; Check to see if the local copy of the changelog exists. If so, delete it.
if (FileExist(dfiles[1])) {
	FileDelete, % dfiles[1]

	; Check to see if the delete command was successful.
	if (ErrorLevel) {
		; If delete failed, display error code.
		MsgBox,,Error!, Code: 5731,30
		return
	} else {
		; If it did delete, update progress bar to 40%
		GuiControl, SPLASH:,UpStat,45
	}
}

; If the BEX folder DOES exist, update progress bar to 50% and continue
if (FileExist(dpath)) {
	GuiControl, SPLASH:,UpStat,60
} else {
	; If the BEX folder doesn't exist on local computer, create it.
	FileCreateDir, % dpath

	if (ErrorLevel) {
		MsgBox,, Error!, Unknown Error!, 30
		return
	}
}

; If we made it this far, the source exists, and the local copy doesn't... copy the CHANGELOG
if (FileExist(sfiles[1]) and !FileExist(dfiles[1])) {
	FileCopy, % sfiles[1], % dfiles[1], 1

	if (ErrorLevel) {
		MsgBox,, Error!, Code: 5894
		return
	} else {
		GuiControl, SPLASH:,UpStat,85
		
		GuiControl, SPLASH:,UpStat,95
	}
}

; Now copy the app itself
if (FileExist(sfiles[2]) and !FileExist(dfiles[2])) {
	FileCopy, % sfiles[2], % dfiles[2], 1

	if (ErrorLevel) {
		MsgBox,, Error!, Code: 5098
		return
	} else {
		GuiControl, SPLASH:,UpStat,65
		Run % dfile[2]
		Sleep, 1500
		GuiControl, SPLASH:,UpStat,75
	}
}


; Wait until the new app is running before continuing
Process, Wait, BEX_Macros.exe, 30

; Update is complete, update progress bar to 100%
GuiControl, SPLASH:,UpStat,100

; Wait 2 seconds before closing for good measure
Sleep, 2000

Gui, SPLASH: Hide

; Open up About Window and then exit
Send, !2

return

}

CheckVer()
{
	global

	FileReadLine, myVer, % clog, 10
	myVer := SubStr(myVer, 5, 5)

	FileReadLine, mainVer, % sfiles[1], 10
	mainVer := SubStr(mainVer, 5, 5)

	if (mainVer <> myVer)
		Updater()
	
	return
}

UpdateAll(){
	Run, BEX_Macros_Updater
	ExitApp
}

if(FileExist(dfiles[2])) 
{
	Run % dfiles[2]
	Sleep, 1500
}

Loop
{
	CheckVer()
	Sleep, 60000
}


!Escape::
ExitApp

!3::
CheckVer()

^!9::
UpdateAll()