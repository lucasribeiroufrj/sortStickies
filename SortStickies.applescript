# Title: Sort Stickies
# Date: 17/05/2016
# Author: Lucas Ribeiro
# Version: 0.0.1
#
# Description: 
#	This script was written because I was sick and tired of having to move all Stickies notes 
#	to the place they were before a restarting or a logging out.
#	It moves all Stickies notes to their corresponding desktop (space). The corresponding desktop 
#	must be explicitly written in the note (first characters), codified as ##N##, where "N" is the 
#	number of the desktop the note 
#	belongs to, or "-1" to ignore it.
#
#	Obs.:  
# Requirements:
#	- The program cliclick [1]. It should be placed at "~/", i.e. "/Users/your_use_name" (see variable "cliclick").
#	- The assignment of shortcuts "Switch to Desktop N" as "^N" (crtl + N)
#
# Limitations:
#	- Only work with maximum of 9 desktops
#	- Needs external the dependence, i.e., the program "cliclick".
# 	- The note cannot be "Floating" (Menu: Note > Floating Window)
#
# Obs.:
#	- Only tested on El Capitan 10.11.4
#
# Change log:
# 	0.0.2:
#		- Now the script does not stop when something goes wrong with one sticky 
# 	0.0.1:
#		- First version ( probably many bugs :D )
#
# References.:
#	1 - https://github.com/BlueM/cliclick

# ACHTUNG: Global variables, please change as soon as possible!! 
global is_to_log
global cliclick
global number_of_desktops

display dialog "Please wait untill proccess ends." with title "Alert!"

set is_to_log to false # Debugging mode
set cliclick to "~/cliclick"
set number_of_desktops to my get_number_of_desktops()

my close_stickies()

#my go_to_desktop(1) # NOT WORKING 
tell application "System Events" # WORKING
	key code 18 using control down
	delay 1
end tell

my launch_stickies()
delay 2

set list_of_windows to my get_windows()

repeat with ith_window in list_of_windows
	
	tell application "System Events"
		tell application "Stickies" to activate
		
		try
		
			tell application process "Stickies"
			
				# TODO - We should get the text from textfield instead!  Why? Because it should be possible to put the desktop "mark" anywhere on the text, not only in the beginning
				#set text_field to value of text area 1 of scroll area 1 of ith_window
			
				set text_field to name of ith_window
				set desktop_number to my extract_desktop_index(text_field)
			
				my DEBUG("Note belongs to desktop number " & desktop_number)
			
				if (desktop_number ­ -1) then
				
					set _pos to position of ith_window
					set _size to size of ith_window
				
					perform action "AXRaise" of ith_window
				
					my drag_to_desktop(_pos, _size, desktop_number)
				
					my go_to_desktop(1)
					delay 1
				end if
			
			end tell
			
		on error errMsg
			display dialog "Error: 
The text " & a_text & " ... 

Generated the following error:
" & errMsg
		end try

	end tell
end repeat

display notification "Finished!" with title "Sort Stickies notes" sound name "Glass"

# BEG - Functions declarations
#

on close_stickies()
	tell application "Stickies"
		quit
	end tell
end close_stickies

on launch_stickies()
	
	tell application "Stickies"
		launch
	end tell
end launch_stickies

# Use shortcut "crtl + k", k E [1,...,9], to change to desktop k
# ATTENTION: relies on the fact that the shortcuts were set.
on go_to_desktop(i)
	my DEBUG("Going to desktop " & i)
	set i to i as string
	do shell script cliclick & " kd:ctrl t:" & i & " c:-10,-10"
end go_to_desktop

on get_number_of_desktops()
	tell application "System Events"
		set plistFile to property list file "~/Library/Preferences/com.apple.spaces.plist"
		
		set itemNodes to property list items of property list item "Space Properties" of property list item "SpacesDisplayConfiguration" of plistFile
		
		return number of items in itemNodes
		
	end tell
	
end get_number_of_desktops

on extract_desktop_index(a_text)
	set AppleScript's text item delimiters to {"##", "##"}
	
	try
		set {tt, desktop_number} to text items 1 thru 2 of a_text
		my DEBUG("Desktop number is: " & desktop_number)
		set desktop_number to desktop_number as integer
	on error errMsg
		display dialog "Error: 
The text " & a_text & " ... 

Generated the following error:
" & errMsg
		return -1
	end try
	
	if (desktop_number < 2) or (desktop_number > number_of_desktops) then
		my DEBUG("Desktop index out of the range [1" & "," & number_of_desktops & "]")
		return -1
	end if
	
	return desktop_number
end extract_desktop_index

# ACHTUNG: Using temporary shell script - CHANGE ME!!
on drag_to_desktop(_position, _size, _desktop_number)
	my DEBUG("Dragging to desktop " & _desktop_number)
	
	set x to item 1 of _position
	set y to item 2 of _position
	set width to item 1 of _size
	set height to item 2 of _size
	
	set x_click to x + width / 2 as integer
	set y_click to y + 10 as integer
	
	set x_click to x_click as string
	set y_click to y_click as string
	
	try
		do shell script cliclick & " dd:" & quoted form of x_click & "," & quoted form of y_click & "  kd:ctrl t:" & _desktop_number & " du:" & quoted form of x_click & "," & quoted form of y_click
	on error errMsg
		display dialog "ERROR: " & errMsg
	end try
	
	
end drag_to_desktop

on DEBUG(input)
	if is_to_log then log input
end DEBUG

on get_windows()
	
	set list_windows to {}
	
	tell application "System Events"
		tell application process "Stickies"
			set L to name of every window
			
			repeat with awindow in L
				set w to (a reference to window awindow)
				copy w to the end of list_windows
			end repeat
			
			
			my DEBUG("Num of windows in this desktop: " & length of list_windows)
			
			return list_windows
		end tell
	end tell
	
end get_windows
#
# END - Functions declarations