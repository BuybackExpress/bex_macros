# Changelog

All notable changes to this porject will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/).

## [Unreleased]
* Proper Version Checking for Updater

---

## [1.7.5.1135] - 2018-04-02

### CHANGED
* Corrected DVD check to ensure only Very Good or Acceptable lack a valid code.


---

## [1.7.4.1228] - 2018-03-26

### CHANGED
* Corrected an issue with the Video Game macro that was not outputting the paperwork included phrase


---

## [1.7.3.1150] - 2018-03-08

### CHANGED
* Modified installers and updater to using new locations.
* Installers and updaters also do not fail when a file is not found.


---

## [1.7.2.1606] - 2018-02-01

### CHANGED
* Moved Functions, Globals, and Gui definitions to include files.


---

## [1.7.2.1321] - 2018-01-31

### ADDED
* Added minimize option back into the main macro window


---

## [1.7.1.0853] - 2018-01-31

### REMOVED
* Removed run as admin from all scripts because it wasn't working.


---

## [1.7.1.1441] - 2018-01-30

### ADDED
* Changed file path variables to global variables so that they will be correct when running as admin.


---

## [1.7.1.5036] - 2018-01-29

### ADDED
* Added NoPay script. No current implementation.


---

## [1.7.1b] - 2018-01-03

### FIXED
* Added a sleep just before reload so that the macro gui doesn't steal focus too quickly


---

## [1.7.0b] - 2018-01-03

### ADDED
* Installer Creates shortcut in startup


---

## [1.6.0b] - 2018-01-03

### ADDED
* New button and corresponding phrase for stand alone access cards


---
## [1.5.0b] - 2018-01-03

### ADDED
* New App to update the Launcher
* New Installer


---

## [1.4.0b] - 2018-01-02

### ADDED
* Added a GUI to launch macro windows via buttons

---

## [1.3.1b] - 2018-01-02

### ADDED
* Updater now checks actual version numbers in changelog.

### FIXED
* Fixed some redundancy in an array

---

## [1.2.0b] - 2017-12-29

### CHANGED
* Cleaned up About GUI

---

## [1.1.0b] - 2017-12-29

### ADDED
* Updater now has a progress bar.
* Updater code is fully commented now.

### CHANGED
* GUI colors and formatting were tidying up.

### REMOVED
* Updater no longer has status text.
* Removed clutter from updater GUI.
* To give user time to read text, we had arbitrary pauses. No more.This should drastically speed up the updating.

---
## [1.0.0-b] - 2017-12-27

### ADDED
* Added and mofified variants for included discs.
  * DVD Included!
  * Sealed DVD Included!
  * CD Included!
  * Sealed CD Included!

### CHANGED
* Started using standarized versioning.
* Additional notes now forces the first letter to be capitalized.
* "Perfect Play" is now "Perfect-Play."
* "Bluray" is now "Blu-Ray"
* Modified Macro Triggers
  * #bk
  * #dvd
  * #cd
  * #vg
* You can now choose the digital code option for "Very Good" DVDs.
* CTRL is no longer necessary to select more than one option for water damage.
* If there's water damage, text now reads "Mark-free interior!" instead of "Clean, mark-free interior!"

### FIXED
* Various grammar and spelling corrections.