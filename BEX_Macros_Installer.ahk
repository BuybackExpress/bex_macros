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
#include BEX_Macros_Functions.ahk


/*
ERROR CODE LEGEND
6921 = Source Changelog not found.
6922 = Source BEX_Macros not found.
6923 = Source BEX_Macros_Launcher not found.
6924 = Source BEX_Macros_UpdateAll not found.
7281 = Couldn't copy Changelog.
7282 = Couldn't copy BEX_Macros.
7283 = Couldn't copy BEX_Macros_Launcher.
7284 = Couldn't copy BEX_Macros_Updater.
1081 = Could not create shortcut.
3925 = Could not delete existing folder.
*/

Gui, SPLASH: Font, s14
Gui, SPLASH: Margin, 5, 5
Gui, SPLASH: +Disabled
Gui, SPLASH: Add, Text, x10 y20 w335 Center, Buyback Express Macros
Gui, SPLASH: Font, s12
Gui, SPLASH: Add, Text, cRed w900 x10 y45 w335 Center, Installing BEX Macros
Gui, SPLASH: Add, Text, x10 y93 w335 Center, Progress:
Gui, SPLASH: Font, s16
Gui, SPLASH: Add, Progress, vUpStat backgroundCCCCCC cGreen Center x10 y120 w330 h20, 0
Gui, SPLASH: Font, s10


Install()
{
	global
	
	; Show the Splash Wx`indow
	Gui, SPLASH: Show, w350 h200, Installing BEX Macros

	; Update Progress Bar to 10%
	GuiControl, SPLASH:,UpStat,10

	; Kill the currently running app process
	Process, Close, BEX_Macros.exe
	; Wait for the process to finish closing before continuing
	Process, WaitClose, BEX_Macros.exe

	; Update Progress Bar to 20%
	GuiControl, SPLASH:,UpStat,20

	; Kill the currently running app process
	Process, Close, BEX_Macros_Launcher.exe
	; Wait for the process to finish closing before continuing
	Process, WaitClose, BEX_Macros_Launcher.exe

	; Update Progress Bar to 30%
	GuiControl, SPLASH:,UpStat,30

	; Check that source files are present.
	for key, file in sfiles 
	{
		if(!FileExist(file))
		{
			MsgBox,,Error!,Error: 692%key%`rFile not found!, 30
			return
		}
	}

	GuiControl, SPLASH:,UpStat,40

	; If the BEX folder DOES exist, update progress bar to 50% and delete it
	if (FileExist(dpath)) {
		FileRemoveDir, % dpath, 1

		if (ErrorLevel)
		{
			MsgBox,,Error!, Error: 3925`rCould not remove directory!, 30
			return
		}

		GuiControl, SPLASH:,UpStat,50
	}
	
	; If the BEX folder doesn't exist on local computer, create it.
	FileCreateDir, % dpath

	if (ErrorLevel) {
		MsgBox,, Error!, Unknown Error!`nError:%ErrorLevel%, 30
		return
	}

	for key, file in sfiles
	{
		FileCopy, % file, % dfiles[key], 1

		if (ErrorLevel)
		{
			MsgBox,,Error!, Error: 728%key%`rFile copy failed!, 30
			return
		}

		GuiControl, SPLASH:,UpStat,50+(5*key)
	}

	GuiControl, SPLASH:,UpStat,85

	if (FileExist(dfiles[3]))
	{
		FileCreateShortcut, % dfiles[3], %A_Desktop%.\BEX Macros.lnk

		if (ErrorLevel)
		{
			MsgBox,,Error!, Error: 1081`rUnable to create shortcut!, 30
			return
		}

		FileCreateShortcut, % dfiles[3], %startupPath%BEX Macros.lnk

		if (ErrorLevel)
		{
			MsgBox,,Error!, Error: 1081`rUnable to create shortcut!, 30
			return
		}


		runfile := dfiles[3]

		Run % runfile
		
		; Wait until the new app is running before continuing
		Process, Wait, BEX_Macros_Launcher.exe, 30

		; Update is complete, update progress bar to 100%
		GuiControl, SPLASH:,UpStat,100

		; Wait 2 seconds before closing for good measure
		Sleep, 2000

		Gui, SPLASH: Hide
		BlockInput, Off
	}

	return
}

Install()
ExitApp

!Esc::
ExitApp