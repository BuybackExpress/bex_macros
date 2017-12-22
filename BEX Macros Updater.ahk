#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

Gui, SPLASH: Font, s14
Gui, SPLASH: Color, 000000
Gui, SPLASH: +Disabled
Gui, SPLASH: Add, Text, cWhite x10 y20 w335 Center, Buyback Express Macros
Gui, SPLASH: Font, s12
Gui, SPLASH: Add, Text, cRed w900 x10 y45 w335 Center, Auto Updater
Gui, SPLASH: Add, Text, cWhite x10 y70 w335 Center, ---------------------------------
Gui, SPLASH: Add, Text, cWhite x10 y93 w335 Center, Status:
Gui, SPLASH: Font, s16
Gui, SPLASH: Add, Text, vUpStatus cRed x10 y120 w335 Center, Doing the thing.
Gui, SPLASH: Show, w350 h200, Updating BEX Macros
Gui, SPLASH: Font, s10
Gui, SPLASH: Add, Text, cGray x10 y175 w335 Center, Press ESCAPE to Exit

Exists(file) {
	IfExist, % file
		return True
	return False
}

Updater() {

sfile := "\\be-localserver\Shared\Source\BEX_Macros.exe"
dfile := A_MyDocuments . "\BEX\BEX_Macros.exe"
path := A_MyDocuments . "\BEX\"

GuiControl, SPLASH:,UpStatus, Closing Current
Process, Close, BEX_Macros.exe
GuiControl, SPLASH:,UpStatus, Waiting for App to Close
Process, WaitClose, BEX_Macros.exe

GuiControl, SPLASH:,UpStatus, Checking if Local File Exists
if (Exists(dfile)) {
	FileDelete, % dfile
	GuiControl, SPLASH:,UpStatus, Deleting Local File
}

Sleep, 1000

if (Exists(dfile)) {
} else {
	GuiControl, SPLASH:,UpStatus, Local File Deleted
}

Sleep, 1000


if (Exists(sfile)) {
	GuiControl, SPLASH:,UpStatus, Source File Exists
}

Sleep, 1000

GuiControl, SPLASH:,UpStatus, Attempting to Copy New File
Sleep, 1000

if (!Exists(path)) {
	FileCreateDir, % path
}

if (Exists(sfile) and !Exists(dfile)) {
	FileCopy, % sfile, % dfile, 1
}

Sleep, 1000

if (Exists(dfile)) {
	GuiControl, SPLASH:,UpStatus, New File Copied
	Sleep, 1500
	GuiControl, SPLASH:,UpStatus, Launching New File
	Run % dfile
	Sleep, 1500
} else {
	MsgBox,, Error!, Problem With New File!
	ExitApp
}

Process, Wait, BEX_Macros.exe, 30

GuiControl, SPLASH:,UpStatus, Newest Version is Running!

Sleep, 1500

GuiControl, SPLASH:,UpStatus, Closing in 3 Seconds

Sleep, 1000

GuiControl, SPLASH:,UpStatus, Closing in 2 Seconds

Sleep, 1000

GuiControl, SPLASH:,UpStatus, Closing in 1 Seconds

Sleep, 1000

ExitApp

}

Updater()

Escape::
ExitApp