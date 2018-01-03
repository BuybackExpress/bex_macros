#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force


if (!A_IsAdmin) {
	Run *RunAs "%A_ScriptFullPath%"
	ExitApp
}


/*
ERROR CODE LEGEND
3130 = Couldn't delete local app.
7963 = Couldn't copy app.
6929 = Source app file not found.
*/

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

Exists(file) {
	IfExist, % file
		return True
	return False
}

Updater() {
BlockInput, On
; Define File Paths

spath := "\\be-localserver\Shared\Source\"
dpath := A_MyDocuments . "\BEX Macros\"
dfile := % dpath . "BEX_Macros_Launcher.exe"
sfile := % spath . "BEX_Macros_Launcher.exe"

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

; Check to see if the source file (update) exists.
if (Exists(sfile)) {
	; If source exists, update progress bar to 45%
	GuiControl, SPLASH:,UpStat,50
} else {
	MsgBox,,Error!, Code: 6929,30
	return 0
}

; Check to see if the local copy of the app exists. If so, delete it.
if (Exists(dfile)) {
	FileDelete, % dfile

	; Check to see if the delete command was successful.
	if (ErrorLevel) {
		; If delete failed, display error code.
		MsgBox,,Error!, Code: 3130,30
		return 0
	} else {
		; If it did delete, update progress bar to 40%
		GuiControl, SPLASH:,UpStat,40
	}
}

; If the BEX folder DOES exist, update progress bar to 50% and continue
if (Exists(dpath)) {
	GuiControl, SPLASH:,UpStat,60
} else {
	; If the BEX folder doesn't exist on local computer, create it.
	FileCreateDir, % dpath

	if (ErrorLevel) {
		MsgBox,, Error!, Unknown Error!, 30
		return 0
	}
}

; If we made it this far, the source exists, and the local copy doesn't, so copy the app
if (Exists(sfile) and !Exists(dfile)) {
	FileCopy, % sfile, % dfile, 1

	if (ErrorLevel) {
		MsgBox,, Error!, Code: 7963
		return 0
	} else {
		GuiControl, SPLASH:,UpStat,65
		Run % dfile
		Sleep, 1500
		GuiControl, SPLASH:,UpStat,75
	}
}


; Wait until the new app is running before continuing
Process, Wait, BEX_Macros_Launcher.exe, 30

; Update is complete, update progress bar to 100%
GuiControl, SPLASH:,UpStat,100

; Wait 2 seconds before closing for good measure
Sleep, 2000

Gui, SPLASH: Hide
BlockInput, Off

return 1
}


Updater()
ExitApp