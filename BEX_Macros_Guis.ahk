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
#include BEX_Macros_Globals.ahk


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

;------------------- CREATE MACRO BUTTONS GUI ------------------
Gui, MACRO: Font, s18, Verdana
Gui, MACRO: +AlwaysOnTop
Gui, MACRO: Add, Text, y20 w250, Buyback Express
Gui, MACRO: Add, Button, x25 y70 w200 gDVD, Movie
Gui, MACRO: Add, Button, x25 y130 w200 gBOOK, Book
Gui, MACRO: Add, Button, x25 y190 w200 gMUSIC, Music
Gui, MACRO: Add, Button, x25 y250 w200 gVIDEOGAME, Video Game
Gui, MACRO: Add, Button, x25 y310 w200 gSOFTWARE, Software
Gui, MACRO: Add, Button, x25 y370 w200 gCARD, Access Card
;Gui, MACRO: Add, text, x20 y430 w210 h5 border, 
;Gui, MACRO: Add, Button, x25 y445 w200 gNOPAY, No Pay

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

;------------------- Create GAME GUI ---------------------
Gui, VG: Font, s18
Gui, VG: Add, Text, x30 y10 w260 Center, -- Condition --
Gui, VG: Add, ddl, vVG_Condition x30 y50 w260 Center AltSubmit, New|Very Good|Good|Acceptable
Gui, VG: Add, Checkbox, vVG_More_Notes x340 y110, Additional Notes?
Gui, VG: Add, Checkbox, vVG_ReplaceCase x30 y110, Replaced Case?
Gui, VG: Add, Checkbox, vVG_Paper x30 y150, Includes Paperwork?
Gui, VG: Add, Button, gVG_OK x320 y230 w100 Default, OK
Gui, VG: Add, Button, x460 y230 w100 gCancel, Cancel

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