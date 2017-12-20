#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

;------------------- Create DVD GUI -------------------
Gui, DVD: Add, Text, x10 y10 w225 Center, -- Format --
Gui, DVD: Add, ddl, vFormat x10 y30 w225 Center, DVD|Bluray|Combo|HD-DVD|PSP Video
Gui, DVD: Add, Text, x10 y65 w225 Center, -- Condition --
Gui, DVD: Add, ddl, vDVD_Condition x10 y80 w225 Center AltSubmit, New|Like New|Very Good|Acceptable||
Gui, DVD: Add, Checkbox, vDVD_More_Notes x10 y120, Additional Notes?
Gui, DVD: Add, Checkbox, vDVD_ReplaceCase x10 y140, Replaced Case?
Gui, DVD: Add, Checkbox, vLibrary x130 y120, Ex-Rental?
Gui, DVD: Add, Checkbox, vDigitalCode x130 y140, Digital Code?
Gui, DVD: Add, Button, gDVD_OK y170 x130 w50 Default, OK
Gui, DVD: Add, Button, y170 x190 w50 gCancel, Cancel

DVD_Window() 
{
	Gui, DVD: Show, w250 h200, DVD Macros
}

DVDArray := ["in NEW Condition!","in Very Good Condition with only light, resaonable wear. Perfect Play Guarantee!","in Good Condition with reasonable wear. Perfect Play Guarantee!","in Acceptable Condition with noticeable wear. Perfect Play Guarantee!", "in reasonable or better condition with library stickers/marks. Perfect Play Guarantee!", "have considerable wear and library stickers/marks, but comes with our Perfect Play Guarantee."]
;------------------- END DVD GUI -------------------

;------------------- Create BOOK GUI -------------------
Gui, BOOK: Add, Text, x10 y10 w250 center, -- Condition --
Gui, BOOK: Add, ddl, vBOOK_Condition x10 y30 w250 Center AltSubmit, New|Like New|Very Good|Good|Acceptable
Gui, BOOK: Add, Text, x10 y60 w250 Center, -- Edition --
Gui, BOOK: Add, ddl, vBOOK_Edition x10 y80 w250 Center, Standard Edition||Loose-Leaf|Instructor's Edition|Advanced Reader|International
Gui, BOOK: Add, Text, x10 y120 w120, Access Card?
Gui, BOOK: Add, DDL, vBOOK_AccessCard x80 y115 w45 AltSubmit, Yes|No|N/A||
Gui, BOOK: Add, Text, x145 y120 w120, CD Included?
Gui, BOOK: Add, DDL, vBOOK_CD x215 y115 w45 AltSubmit, Yes|No|N/A||
Gui, BOOK: Add, Checkbox, vBOOK_Markings x10 y150, Markings?
Gui, BOOK: Add, Checkbox, vBOOK_Library x90 y150, Ex-Rental?
Gui, BOOK: Add, Checkbox, vBOOK_More_Notes x10 y180, Additional Notes?
Gui, BOOK: Add, Button, gBook_OK y200 x150 w50 Default, OK
Gui, BOOK: Add, Button, y200 x210 w50 gCancel, Cancel
; ------------------- END BOOK GUI -------------------

BOOK_Window() {
	Gui, BOOK: Show, w270 h230, Book Macros
}

BOOKArray := ["NEW","Like New","Very Good condition. Light, reasonable wear.","Good condition with reasonable wear.","Fairly worn, but still very usable."]

;------------------- Create CD GUI ---------------------
Gui, CD: Add, Text, x10 y10 w225 Center, -- Condition --
Gui, CD: Add, ddl, vCD_Condition x10 y30 w225 Center AltSubmit, New|Very Good|Good|Acceptable
Gui, CD: Add, Checkbox, vCD_More_Notes x10 y70, Additional Notes?
Gui, CD: Add, Checkbox, vCD_ReplaceCase x10 y90, Replaced Case?
Gui, CD: Add, Checkbox, vCD_Library x130 y70, Ex-Rental?
Gui, CD: Add, Checkbox, vCD_Insert x130 y90, Missing Insert?
Gui, CD: Add, Checkbox, vPromo x10 y110, Promotional Copy?
Gui, CD: Add, Button, gCD_OK y120 x130 w50 Default, OK
Gui, CD: Add, Button, y120 x190 w50 gCancel, Cancel

CD_Window() {
	Gui, CD: Show, w250 h150, CD Macros
}

CDArray := ["BRAND NEW IN SHRINKWRAP!","Very Good or better condition. CD in Very Good shape with only light, reasonable wear. Perfect-play Guarantee!","Art and case in reasonable or better condition. CD shows some wear, but is Guaranteed to Play Perfectly!","Art and case in reasonable or better condition. CD shows noticeable wear, but is Guaranteed to Play Perfectly!","Art and case in reasonable or better condition. CD shows some wear, but is Guaranteed to Play Perfectly! Library stickers/marks on art and CD.","Art and case in reasonable or better condition. CD shows noticeable wear, but is Guaranteed to Play Perfectly! Library stickers/marks on art and CD."]
;------------------- END CD GUI ---------------------

