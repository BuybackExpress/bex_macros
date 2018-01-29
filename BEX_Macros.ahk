#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
#NoTrayIcon

version := "1.7.1b"

;------------------------- Global Variables -------------------
WTR_Degree := ""
WTR_Location := ""
WTR_Extent := ""
WTR_String := ""


;------------------- CREATE SPLASH GUI -------------------
Gui, SPLASH: Font, s16 w700, Verdana
Gui, SPLASH: +AlwaysOnTop
Gui, SPLASH: Add, Text, x10 y20 w335 Center, Buyback Express Macros
Gui, SPLASH: Font, s16 w600, Verdana
Gui, SPLASH: Add, Text, cRed w900 x10 y45 w335 Center, %version%
Gui, SPLASH: Font, s12 w700, Verdana
Gui, SPLASH: Add, Text, x10 y100 w335 Center, Developed by:
Gui, SPLASH: Font, s12 w400, Verdana
Gui, SPLASH: Add, Text, x10 y130 w335 Center, Nathan Mangoff
Gui, SPLASH: Add, Text, x10 y155 w335 Center, Aaron Spurlock
Gui, SPLASH: Font, s10, Verdana

Splash() {
	Gui, SPLASH: Show, w350 h200, About BEX Macros
	Sleep, 5000
	WinClose, About BEX Macros
}
;------------------- END SPLASH GUI --------------------------

;------------------- CREATE MACRO BUTTONS GUI ------------------
Gui, MACRO: Font, s18, Verdana
Gui, MACRO: +AlwaysOnTop
Gui, MACRO: -MinimizeBox
Gui, MACRO: Add, Text, y20 w250, Buyback Express
Gui, MACRO: Add, Button, x25 y70 w200 gDVD, Movie
Gui, MACRO: Add, Button, x25 y130 w200 gBOOK, Book
Gui, MACRO: Add, Button, x25 y190 w200 gMUSIC, Music
Gui, MACRO: Add, Button, x25 y250 w200 gVIDEOGAME, Video Game
Gui, MACRO: Add, Button, x25 y310 w200 gSOFTWARE, Software
Gui, MACRO: Add, Button, x25 y370 w200 gCARD, Access Card


Macro_Window() {
	width := A_ScreenWidth - 270
	Gui, MACRO: Show, x%width% y20 w250 h440, BEX Macros
}

;------------------- END MACRO BUTTONS GUI ---------------------

;------------------- Create DVD GUI -------------------
Gui, DVD: Font, s18
Gui, DVD: Add, Text, x30 y10 w260 Center, -- Format --
Gui, DVD: Add, ddl, vFormat x30 y50 w260 Center, DVD|Blu-ray|Combo|HD-DVD|PSP Video
Gui, DVD: Add, Text, x30 y100 w260 Center, -- Condition --
Gui, DVD: Add, ddl, vDVD_Condition x30 y140 w260 Center AltSubmit, New|Like New|Very Good|Acceptable
Gui, DVD: Add, Checkbox, vDVD_More_Notes x340 y30, Additional Notes?
Gui, DVD: Add, Checkbox, vDVD_ReplaceCase x340 y75, Replaced Case?
Gui, DVD: Add, Checkbox, vLibrary x340 y120, Ex-Rental?
Gui, DVD: Add, Checkbox, vDigitalCode x340 y165, Digital Code?
Gui, DVD: Add, Button, gDVD_OK x320 y230 w100 Default, OK
Gui, DVD: Add, Button, x460 y230 w100 gCancel, Cancel

DVD_Window() {
	Gui, DVD: Show, w600 h300, DVD Macros
}

DVDArray := ["in NEW Condition!","in LIKE NEW condition with no signs of wear.","in Very Good Condition with only light, reasonable wear. Perfect-Play Guarantee!","in Acceptable Condition with noticeable wear. Perfect-Play Guarantee!", "have considerable wear and library stickers/marks, but comes with our Perfect-Play Guarantee."]

;------------------- END DVD GUI -------------------

