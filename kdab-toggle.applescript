#!/usr/bin/osascript
tell application "Mail"
	tell account "KDAB"
		if enabled then
			set enabled to false
		else
			set enabled to true
			check for new mail
		end if
	end tell
end tell

tell application "iChat"
	tell service "KDAB"
		if enabled then
			set enabled to false
		else
			set enabled to true
			log in
		end if
	end tell
end tell
