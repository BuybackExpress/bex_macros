#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
#Persistent
#notrayicon

/*
 #####################################################################

    Version 1.7.5.1135 ncm

 #####################################################################
*/

media_type = 

;------------------- Create NOPAY GUI ---------------------
Gui, NP: Font, s18
Gui, NP: Add, Text, x20 y20 w560 h60 Center, Select the media type.
Gui, NP: Add, Button, x20 y70 w180 h60 Center gBook, Book
Gui, NP: Add, Button, x210 y70 w180 h60 Center gAC, Access Card
Gui, NP: Add, Button, x400 y70 w180 h60 Center gMov, Movie
Gui, NP: Add, Button, x20 y140 w180 h60 Center gVG, Video Game
Gui, NP: Add, Button, x210 y140 w180 h60 Center gSoft, Software
Gui, NP: Add, Button, x400 y140 w180 h60 Center gCD, CD
Gui, NP: Add, Button, x460 y240 w120 gCancel, Cancel

Gui, NPLIST: Font, s18
Gui, NPLIST: Add, Text, x20 y10 w560 h60 Center, Select all of the exclusions that apply.
Gui, NPLIST: Add, ListBox, x20 y50 w560 h200 8 Center AltSubmit vNPLst,
Gui, NPLIST: Add, Button, x20 y240 w100 gNPOK, OK
Gui, NPLIST: Add, Button, x370 y240 w100 gClear, Clear
Gui, NPLIST: Add, Button, x480 y240 w100 gCancel, Cancel

NOPAY_Window() {
	global

	Gui, NP: Show, w600 h300, Software Macros
	return
}

FillList(media) {
	arr := []

	media := Format("{:U}:",media)

	Loop, Read, %A_ScriptDir%\NoPayCond.txt	
		if (InStr(A_LoopReadLine, media))
			arr.push(Trim(SubStr(A_LoopReadLine, strlen(media) + 1)))

	return arr
}

NPL_Window(media) {

	listArray := FillList(media)
	
	Loop % listArray.MaxIndex()
	{
		AddMe := % listArray[A_Index]
		GuiControl, NPLIST:, NPLst, %addme%
	}

	Gui, NPLIST: Show, w600 h300, No Pay
	return
}

NOPAY_Window()

return

Book:
Gui, Submit
media_type = book
NPL_Window(media_type)
return

AC:
Gui, Submit
media_type = AC
NPL_Window(media_type)
return

VG:
Gui, Submit
media_type = vg
NPL_Window(media_type)
return

Mov:
Gui, Submit
media_type = dvd
NPL_Window(media_type)
return

CD:
Gui, Submit
media_type = cd
NPL_Window(media_type)
return

Soft:
Gui, Submit
media_type = soft
NPL_Window(media_type)
return

NPOK:
Gui, Submit, NoHide

msgbox % strreplace(NPLst, "|","`n")
return

Clear:
	GuiControl, NPLIST:, NPLst, |
	NPL_Window(media_type)
return

;------------------- CANCEL BUTTON CLOSES WINDOWS -------------------
Cancel:
	WinClose
	Reload
return
;------------------- END CANCEL BUTTON CLOSES WINDOWS ---------------------

esc::ExitApp