;------------------- Create BOOK GUI -------------------
Gui, BOOK: Font, s18
Gui, BOOK: Add, Text, x30 y10 w260 center, -- Condition --
Gui, BOOK: Add, ddl, vBOOK_Condition x30 y50 w290 Center AltSubmit, New|Like New|Very Good|Good|Acceptable
Gui, BOOK: Add, Text, x30 y100 w260 Center, -- Edition --
Gui, BOOK: Add, ddl, vBOOK_Edition x30 y140 w290 Center AltSubmit, Standard Edition||Loose-Leaf|Instructor's Edition|Advanced Reader|International
Gui, BOOK: Add, Text, x30 y200 w200, Access Card?
Gui, BOOK: Add, DDL, vBOOK_AccessCard x200 y195 w120 AltSubmit, Yes|No|N/A||
Gui, BOOK: Add, Text, x30 y250 w200, Disc Included?
Gui, BOOK: Add, DDL, vbook_disc x200 y245 w120 AltSubmit, Yes (CD)|Yes (DVD)|No|N/A||
Gui, BOOK: Add, Checkbox, vMarkings x350 y30, Markings?
Gui, BOOK: Add, Checkbox, vBOOK_Library x350 y75, Ex-Rental?
Gui, BOOK: Add, Checkbox, vBOOK_More_Notes x350 y120, Additional Notes? 
Gui, BOOK: Add, Checkbox, vBOOK_Water x350 y165, Water Damage?
Gui, BOOK: Add, Button, gBook_OK x350 y230 w100 Default, OK
Gui, BOOK: Add, Button, x470 y230 w100 gCancel, Cancel


BOOK_Window() {
	Gui, BOOK: Show, w600 h300, Book Macros
}

BOOKArray := ["BRAND NEW BOOK!!","Book in Like New Condition!","Very Good condition. Light, reasonable wear.","Good condition with reasonable wear.","Fairly worn, but still very usable.","Good Condition. Reasonable wear. Still very usable. Ex-library with usual distinguishments (stamps, stickers, etc.)","Noticeable wear, but still very usable. Ex-library with usual distinguishments (stamps, stickers, etc.)"]
EdArray := [""," Loose-Leaf Edition."," Teacher Edition. Not for Sale."," Advanced Reader Copy. Not for Sale."," International Edition."]

;------------------- END BOOK GUI -------------------

;------------------- Create WATER DAMAGE GUI ---------------------

Gui, WATER: Font, s18
Gui, WATER: Add, Text, x30 y20 w300 center, -- Degree of Damage --
Gui, WATER: Add, DDL, vWTR_Degree x30 y50 w300 center, Minor||Moderate|Significant
Gui, WATER: Add, Text, x30 y100 w300 center, -- Location of Damage --
Gui, WATER: Add, ListBox, vWTR_Location x30 y140 w300 h200 center 8, Top Corner||Bottom Corner|Inside Edge|Outside Edge|Top Page Edge|Bottom Page Edge
Gui, WATER: Add, Text, x30 y340 w300 center, -- Extent of Damage --
Gui, WATER: Add, Edit, vWTR_Extent gWTR_ChkDta x30 y380 w300 center
Gui, WATER: Add, Button, gWTR_OK x100 y450 w100 Default +Disabled, OK
Gui, WATER: Add, Button, gCancel x230 y450 w100, Cancel

Water_Window(){
	Global
	Gui, WATER: Show, w360 h510, Water Damage
	WinWaitClose, Water Damage
}

GetWaterDamage() {
	
	global
	Water_Window()
	StringLower, WTR_Extent, WTR_Extent
	WTR_Location := RegExReplace(WTR_Location, "\|",", ")
	StringLower, WTR_Location, WTR_Location
	return " " WTR_Degree . " damp-staining along " . WTR_Location . " to " . WTR_Extent . " of book, but visual defect only: no stickiness, scent, etc. and *Does Not Affect Text or Use of Book.*"
}

;------------------- END WATER DAMAGE GUI ------------------------

