bElevate = False
if WScript.Arguments.Count > 0 Then If WScript.Arguments(WScript.Arguments.Count-1) <> "|" then bElevate = True
if bElevate Or WScript.Arguments.Count = 0 Then ElevateUAC
msgbox "This programm shows you the devices, enabled to wake your PC up." & vbcrlf & "Please be aware, that this is not developed by professionals, but in my free time.", 0, "WindowName"
msgbox "Disclaimer:" &vbcrlf& "I do not take responsibility for any computers being harmed!" &vbcrlf& "Use of program on own risk.", 0, "WindowName"

Set oShell = CreateObject ("WScript.Shell")
Set oExec = oShell.Exec("CMD.EXE /C powercfg devicequery wake_armed")
Do While oExec.Status = 0
  WScript.Sleep 100
Loop

DeviceArray = Split(oExec.StdOut.ReadAll, vbCrLf)

msgbox Join(DeviceArray, vbcrlf)

With WScript.CreateObject("Scripting.FileSystemObject").CreateTextFile("temp.txt", True)
  .Write Join(DeviceArray, vbCrLf)
  .Close
End With

device=inputbox (Join(DeviceArray, vbcrlf),"Disable")
msgbox "Disable this device:" &vbcrlf& device,1,"WindowName"

Set objFileToWrite = CreateObject("Scripting.FileSystemObject").OpenTextFile("file.bat",2,true)
objFileToWrite.WriteLine("powercfg devicedisablewake " &chr(34)& device &chr(34))
objFileToWrite.Close
Set objFileToWrite = Nothing

'---------------------------------------
'Elevate this script before invoking it.
'25.2.2011 FNL
'---------------------------------------

Set oWshShell = CreateObject("WScript.Shell")
Set otexe = oWshShell.Exec("cmd.exe /c powercfg devicedisablewake " &chr(34) & device &chr(34))

test=Split(otexe.StdOut.ReadAll, vbcrlf)
msgbox Join(test, vbcrlf),0,"WindowName"

'-----------------------------------------
'Run this script under elevated privileges
'-----------------------------------------
Sub ElevateUAC
    sParms = " |"
    If WScript.Arguments.Count > 0 Then
            For i = WScript.Arguments.Count-1 To 0 Step -1
            sParms = " " & WScript.Arguments(i) & sParms
        Next
    End If
Set oShell = CreateObject("Shell.Application")
    oShell.ShellExecute "wscript.exe", WScript.ScriptFullName & sParms, , "runas", 1
    WScript.Quit
End Sub



'Set oExec = oShell.Exec("C:\Windows\System32\CMD.EXE /C powercfg devicequery wake_armed")
'MyArray = Split(oExec.StdOut.ReadAll, vbcrlf)
'msgbox Join(MyArray, vbcrlf),0,"richtig"
