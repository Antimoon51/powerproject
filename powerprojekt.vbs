bElevate = False
if WScript.Arguments.Count > 0 Then If WScript.Arguments(WScript.Arguments.Count-1) <> "|" then bElevate = True
if bElevate Or WScript.Arguments.Count = 0 Then ElevateUAC 'Checks, if elevated, if not runs subroutine to elevate

msgbox "This programm shows you the devices, enabled to wake your PC up." & vbcrlf & "Please be aware, that this is not developed by professionals, but in my free time."&vbcrlf&vbcrlf&"Disclaimer:" &vbcrlf& "I do not take responsibility for any computers being harmed!" &vbcrlf& "Use of program on own risk.", 0, "WindowName"
msgbox "During the execution of the programm you will be asked, wich device you'd like to disable. You must give the exact name of the device. There will be a file named file.txt on your desktop, where you can copy the exact names from. This file will delete itselfe after the Programm finished."

Set oShell = CreateObject ("WScript.Shell")
Set oExec = oShell.Exec("CMD.EXE /C powercfg devicequery wake_armed")	'Asks for devices enabeld to wake, written in 'Devicearray'
Do While oExec.Status = 0
  WScript.Sleep 100
Loop

DeviceArray = Split(oExec.StdOut.ReadAll, vbCrLf)

msgbox Join(DeviceArray, vbcrlf)

With WScript.CreateObject("Scripting.FileSystemObject").CreateTextFile("C:\Users\Public\Desktop\file.txt", True)
    .Write Join(DeviceArray, vbCrLf)
    .Close
End With

device=inputbox (Join(DeviceArray, vbcrlf),"Disable")	'user asked for device to disable
if IsEmpty(device) Then
    msgbox "The action has ben canceld, the program is closing"
    Set oExec = oShell.Exec("CMD.EXE /C del C:\Users\Public\Desktop\file.txt")
    Wscript.Quit
End If

msgbox "Disable this device:" &vbcrlf& device,1,"WindowName"

Set oExec = oShell.Exec("cmd.exe /c powercfg devicedisablewake " &chr(34) & device &chr(34))

msgbox "The device " &vbcrlf&device&vbcrlf&"has been disabled"

Set oExec = oShell.Exec("CMD.EXE /C del C:\Users\Public\Desktop\file.txt")

'-----------------------------------------
'This is the subroutine to elevate script
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