;------------------- Create CD GUI ---------------------
Gui, CD: Font, s18
Gui, CD: Add, Text, x30 y10 w260 Center, -- Condition --
Gui, CD: Add, ddl, vCD_Condition x30 y50 w260 Center AltSubmit, New|Very Good|Good|Acceptable
Gui, CD: Add, Checkbox, vCD_More_Notes x340 y110, Additional Notes?
Gui, CD: Add, Checkbox, vCD_ReplaceCase x340 y150, Replaced Case?
Gui, CD: Add, Checkbox, vCD_Library x30 y110, Ex-Rental?
Gui, CD: Add, Checkbox, vCD_Insert x30 y150, Missing Insert?
Gui, CD: Add, Checkbox, vPromo x30 y190, Promotional Copy?
Gui, CD: Add, Button, gCD_OK x320 y230 w100 Default, OK
Gui, CD: Add, Button, x460 y230 w100 gCancel, Cancel

CD_Window() {
	Gui, CD: Show, w600 h300, CD Macros
}

CDArray := ["BRAND NEW IN SHRINKWRAP!","Very Good or better condition. CD in Very Good shape with only light, reasonable wear. Perfect-play Guarantee!","Art and case in reasonable or better condition. CD shows some wear, but is Guaranteed to Play Perfectly!","Art and case in reasonable or better condition. CD shows noticeable wear, but is Guaranteed to Play Perfectly!","Art and case in reasonable or better condition. CD shows some wear, but is Guaranteed to Play Perfectly! Library stickers/marks on art and CD.","Art and case in reasonable or better condition. CD shows noticeable wear, but is Guaranteed to Play Perfectly! Library stickers/marks on art and CD."]

;------------------- END CD GUI ---------------------

;------------------- Create GAME GUI ---------------------
Gui, VG: Font, s18
Gui, VG: Add, Text, x30 y10 w260 Center, -- Condition --
Gui, VG: Add, ddl, vVG_Condition x30 y50 w260 Center AltSubmit, New|Very Good|Good|Acceptable
Gui, VG: Add, Checkbox, vVG_More_Notes x340 y110, Additional Notes?
Gui, VG: Add, Checkbox, vVG_ReplaceCase x30 y110, Replaced Case?
Gui, VG: Add, Checkbox, vVG_Paper x30 y150, Includes Paperwork?
Gui, VG: Add, Button, gVG_OK x320 y230 w100 Default, OK
Gui, VG: Add, Button, x460 y230 w100 gCancel, Cancel

VG_Window() {
	Gui, VG: Show, w600 h300, Video Game Macros
}

VGArray := ["in NEW Condition!","in Very Good Condition. Light, reasonable wear.","in Good Condition with reasonable wear.","in Acceptable Condition with noticeable wear."]

;------------------- END GAME GUI ---------------------

;------------------- Create SOFT GUI ---------------------
Gui, SFT: Font, s18
Gui, SFT: Add, Text, x30 y10 w260 Center, -- Condition --
Gui, SFT: Add, ddl, vSFT_Condition x30 y50 w260 Center AltSubmit, New|Very Good|Good|Acceptable
Gui, SFT: Add, Text, x30 y100 w260 Center, -- Container --
Gui, SFT: Add, DDL, vSFT_Container x30 y140 w260 Center, Box|Case
Gui, SFT: Add, Checkbox, vSFT_More_Notes x340 y50, Additional Notes?
Gui, SFT: Add, Checkbox, vSFT_ReplaceCase x340 y95, Replaced Case?
Gui, SFT: Add, Checkbox, vSFT_Paper x340 y140, Includes Paperwork?
Gui, SFT: Add, Button, gSFT_OK x320 y230 w100 Default, OK
Gui, SFT: Add, Button, x460 y230 w100 gCancel, Cancel

SFT_Window() {
	Gui, SFT: Show, w600 h300, Software Macros
}

SFTArray :=["in NEW Condition!","in Very Good Condition. Light, reasonable wear","in Good Condition with some reasonable wear, but come with","have noticeable wear, but come with"]

;------------------- END SOFT GUI ---------------------

;------------------- CARD Phrase ---------------------

CRD_Phrase() {
	SendRaw, New, Unused Access Code! Code Guaranteed to Work!
	;reload
}

;------------------- END CARD Phrase ---------------------

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
;------------------- END FIX TEXT -----------------------

;END MAKING GUIS

Macro_Window()

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

