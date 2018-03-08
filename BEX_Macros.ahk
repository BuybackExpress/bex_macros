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
;#include BEX_Macros_NoPay.ahk
#include BEX_Macros_Globals.ahk
#include BEX_Macros_Guis.ahk
#include BEX_Macros_Functions.ahk

;------------------------- Global Variables -------------------
WTR_Degree := ""
WTR_Location := ""
WTR_Extent := ""
WTR_String := ""

;------------------------- Global Arrays -------------------
DVDArray := ["in NEW Condition!","in LIKE NEW condition with no signs of wear.","in Very Good Condition with only light, reasonable wear. Perfect-Play Guarantee!","in Acceptable Condition with noticeable wear. Perfect-Play Guarantee!", "have considerable wear and library stickers/marks, but comes with our Perfect-Play Guarantee."]
BOOKArray := ["BRAND NEW BOOK!!","Book in Like New Condition!","Very Good condition. Light, reasonable wear.","Good condition with reasonable wear.","Fairly worn, but still very usable.","Good Condition. Reasonable wear. Still very usable. Ex-library with usual distinguishments (stamps, stickers, etc.)","Noticeable wear, but still very usable. Ex-library with usual distinguishments (stamps, stickers, etc.)"]
EdArray := [""," Loose-Leaf Edition."," Teacher Edition. Not for Sale."," Advanced Reader Copy. Not for Sale."," International Edition."]
CDArray := ["BRAND NEW IN SHRINKWRAP!","Very Good or better condition. CD in Very Good shape with only light, reasonable wear. Perfect-play Guarantee!","Art and case in reasonable or better condition. CD shows some wear, but is Guaranteed to Play Perfectly!","Art and case in reasonable or better condition. CD shows noticeable wear, but is Guaranteed to Play Perfectly!","Art and case in reasonable or better condition. CD shows some wear, but is Guaranteed to Play Perfectly! Library stickers/marks on art and CD.","Art and case in reasonable or better condition. CD shows noticeable wear, but is Guaranteed to Play Perfectly! Library stickers/marks on art and CD."]
VGArray := ["in NEW Condition!","in Very Good Condition. Light, reasonable wear.","in Good Condition with reasonable wear.","in Acceptable Condition with noticeable wear."]
SFTArray :=["in NEW Condition!","in Very Good Condition. Light, reasonable wear","in Good Condition with some reasonable wear, but come with","have noticeable wear, but come with"]

Macro_Window()

; BEGIN HOTKEYS

;------------------- BEGIN DVD HOTKEY -------------------
::#dvd::
	DVD_Window()
return
;------------------- END DVD HOTKEY -------------------

;------------------- BEGIN BOOK HOTKEY -------------------
::#bk::
	BOOK_Window()
return
;------------------- END BOOK HOTKEY -------------------

;------------------- BEGIN CD HOTKEY -------------------
::#cd::
	CD_Window()
return
;------------------- END CD HOTKEY -------------------

;------------------- BEGIN VG/SOFT HOTKEY -------------------
::#vg::
	VG_Window()
return
;------------------- END VG/SOFT HOTKEY -------------------

;------------------- BEGIN VG/SOFT HOTKEY -------------------
::#sft::
	SFT_Window()
return
;------------------- END VG/SOFT HOTKEY -------------------

::#crd::
	CRD_Phrase()
return

;------------------- INVOKE ABOUT WINDOW -------------------
!2::
	Splash()
return
;------------------- END ABOUT WINDOW HOTKEY -------------------

;------------------- SHOW TOOLBOX WINDOW HOTKEY -------------------
!3::
	Macro_Window()
return
;------------------- END TOOLBOX HOTKEY -------------------

!^Esc::
ExitApp

; BEGIN MINOR SUBROUTINES

;------------------- CANCEL BUTTON CLOSES WINDOWS -------------------
Cancel:
	WinClose
	Reload
return
;------------------- END CANCEL BUTTON CLOSES WINDOWS ---------------------

;------------------- BEGIN DVD BUTTON -------------------
DVD:
	Gui, MACRO: Hide
	DVD_Window()
return
;------------------- END DVD BUTTON -------------------

;------------------- BEGIN BOOK BUTTON -------------------
BOOK:
	Gui, MACRO: Hide
	BOOK_Window()
