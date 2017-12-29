#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force


/*
ERROR CODE LEGEND
3108 = Couldn't delete local copy.
5098 = Couldn't copy file

*/

Gui, SPLASH: Font, s14
Gui, SPLASH: Margin, 5, 5
;Gui, SPLASH: Color, 000000
Gui, SPLASH: +Disabled
Gui, SPLASH: Add, Text, x10 y20 w335 Center, Buyback Express Macros
Gui, SPLASH: Font, s12
Gui, SPLASH: Add, Text, cRed w900 x10 y45 w335 Center, Refreshing Version
;Gui, SPLASH: Add, Text, x10 y65 w335 Center, ----------------------------------
Gui, SPLASH: Add, Text, x10 y93 w335 Center, Progress:
Gui, SPLASH: Font, s16
Gui, SPLASH: Add, Progress, vUpStat backgroundCCCCCC cGreen Center x10 y120 w330 h20, 0
Gui, SPLASH: Font, s10
Gui, SPLASH: Add, Text, cGray x10 y175 w335 Center, Press ESCAPE to Exit
Gui, SPLASH: Show, w350 h200, Updating BEX Macros

Exists(file) {
	IfExist, % file
		return True
	return False
}

Updater() {


; Define File Paths
;sfile := "\\be-localserver\Shared\Source\BEX_Macros.exe"
sfile := "P:\-- WORK --\BEX\BEX_Macros.exe"
dfile := A_MyDocuments . "\BEX\BEX_Macros.exe"
path := A_MyDocuments . "\BEX\"

; Update Progress Bar to 10%
GuiControl, SPLASH:,UpStat,10

Sleep, 60000

; Kill the currently running app process
Process, Close, BEX_Macros.exe
; Update Progress Bar to 20%
GuiControl, SPLASH:,UpStat,20

; Wait for the process to finish closing before continuing
Process, WaitClose, BEX_Macros.exe

; Update Progress Bar to 30%
GuiControl, SPLASH:,UpStat,30

; Check to see if the local copy of the app exists. If so, delete it.
if (Exists(dfile)) {
	FileDelete, % dfile
}

; Check to see if the delete command was successful.

if (Exists(dfile)) {
	; If delete failed, display error code.
	MsgBox,,Error!, Code: 3108, 30]
} else {
	; If it did delete, update progress bar to 40%
	GuiControl, SPLASH:,UpStat,40
}


; Check to see if the source file (update) exists.
if (Exists(sfile)) {
	GuiControl, SPLASH:,UpStatus, Source File Exists
	; If source exists, update progress bar to 45%
	GuiControl, SPLASH:,UpStat,45
}


; If the BEX folder doesn't exist on local computer, create it.
if (!Exists(path)) {
	FileCreateDir, % path
}

; If the BEX folder DOES exist, update progress bar to 50% and continue
if (Exists(path)) {
	GuiControl, SPLASH:,UpStat,50
}

; If we made it this far, the source exists, and the local copy doesn't... copy the source to local
if (Exists(sfile) and !Exists(dfile)) {
	FileCopy, % sfile, % dfile, 1
}


; Check to make sure everything went okay and update progress bar accordingly
if (Exists(dfile)) {
	GuiControl, SPLASH:,UpStat,75
	Run % dfile
	Sleep, 1500
	GuiControl, SPLASH:,UpStat,85
} else {
	MsgBox,, Error!, Code: 5098
	ExitApp
}

; Wait until the new app is running before continuing
Process, Wait, BEX_Macros.exe, 30

; Update is complete, update progress bar to 100%
GuiControl, SPLASH:,UpStat,100

; Wait 2 seconds before closing for good measure
Sleep, 2000

; Open up About Window and then exit
Send, !2

ExitApp

}

Updater()

Escape::
ExitApp