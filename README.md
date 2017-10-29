# Sort Stickies

Title: Sort Stickies
Date: 17/05/2016
Author: Lucas Ribeiro
Version: 0.0.3 (29/10/2017) 

## Description  

This script was written because I was sick and tired of having to move all Stickies notes   
to the place they were before a restarting or a logging out.  
It moves all Stickies notes to their corresponding desktop (space). The corresponding desktop   
must be explicitly written in the note (first characters), codified as ##N##, where "N" is the   
number of the desktop the note   
belongs to, or "-1" to ignore it.  

## Requirements

	- The program cliclick [1]. It should be placed at "~/", i.e. "/Users/your_use_name" (see variable "cliclick").  
	- The assignment of shortcuts "Switch to Desktop N" as "^N" (crtl + N)  
  
## Limitations:  
	- Only work with maximum of 9 desktops  
	- Needs external the dependence, i.e., the program "cliclick".  
 	- The note cannot be "Floating" (Menu: Note > Floating Window)  

## Obs.:

	- Only tested on El Capitan 10.11.4  
  
## Change log:  

   0.0.3:
      - Fix a bug that was preventing the notes to stay at the desktop after being left there. 
   0.0.2:
      - Now the script does not stop when something goes wrong with one sticky 
 	0.0.1:  
		- First version ( probably many bugs :D )  

## References.:  

	1 - https://github.com/BlueM/cliclick  
 
## Donations:  

  I am a student, thus I am always on a budget. If you liked and want to contribute, feel free to give whatever value you want.

[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg?style=flat-square&maxAge=2592000)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=XTZP5XLUKXAB6&lc=DE&item_name=Sort%20Stickies%20Notes&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted)