return
;------------------- END BOOK BUTTON -------------------

;------------------- BEGIN CD BUTTON -------------------
MUSIC:
	Gui, MACRO: Hide
	CD_Window()
return
;------------------- END CD BUTTON -------------------

;------------------- BEGIN VG/SOFT BUTTON -------------------
VIDEOGAME:
	Gui, MACRO: Hide
	VG_Window()
return
;------------------- END VG/SOFT BUTTON -------------------

;------------------- BEGIN VG/SOFT BUTTON -------------------
SOFTWARE:
	Gui, MACRO: Hide
	SFT_Window()
return
;------------------- END VG/SOFT BUTTON -------------------

;------------------- BEGIN CARD BUTTON -------------------
CARD:
	Gui, MACRO: Hide	
	CRD_Phrase()
	reload
return
;------------------- END CARD BUTTON -------------------

;------------------- BEGIN NO PAY BUTTON -------------------
;NOPAY:
;	Gui, MACRO: Hide	
	;NOPAY_Window()
;return
;------------------- END NO PAY BUTTON -------------------


; BEGIN MAJOR SUBROUTINES

;------------------- BEGIN DVD SUBMIT BUTTON FUNCTIONS -------------------
DVD_OK:
;submit the variables
Gui, Submit

;FORM VALIDATION
If (!format or !dvd_condition)
{
	MsgBox,,Nope, Please select both a condition and format.
	DVD_Window()
	return
}

;ASK FOR USER INPUT IF ADDITIONAL NOTES ARE CHECKED

if (dvd_more_notes)
{
	InputBox, dvd_notes, Notes, Enter additional notes,,,150
	dvd_notes := " " + FixText(dvd_notes)
}

;CHECK IF REPLACED CASE BOX IS CHECKED OR NOT
if (dvd_replacecase)
{
	dvd_replacecase := " Replacement case."
}
else 
{
	dvd_replacecase := ""
}

;CHECK IF DIGITAL CODE BOX IS CHECKED OR NOT
if (DigitalCode)
{
	if(dvd_condition = 1)
	{
		MsgBox,,Nope, There is no need to select the Digital Code box if the item is new.
		DVD_Window()
		return
	}
	DigitalCode := " May not include a valid digital code."
}
else 
{
	DigitalCode := ""
}

;CHECK IF LIBRARY BOX IS CHECKED OR NOT
if (library and dvd_condition < 4)
{
	MsgBox,,Error,You cannot choose better than ACCEPTABLE with Ex-Rental.
	DVD_Window()
	return
}
else if (library)
{
	dvd_condition := dvd_condition + 1
}

;CHECK IF REPLACED CASE BOX IS CHECKED OR NOT
if (dvd_replacecase)
{
	if(dvd_condition < 4)
	{
		MsgBox,,Nope, If you replaced the case, you can't choose higher than ACCEPTABLE.
		DVD_Window()
		return
	}
	dvd_replacecase := " Replacement case."
}
else 
{
	dvd_replacecase := ""
}

;CHECK IF FORMAT IS COMBO AND MODIFY TEXT
if (format = "Combo")
{
	format := "All Discs" 
}

;SET THE MAIN CONDITION PHRASE
cond := DVDArray[dvd_condition]

;OUTPUT THE MACRO TEXT

SendRaw, %Format% and Case %cond%%dvd_replacecase%%DigitalCode%%dvd_notes%

Sleep, 2000

;RELOAD SCRIPT TO RESET VARIABLES
Reload

return

;------------------- END DVD SUBMIT BUTTON FUNCTIONS -------------------

;------------------- BEGIN BOOK SUBMIT BUTTON FUNCTIONS -------------------
Book_OK:
Gui, Submit

;FORM VALIDATION
If (!book_condition)
{
	MsgBox,,Alert, Please select a condition.
	BOOK_Window()
	return
}

;ASK FOR USER INPUT IF ADDITIONAL NOTES ARE CHECKED
if (book_more_notes)
{
	InputBox, book_notes, Notes, Enter additional notes,,,150
	book_notes := " " + FixText(book_notes)
}

;CHECK ACCESS CARD DropDown
if (BOOK_AccessCard = 1){
	BOOK_AC_INCL := " Access Card Included!"
}
else if (BOOK_AccessCard = 2){
	BOOK_AC_INCL := " Access Card NOT Included."
}
else {
	BOOK_AC_INCL := ""
}

