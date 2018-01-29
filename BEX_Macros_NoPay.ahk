#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
#Persistent
#notrayicon

/*
 #####################################################################

    Version 1.7.1.5036

 #####################################################################
*/

NPBLB := []
NPVGLB := []
NPSLB := []
NPDVDLB := []

Loop, Read, %A_ScriptDir%\NoPayLB.txt
{	
	if (InStr(A_LoopReadLine, "BOOK:")) {
		addme := SubStr(A_LoopReadLine, 6)
		NPBLB.push(addme)
	}
	else if (InStr(A_LoopReadLine, "DVD:")) {
		addme := SubStr(A_LoopReadLine, 5)
		NPDVDLB.push(addme)
	}
	else if (InStr(A_LoopReadLine, "VG:")) {
		addme := SubStr(A_LoopReadLine, 4)
		NPVGLB.push(addme)
	}
	else if (InStr(A_LoopReadLine, "SOFT:")) {
		addme := SubStr(A_LoopReadLine, 6)
		NPSLB.push(addme)
	}
}

;------------------- Create NOPAY GUI ---------------------
Gui, NP: Font, s18
Gui, NP: Add, Text, x20 y20 w560 h60 Center, Select the media type.
Gui, NP: Add, Button, x20 y70 w260 h60 Center, Book or Access Card
Gui, NP: Add, Button, x20 y140 w260 h60 Center, Video Game
Gui, NP: Add, Button, x320 y70 w260 h60 Center, Movie or CD
Gui, NP: Add, Button, x320 y140 w260 h60 Center, Software
Gui, NP: Add, Button, x460 y240 w120 gCancel, Cancel


Gui, NPLIST: Font, s18
Gui, NPLIST: Add, Text, x20 y10 w560 h60 Center, Select all of the exclusions that apply.
Gui, NPLIST: Add, ListBox, x20 y50 w560 h200 8 Center AltSubmit hidden vNPLBook,
Gui, NPLIST: Add, ListBox, x20 y50 w560 h200 8 Center AltSubmit vNPLDVD,
Gui, NPLIST: Add, Button, x20 y240 w120 gCancel, Clear
Gui, NPLIST: Add, Button, x460 y240 w120 gCancel, Cancel

NOPAY_Window() {
	global

	Loop % NPDVDLB.MaxIndex()
	{
		AddMe := % NPDVDLB[A_Index]
		GuiControl, NPLIST:, NPLDVD, %addme%
	}

	Loop % NPBLB.MaxIndex()
	{
		AddMe := % NPBLB[A_Index]
		GuiControl, NPLIST:, NPLBook, %addme%
	}


	Gui, NPBOOK: Show, w600 h300, Software Macros
	return
}

NPBOOK_Window() {
	Gui, NP: Show, w600 h300, Software Macros
	return
}


;------------------- END NOPAY GUI ---------------------

return


GuiClose:
ExitApp
