Opt("GuiOnEventMode",1)
Opt("TrayOnEventMode",1)
Opt("TrayMenuMode",1); no default tray menuitems
#NoTrayIcon
#include <GUIConstants.au3>

Global $infolabel
Global $sleepTime
Global $pause = 1

;---------------Tray event values----------------

Global $TRAY_EVENT_SHOWICON         = -3
Global $TRAY_EVENT_HIDEICON         = -4
Global $TRAY_EVENT_FLASHICON        = -5
Global $TRAY_EVENT_NOFLASHICON      = -6
Global $TRAY_EVENT_PRIMARYDOWN      = -7
Global $TRAY_EVENT_PRIMARYUP        = -8
Global $TRAY_EVENT_SECONDARYDOWN    = -9
Global $TRAY_EVENT_SECONDARYUP      = -10
Global $TRAY_EVENT_MOUSEOVER        = -11
Global $TRAY_EVENT_MOUSEOUT         = -12
Global $TRAY_EVENT_PRIMARYDOUBLE    = -13
Global $TRAY_EVENT_SECONDARYDOUBLE  = -14
    
;---------------Build UI----------------
TraySetClick(16)

$runitem = TrayCreateItem("Set Timeout")
TrayItemSetOnEvent(-1,"SetTimeout")
TrayCreateItem("")
$infoitem = TrayCreateItem("About")
TrayItemSetOnEvent(-1,"DisplayAbout")
TrayCreateItem("")
$exititem = TrayCreateItem("Exit")
TrayItemSetOnEvent(-1,"ExitEvent")

TraySetIcon(@AutoItExe)

TraySetState()
TraySetToolTip("KillSaver 1.2")

;---------------Set initial variables----------------

$lastpos = MouseGetPos()
$PreviousSetting = RegRead("HKEY_CURRENT_USER\SOFTWARE\KillSaver\", "Timeout")
If $PreviousSetting <> "" Then
    $sleepTime = $PreviousSetting
Else
    $sleepTime = 1000 * 60 * 5;Five minutes = 1000 * 60 * 5
EndIf


;---------------Main loop----------------

While 1
    $currentpos = MouseGetPos()
   ;Check if current position is the same as the last position, if true move the mouse to the right.
    if $lastpos[0] = $currentpos[0] AND $lastpos[1] = $currentpos[1] then
        MouseMove($currentpos[0] + 50, $currentpos[1], 4)
        
       ;Check to see if the mouse has actually moved, move the mouse to the left if not.
        $newpos = MouseGetPos()
        if $lastpos[0] = $newpos[0] AND $lastpos[1] = $newpos[1] then
            MouseMove($currentpos[0] - 50, $currentpos[1], 4)
        endif
        
       ;Move back to original position so the mouse is in the same place they left it.
        MouseMove($currentpos[0], $currentpos[1], 4)
    EndIF
   ;MsgBox(48,"",$sleepTime)
    Sleep($sleepTime)
    $lastpos = $currentpos
WEnd

Exit

;---------------Functions----------------

;Dialog for setting loop timout.
Func SetTimeout()
    GUICreate("Set Timout", 210, 100)
    GUISetIcon(@AutoItExe)
    
    $Label = GUICtrlCreateLabel("Enter a timeout value" & @CRLF & "(in minutes)", 20, 15, 100, 30)

    $inputID = GUICtrlCreateInput ($sleepTime/60/1000, 150, 17, 50, 20)
    $timeoutID = GUICtrlCreateUpdown ($inputID, $UDS_ARROWKEYS)
    GUICtrlSetLimit ( $timeoutID, 9999, 1)
    
    $SaveID  = GUICtrlCreateButton("Save", 40, 70, 50, 20)
    GUICtrlSetOnEvent($SaveID,"OnSave")
    
    $CancelID = GUICtrlCreateButton("Cancel", 120, 70, 50, 20)
    GUICtrlSetOnEvent($CancelID,"OnClose")
    
    GUISetOnEvent($GUI_EVENT_CLOSE,"OnClose")
    
    GUISetState() ; display the GUI
EndFunc

;Display about dialog box
Func DisplayAbout()
    GUICreate("About", 250, 180)
    GUISetIcon(@AutoItExe)
    
    GUICtrlCreateIcon(@AutoItExe, -1, 5, 7)
    GUICtrlCreateLabel("Non-stop v1.2" & @CRLF & "by T 2020", 50, 10, 190, 30)
    GUICtrlCreateLabel("An application that moves the mouse when idle to disable the screen saver." & @CRLF & "Does not need Admin rights to install or run.", 50, 45, 190, 50)
    GUICtrlCreateLabel("" & @CRLF & "", 50, 105, 190, 30)
        
    $OkID = GUICtrlCreateButton("OK", 100, 150, 50, 20)
    GUICtrlSetOnEvent($OkID,"OnClose")
    
    GUISetOnEvent($GUI_EVENT_CLOSE,"OnClose")
    
    GUISetState() ; display the GUI
EndFunc

;Save settings 
Func OnSave()
    $Timeout = Number(ControlGetText("Set Timout", "", "Edit1"))
    If $Timeout > 0 Then
        $sleepTime = $Timeout * 60 * 1000
       ;MsgBox(48,"",$sleepTime)
        RegWrite("HKEY_CURRENT_USER\SOFTWARE\KillSaver\", "Timeout", "REG_DWORD", $sleepTime)
        GUIDelete()
    Else
        MsgBox(48,"Incorrect Data","Please enter non-zero numerical data only for the timeout value.")
    EndIF
EndFunc

;Function for exiting the app
Func ExitEvent()
    Exit
EndFunc

;Close last GUI window
Func OnClose()
    GUIDelete()
EndFunc