;CHECK CD DROPDOWN
if (book_disc = 4){
	book_disc_INCL := ""
}
else if (book_disc = 3){
	book_disc_INCL := " Disc NOT Included."
}
else if (book_disc = 2)
{
	MsgBox, 4, Sealed?, Is the Disc Sealed?
	IfMsgBox, Yes
		book_disc_incl := " Sealed DVD Included!"
	Else
		book_disc_incl := " DVD Included!"
}
else 
{
	MsgBox, 4, Sealed?, Is the Disc Sealed?
	IfMsgBox, Yes
		book_disc_incl := " Sealed CD Included!"
	Else
		book_disc_incl := " CD Included!"
}
;CHECK IF EX-RENTAL BOX IS CHECKED OR NoTab
if (BOOK_Library and book_condition < 4)
{
	MsgBox,,Error,You cannot choose better than GOOD with Ex-Rental.
	BOOK_Window()
	return
}
else if (BOOK_Library)
{
	book_condition := book_condition + 2
}

;CHECK IF WATER DAMAGE BOX IS CHECKED OR NoTab
if (BOOK_Water and book_condition < 4)
{
	MsgBox,,Error,If the book has Water Damage, you can't choose higher than GOOD.
	BOOK_Window()
	return
}
else if (BOOK_Water)
{
	WTR_String := GetWaterDamage()

	if (!markings)
	{
		Markings := " Mark-free interior!"
	}
	else 
	{
		Markings := " May include limited notes and/or highlighting."
	}
}
else
{

	water_str := ""

	;CHECK IF MARKINGS BOX IS CHECKED OR NOT
	if (!markings)
	{
		Markings := " Clean, mark-free interior!"
	}
	else 
	{
		Markings := " May include limited notes and/or highlighting."
	}

}


;SET THE MAIN CONDITION PHRASE
book_cond := BOOKArray[book_condition]
book_ed := EdArray[book_edition]

;OUTPUT MACRO TEXT
SendRaw, %book_cond%%book_ed%%book_disc_INCL%%BOOK_AC_INCL%%WTR_String%%markings%%book_notes%

Sleep, 2000

;RELOAD SCRIPT TO RESET VARIABLES
Reload

return
;------------------- END BOOK SUBMIT BUTTON FUNCTIONS -------------------

;
WTR_OK:
Gui, Submit
Return
;

;
WTR_ChkDta:
GuiControl, WATER: Enable, OK
Return
;


;------------------- BEGIN CD SUBMIT BUTTON FUNCTIONS -------------------
CD_OK:
;submit the variables
Gui, Submit

;FORM VALIDATION
If (!CD_condition)
{
	MsgBox,,Alert, Please select a condition!
	CD_Window()
	return
}

;ASK FOR USER INPUT IF ADDITIONAL NOTES ARE CHECKED
if (CD_more_notes)
{
	InputBox, cd_notes, Notes, Enter additional notes,,,150
	cd_notes := " " + FixText(cd_notes)
}

;CHECK IF REPLACED CASE BOX IS CHECKED OR NOT
if (CD_replacecase)
{
	if(CD_Condition = 1)
	{
		MsgBox,,Alert, Please uncheck the Replaced Case checkbox when choosing new condition.
		CD_Window()
		return
	}
	CD_ReplaceCase := " Replacement case."
}
else 
{
	CD_ReplaceCase := ""
}

;CHECK IF MISSING INSERT BOX IS CHECKED OR NOT
if (CD_Insert)
{
	if(CD_Condition < 3)
	{
		MsgBox,,Alert, Please uncheck the Missing Insert checkbox when choosing new condition.
		CD_Window()
		return
	}
	CD_Insert := " Insert is missing or damaged."
}
else 
{
	CD_Insert := ""
}


;CHECK IF PROMOTIONAL COPY CHECKBOX IS CHECKED OR NOT
if (Promo)
{
	Promo := " Promotional Copy."
}
else
{
	Promo := ""
}

;CHECK IF LIBRARY BOX IS CHECKED OR NOT
if (CD_library and CD_condition < 3)
{
	MsgBox,,Error,You cannot choose better than GOOD with Ex-Rental.
	CD_Window()
	return
}
else if (CD_library)
{
	CD_condition := CD_condition + 2
}

