#!/usr/bin/osascript
on main()
	tell application "System Events" to set appNames to name of application processes whose visible is true
	tell application (path to frontmost application as text) to Â
		set appChoice to (choose from list appNames with prompt "Which running application?" with title "Choose an application")
	if (appChoice is false) then error number -128
	set appName to item 1 of appChoice
	
	tell application "System Events"
		tell application process appName
			set frontmost to true
			set {windowExists, menuExists} to {front window exists, menu bar 1 exists}
			set {winstuff, menustuff} to {"(No window open)", "(No menu!)"}
			if (windowExists) then set winstuff to my listToText(entire contents of front window)
			if (menuExists) then set menustuff to my listToText(entire contents of menu bar 1)
		end tell
	end tell
	
	tell application "TextEdit"
		activate
		make new document at the front
		set the text of the front document to winstuff & return & "-----" & return & menustuff
		set WrapToWindow to text 2 thru -1 of (localized string "&Wrap to Window")
	end tell
	
	tell application "System Events"
		tell application process "TextEdit"
			tell menu item WrapToWindow of menu 1 of menu bar item 5 of menu bar 1
				if ((it exists) and (it is enabled)) then perform action "AXPress"
			end tell
		end tell
	end tell
end main

on listToText(entireContents) -- (Handler specialised for lists of System Events references.)
	try
		|| of entireContents -- Deliberate error.
	on error stuff -- Get the error message
	end try
	
	-- Parse the message.
	set astid to AppleScript's text item delimiters
	set AppleScript's text item delimiters to {"{", "}"} -- Snow Leopard or later.
	set stuff to text from text item 2 to text item -2 of stuff
	
	-- If the list text isn't in decompiled form, create a script containing the list in its source code, store it in the Temporary Items folder, and run "osadecompile" on it.
	if (stuff does not contain "application process \"") then
		try
			set scpt to (run script "script
   tell app \"System Events\"
   {" & stuff & "}
   end
   end")
		on error errMsg
			set AppleScript's text item delimiters to astid
			tell application (path to frontmost application as text) to display dialog errMsg buttons {"OK"} default button 1 with icon caution
			return errMsg
		end try
		set tmpPath to (path to temporary items as text) & "Entire contents.scpt"
		store script scpt in file tmpPath replacing yes
		set stuff to (do shell script "osadecompile " & quoted form of POSIX path of tmpPath)
		set stuff to text from text item 2 to text item -2 of stuff
	end if
	
	-- Break up the text, using "\"System Events\", " as a delimiter.
	set AppleScript's text item delimiters to "\"System Events\", "
	set stuff to stuff's text items
	-- Insert a textual "reference" to the root object at the beginning of the resulting list.
	set AppleScript's text item delimiters to " of "
	set beginning of stuff to (text from text item 2 to -1 of item 1 of stuff) & "\"System Events\""
	-- Reduce the remaining "reference" fragments to object specifiers, tabbed according to the number of elements in the references.
	set tabs to tab & tab & tab & tab & tab & tab & tab & tab
	set tabs to tabs & tabs
	set tabs to tabs & tabs -- 32 tabs should be enough!
	repeat with i from 2 to (count stuff)
		set thisLine to item i of stuff
		set lineBits to thisLine's text items
		-- Make sure any " of "s in element names aren't mistaken for those of the reference!
		set elementCount to 0
		set nameContinuation to false
		repeat with j from 1 to (count lineBits)
			set thisBit to item j of lineBits
			if ((not ((nameContinuation) or (thisBit contains "\""))) or ((thisBit ends with "\"") and (thisBit does not end with "\\\"")) or (thisBit ends with "\\\\\"")) then
				-- thisBit is either a complete nameless-element specifier or it ends the right way to be either a complete named one or the completion of a name.
				set nameContinuation to false
				set elementCount to elementCount + 1
				if (elementCount is 1) then set spec to text 1 thru text item j of thisLine
			else
				-- The next "bit" will be the continuation of a name containing " of ".
				set nameContinuation to true
			end if
		end repeat
		set item i of stuff to (text 1 thru (elementCount - 3) of tabs) & spec
	end repeat
	-- Coerce back to a single text, inserting line feeds between the items.
	set AppleScript's text item delimiters to linefeed
	set stuff to stuff as text
	set AppleScript's text item delimiters to astid
	
	return stuff
end listToText

main()