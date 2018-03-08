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


/*
ERROR CODE LEGEND
3108 = Source CHANGELOG not found.
5098 = Source Main App not found.
9136 = Source Launcher not found.
5731 = Source Updater not found.
*/

;------------------- DISPLAY SPLASH WINDOW ------------------
Splash() {
	Gui, SPLASH: Show, w350 h200, About BEX Macros
	Sleep, 5000
	WinClose, About BEX Macros
	return
}


;------------------- DISPLAY MACRO WINDOW ------------------
Macro_Window() {
	width := A_ScreenWidth - 270
	Gui, MACRO: Show, x%width% y20 w250 h450, BEX Macros
	return
}


;------------------- DISPLAY DVD WINDOW ------------------
DVD_Window() {
	Gui, DVD: Show, w600 h300, DVD Macros
	return
}


;------------------- DISPLAY BOOK WINDOW ------------------
BOOK_Window() {
	Gui, BOOK: Show, w600 h300, Book Macros
	return
}


;------------------- DISPLAY WATER DAMAGE WINDOW ------------------
Water_Window(){
	Global
	Gui, WATER: Show, w360 h510, Water Damage
	WinWaitClose, Water Damage
	return
}

;------------------- GET EXTENT OF WATER DAMAGE ------------------
GetWaterDamage() {
	
	global
	Water_Window()
	StringLower, WTR_Extent, WTR_Extent
	WTR_Location := RegExReplace(WTR_Location, "\|",", ")
	StringLower, WTR_Location, WTR_Location
	return " " WTR_Degree . " damp-staining along " . WTR_Location . " to " . WTR_Extent . " of book, but visual defect only: no stickiness, scent, etc. and *Does Not Affect Text or Use of Book.*"
}


;------------------- DISPLAY CD WINDOW ------------------
CD_Window() {
	Gui, CD: Show, w600 h300, CD Macros
	return
}


;------------------- DISPLAY VIDEO GAME WINDOW ------------------
VG_Window() {
	Gui, VG: Show, w600 h300, Video Game Macros
	return
}


;------------------- DISPLAY SOFTWARE WINDOW ------------------
SFT_Window() {
	Gui, SFT: Show, w600 h300, Software Macros
	return
}


;------------------- PRINT ACCESS CARD PHRASE ------------------
CRD_Phrase() {
	SendRaw, New, Unused Access Code! Code Guaranteed to Work!
	return
}

;------------------- FIX TEXT FOR ADDITIONAL NOTES ---------------
FixText(str)
{
	;Capitalize the first character
	rstr := substr(str, 1, 1)
	str := substr(str, 2, 150)
	StringUpper, rstr, rstr
	rstr = %rstr%%str%

	len := StrLen(rstr)

	if (substr(rstr, len, 1) <> ".")
	{
		rstr = %rstr%.
	}

	return rstr
}

CheckSourceFiles(showError) {
	global

	; Check to see if the source file changelog exists.
	if not (FileExist(sfiles[1])) {
		if (showError) {
			msgbox,, Error!, Error Code: 3108`nPlease alert management.
			showError = False
		}

		return false
	}

	if not (FileExist(sfiles[2])) {
		if (showError) {
			msgbox,, Error!, Error Code: 5098`nPlease alert management.
			showError = False
		}

		return false		
	}

	; Check to see if the source file launcher exists.
	if not (FileExist(sfiles[3])) {
		if (showError) {
			msgbox,, Error!, Error Code: 9136`nPlease alert management.
			showError = False
		}

		return false
	}

	; Check to see if the source file updater exists.
	if not (FileExist(sfiles[3])) {
		if (showError) {
			msgbox,, Error!, Error Code: 5731`nPlease alert management.
			showError = False
		}

		return false
	}

	return true
}