;SET THE MAIN CONDITION PHRASE
CD_cond := CDArray[CD_condition]

;OUTPUT THE MACRO TEXT

SendRaw, %CD_cond%%Promo%%CD_ReplaceCase%%CD_Insert%%cd_notes%

Sleep, 2000

;RELOAD SCRIPT TO RESET VARIABLES
Reload

return

;------------------- END CD SUBMIT BUTTON FUNCTIONS -------------------

;------------------- BEGIN VG SUBMIT BUTTON FUNCTIONS -------------------
VG_OK:
;submit the variables
Gui, Submit

;FORM VALIDATION
If (!VG_condition)
{
	MsgBox,,Alert, Please select a condition.
	VG_Window()
	return
}

;ASK FOR USER INPUT IF ADDITIONAL NOTES ARE CHECKED
if (VG_more_notes)
{
	InputBox, VG_notes, Notes, Enter additional notes,,,150
	VG_notes := " " + FixText(VG_notes)
}

;CHECK IF REPLACED CASE BOX IS CHECKED OR NOT
if (VG_replacecase)
{
	if(VG_Condition < 3)
	{
		MsgBox,,Alert, If you replaced the case, you can't choose higher than GOOD.
		VG_Window()
		return
	}
	VG_ReplaceCase := " Replacement case."
}
else 
{
	VG_ReplaceCase := ""
}

;CHECK IF PAPERWORK INCLUDED BOX IS CHECKED OR NOT
if (VG_Paper)
{
	if(VG_condition = 1)
	{
		MsgBox,,Alert, Please uncheck the Includes Paperwork checkbox when choosing new condition.
		VG_Window()
		return
	}
	VG_Paper := " Any original paperwork is included."
}
else 
{
	VG_Paper := ""
}

;SET THE MAIN CONDITION PHRASE
VG_cond := VGArray[VG_condition]

;OUTPUT THE MACRO TEXT

SendRaw, Disc and Case %VG_cond% Perfect-Play Guarantee!%VG_ReplaceCase%%Paper%%VG_notes%

Sleep, 2000

;RELOAD SCRIPT TO RESET VARIABLES
Reload

return

;------------------- END VG SUBMIT BUTTON FUNCTIONS -------------------

;------------------- BEGIN SOFT SUBMIT BUTTON FUNCTIONS -------------------
SFT_OK:
;submit the variables
Gui, Submit

;FORM VALIDATION
If (!SFT_condition or !SFT_Container)
{
	MsgBox,,Alert, Please select both a container and a condition.
	SFT_Window()
	return
}

;ASK FOR USER INPUT IF ADDITIONAL NOTES ARE CHECKED
if (SFT_more_notes)
{
	InputBox, SFT_notes, Notes, Enter additional notes,,,150
	SFT_notes := " " + FixText(SFT_notes)
}

;CHECK IF REPLACED CASE BOX IS CHECKED OR NOT
if (SFT_replacecase)
{
	if(SFT_Condition < 3)
	{
		MsgBox,,Alert, If you replaced the case, you can't choose higher than GOOD condition.
		SFT_Window()
		return
	}
	SFT_ReplaceCase := " Replacement case."
}
else 
{
	SFT_ReplaceCase := ""
}

;CHECK IF PAPERWORK INCLUDED BOX IS CHECKED OR NOT
if (SFT_Paper)
{
	if(SFT_condition = 1)
	{
		MsgBox,,Alert, Please uncheck the Includes Paperwork checkbox when choosing new condition.
		SFT_Window()
		return
	}
	SFT_Paper := " Any original paperwork is included."
}
else 
{
	SFT_Paper := ""
}

;SET THE MAIN CONDITION PHRASE
SFT_cond := SFTArray[SFT_condition]

;OUTPUT THE MACRO TEXT

SendRaw, Disc and %SFT_Container% %SFT_cond% Perfect-Play Guarantee!%SFT_ReplaceCase%%SFT_Paper%%SFT_notes%

Sleep, 2000

;RELOAD SCRIPT TO RESET VARIABLES
Reload

return

;------------------- END SOFT SUBMIT BUTTON FUNCTIONS -------------------

