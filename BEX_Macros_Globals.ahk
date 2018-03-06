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


; All Globals
spath := "\\be-localserver\Shared\Source\"
dpath = %A_MyDocuments%\BEX Macros\
clog = %dpath%CHANGELOG.md
startupPath = %A_AppData%\Microsoft\Windows\Start Menu\Programs\Startup\
; File paths for destination and source files
; 1 = ChangeLog.md
; 2 = BEX_Macros.exe
; 3 = BEX_Macros_Launcher.exe
; 4 = BEX_Macros_Updater.exe
dfiles := [dpath . "ChangeLog.md", dpath . "BEX_Macros.exe", dpath . "BEX_Macros_Launcher.exe", dpath . "BEX_Macros_Updater.exe"]
sfiles := [spath . "ChangeLog.md", spath . "BEX_Macros.exe", spath . "BEX_Macros_Launcher.exe", spath . "BEX_Macros_Updater.exe"]

