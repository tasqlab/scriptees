Set WshShell = CreateObject("WScript.Shell") 
' The 0 makes it hidden. Change to 1 if you want to see it for testing.
WshShell.Run chr(34) & "activity_logger.bat" & Chr(34), 0
Set WshShell = Nothing