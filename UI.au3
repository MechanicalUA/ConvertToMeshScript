#include <GUIConstants.au3>

Global $Assets = @ScriptDir & "\Assets\"
Global $c_uiBackground = 0x16499A, $c_uiTitle = 0xDFFFFE, $c_uiText = 0xD4D5DF
Global $c_Button = 0x0353AC, $c_ButtonBorder = 0xF1F6FB, $c_Line = 0x487AC6


$ui_width = 400
$ui_height = 200

$ui = GUICreate("Convert to Mesh", $ui_width, $ui_height, Default, Default, $WS_POPUP, $WS_EX_CONTROLPARENT)
GUISetBkColor($c_uiBackground, $ui)

$logo = GUICtrlCreateIcon($Assets & "Logo.ico", Default, 5, 5, 32, 32)
GUICtrlSetCursor(-1, -1)

$like = GUICtrlCreateIcon($Assets & "like.ico", Default, 60, 125, 60, 60)
GUICtrlSetCursor(-1, -0)

$startBtnb = GUICtrlCreateIcon($Assets & "Startbuttonb.ico", Default, 175, 110, 190, 80)
GUICtrlSetCursor(-1, -0)

$exitBtn = GUICtrlCreateIcon($Assets & "Exit.ico", Default, $ui_width-22, 8, 16, 16)
GUICtrlSetCursor(-1, 0)

$title = GUICtrlCreateLabel("Convert to Mesh (Script for Dx)", 50, 0, $ui_width-80, 32, $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetColor(-1, $c_uiTitle)
GUICtrlSetFont(-1, 16, Default, Default, "Segoe UI", 5)

$text1 = GUICtrlCreateLabel("Highly recommend you to watch the video", 20, 40, $ui_width-55, 32, $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetColor(-1, $c_uiTitle)
GUICtrlSetFont(-1, 14, Default, Default, "Segoe UI", 5)

$text2 = GUICtrlCreateLabel("for elegant adjustment of your task", 20, 70, $ui_width-55, 32, $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetColor(-1, $c_uiTitle)
GUICtrlSetFont(-1, 14, Default, Default, "Segoe UI", 5)

$line = GUICtrlCreateLabel("", 50, 33, $ui_width-50, 1, Default, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetBkColor(-1, $c_Line)

GUISetState(@SW_SHOW, $ui)

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $GUI_EVENT_CLOSE, $exitBtn
			Exit
		 Case $like
             ShellExecute("https://www.youtube.com/channel/UCCpDFaiIEBWSTtYIS3FbKXQ")
		  Case $startBtnb
		   Local $isleep = 150
           GUICtrlDelete ($startBtnb)
		   Sleep($isleep)
		   GUICtrlDelete ($like)
           Sleep($isleep)
		   GUICtrlDelete ($text2)
           Sleep($isleep)
		   GUICtrlDelete ($text1)
           Sleep($isleep)
		   GUICtrlDelete ($line)
           Sleep($isleep)
		   GUICtrlDelete ($logo)
           Sleep($isleep)
		   GUICtrlDelete ($exitBtn)
           Sleep($isleep)
           GUICtrlDelete ($title)
           Sleep($isleep)
		   GUIDelete($ui)
           Exit

	EndSwitch


WEnd