;------------------- Create GAME GUI ---------------------
Gui, VG: Add, Text, x10 y10 w225 Center, -- Condition --
Gui, VG: Add, ddl, vVG_Condition x10 y30 w225 Center AltSubmit, New|Very Good|Good|Acceptable
Gui, VG: Add, Checkbox, vVG_More_Notes x10 y70, Additional Notes?
Gui, VG: Add, Checkbox, vVG_ReplaceCase x10 y90, Replaced Case?
Gui, VG: Add, Checkbox, vVG_Paper x130 y70, Includes Paperwork?
Gui, VG: Add, Button, gVG_OK y120 x130 w50 Default, OK
Gui, VG: Add, Button, y120 x190 w50 gCancel, Cancel

VG_Window() {
	Gui, VG: Show, w250 h150, Video Game Macros
}

VGArray := ["in NEW Condition!","in Very Good Condition. Light, reasonable wear","in Good Condition with reasonable wear","Acceptable Condition with noticeable wear"]
;------------------- END GAME GUI ---------------------

;END MAKING GUIS

;------------------- BEGIN DVD HOTKEY -------------------
::#dvd::
DVD_Window()
return
;------------------- END DVD HOTKEY -------------------

;------------------- BEGIN BOOK HOTKEY -------------------
::#book::
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

;------------------- BEGIN DVD SUBMIT BUTTON FUNCTIONS -------------------
DVD_OK:
;submit the variables
Gui, Submit

;FORM VALIDATION
If (!format or !dvd_condition)
{
	MsgBox,,Alert, Please select both a condition and format.
	DVD_Window()
	return
}

;ASK FOR USER INPUT IF ADDITIONAL NOTES ARE CHECKED

if (dvd_more_notes)
{
	InputBox, dvd_notes, Notes, Enter additional notes,,,150
	dvd_notes := " " + dvd_notes
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
	if(dvd_condition < 4)
	{
		MsgBox,,Nope, Items missing a DIGITAL CODE cannot be listed higher than ACCEPTABLE.
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
	dvd_condition := dvd_condition + 2

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
if (format := "Combo")
{
	format := "All Discs" 
}

;SET THE MAIN CONDITION PHRASE
cond := DVDArray[dvd_condition]

;OUTPUT THE MACRO TEXT

SendRaw, %Format% and Case %cond%%dvd_replacecase%%DigitalCode%%dvd_notes%

;RELOAD SCRIPT TO RESET VARIABLES
Reload

return

;------------------- END DVD SUBMIT BUTTON FUNCTIONS -------------------

;------------------- CANCEL BUTTON CLOSES WINDOWS -------------------
Cancel:
WinClose
Reload
return
;------------------- END CANCEL BUTTON CLOSES WINDOWS

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
}


;CHECK IF MARKINGS BOX IS CHECKED OR NOT
IfEqual, Markings, true
{
	Markings := " Clean, mark-free interior!"
}
else 
{
	Markings := " May include limited notes and/or highlighting."
}

;SET THE MAIN CONDITION PHRASE
book_cond := BOOKArray[book_condition]

;OUTPUT MACRO TEXT
SendRaw, %book_cond%%Promo%%markings%%book_notes%

;RELOAD SCRIPT TO RESET VARIABLES
Reload

return
;------------------- END BOOK SUBMIT BUTTON FUNCTIONS -------------------

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
	cd_notes := " " + cd_notes
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

;CHECK IF DIGITAL CODE BOX IS CHECKED OR NOT
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
	VG_notes := " " + VG_notes
}

;CHECK IF REPLACED CASE BOX IS CHECKED OR NOT
if (VG_replacecase)
{
	if(VG_Condition < 3)
	{
		MsgBox,,Alert, Please uncheck the Replaced Case checkbox when choosing new or very good condition.
		CD_Window()
		return
	}
	VG_ReplaceCase := " Replacement case."
}
else 
{
	VG_ReplaceCase := ""
}

;CHECK IF DIGITAL CODE BOX IS CHECKED OR NOT
if (VG_Paper)
{
	if(VG_condition = 1)
	{
		MsgBox,,Alert, Please uncheck the Includes Paperwork checkbox when choosing new condition.
		VG_Window()
		return
	}
	Paper := " Any original paperwork is included."
}
else 
{
	Paper := ""
}

;SET THE MAIN CONDITION PHRASE
VG_cond := VGArray[VG_condition]

;OUTPUT THE MACRO TEXT

SendRaw, Disc and Case %VG_cond% Perfect-Play Guarantee!%VG_ReplaceCase%%Paper%%VG_notes%

;RELOAD SCRIPT TO RESET VARIABLES
Reload

return

;------------------- END VG SUBMIT BUTTON FUNCTIONS -------------------