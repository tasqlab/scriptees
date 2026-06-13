Set WshShell = CreateObject("WScript.Shell") 
' The 0 makes it hidden. The command runs PowerShell with ExecutionPolicy Bypass.
WshShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & CreateObject("Scripting.FileSystemObject").GetAbsolutePathName("safe_logger.ps1") & """", 0
Set WshShell = Nothing