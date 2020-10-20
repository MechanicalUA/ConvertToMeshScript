#include <AutoItConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <Array.au3>

    Local $sMessage = "Please select CAD files for batch processing"
	Local $sMessageDx = "Please select .EXE file for Geomagic Design X"
    ;Display an open dialog to select a list of files
    Local $sFileOpenDialog = FileOpenDialog($sMessage, @DesktopDir & "\", "CAD (*.x_t;*.STEP;*.stp;*.igs)", BitOR($FD_FILEMUSTEXIST, $FD_MULTISELECT))
	  If @error Then
           ; Display the error message
		   Local  $iLogical = MsgBox(37, "", "No files were selected." & @CRLF & "Try again?" )
	           If $iLogical == 2 Then
				  Exit
			   EndIf
			   If $iLogical == 4 Then
		              $sFileOpenDialog = FileOpenDialog($sMessage, @DesktopDir & "\", "CAD (*.x_t;*.STEP;*.stp;*.igs)", BitOR($FD_FILEMUSTEXIST, $FD_MULTISELECT))
		                  If @error Then
					       MsgBox(64,"", "See you later.")
			                 Exit
			              EndIf
			   EndIf
	   EndIf
    ;Generating array from files selected in Open Dialog
    Local $aPathFileName = StringSplit($sFileOpenDialog, "|")
    ;Getting the number of selected files in Open Dialog
	Local $iCount = $aPathFileName[0] - 1
    ;If user selected only one file, we need to fix array
	   If @error Then
		  $aPathFileName = StringSplit($sFileOpenDialog, "\")
		  ;Searching name of file
		  Local $iFile = $aPathFileName[0]
		  ;Writing the name in string
		  Local $sOneFile = $aPathFileName[$iFile]
		  ;Writing the path  to file
		  Local $sPathOneFile = _ArrayToString($aPathFileName, "\" , 1, $iFile - 1)
		  ;Getting correct string for StringSplit function
		  Local $sMerge = ($sPathOneFile & "|" & $sOneFile)
			    ;Fixed array
		        $aPathFileName = StringSplit($sMerge, "|")
				$iCount = $aPathFileName[0] - 1
	   EndIf
	If $iCount <= 1 Then
	   MsgBox(64, "", "You selected only 1 file for batch processing =)" )
    EndIf
	Exit
    ; Start Geomagic Design X
Run( "C:\Program Files\3D Systems\Geomagic Design X 2016\GeomagicDesignX.exe" , "" , @SW_MAXIMIZE )
    If @error Then
        ; Choose correct bin folder
		MsgBox(64,"", "Please select .EXE file of Geomagic Design X")
		Local $sFileOpenDialogDx = FileOpenDialog($sMessageDx, @WindowsDir & "\", "EXE files (*.exe)", $FD_FILEMUSTEXIST, "GeomagicDesignX")
		   If @error Then
           ; Display the error message
              MsgBox(64, "", "Something went horribly wrong.")
		      Exit
		   EndIf
		Run( $sFileOpenDialogDx , "" , @SW_MAXIMIZE )
		EndIf
WinWaitActive("Geomagic Design X")
Sleep(500)
; Batch processing
; The script tested with Geomagic Dx 2016, you need adjustment for other versions
For $i=1 to $iCount
   WinWaitActive("Geomagic Design X")
   ;Go to Import button position in MENU
   MouseMove ( 25, 35 , 5)
   MouseClick($MOUSE_CLICK_LEFT)
   Send( "{DOWN}{DOWN}{DOWN}{DOWN}{RIGHT}" )
   Send ("{Enter}")
   WinWaitActive("Import")
   ;Open CAD File
   Send( $aPathFileName[1] & "\" & $aPathFileName[$i+1] )
   Send ("{Enter}")
   ;Waiting while Dx imported file. Method of Comparison between 1-2 colors: loading bar 0xFFFFFF and loaded bar 0x8F9396
   Sleep(500)
   Local $iColor1 = PixelGetColor(@DesktopWidth - 940, @DesktopHeight - 50)
   Local $iColor2 = PixelGetColor(@DesktopWidth - 350, @DesktopHeight - 50)
      While $iColor1 <> $iColor2
	     Sleep(1000)
	     $iColor1 = PixelGetColor(@DesktopWidth - 940, @DesktopHeight - 50)
	     $iColor2 = PixelGetColor(@DesktopWidth - 350, @DesktopHeight - 50)
      WEnd
    Sleep(1250)
   ;Go to Convert to Mesh button position in MENU
   MouseMove ( 25, 35 , 5)
   MouseClick($MOUSE_CLICK_LEFT)
   Send( "{DOWN}{DOWN}{DOWN}{DOWN}{DOWN}{RIGHT}{DOWN}{RIGHT}{UP}" )
   Send ("{Enter}")
   ;Converting of CAD File
   Send( "^a" )
   Sleep (100)
   Send ("{Enter}")
   Sleep(250)
   WinWaitActive("Geomagic Design X")
   Send( "^5" )
   Sleep (100)
   Send( "{ESC}" )
   ;Go to Export button position in MENU
   MouseMove ( 25, 35 , 5)
   MouseClick($MOUSE_CLICK_LEFT)
   Sleep(250)
   MouseClick($MOUSE_CLICK_LEFT)
   Send( "{DOWN}{RIGHT}{DOWN}{DOWN}{DOWN}{DOWN}{DOWN}" )
   Send ("{Enter}")
   ;Export STL File
   Send( "^a" )
   Sleep (100)
   Send ("{Enter}")
   ;Save STL File
   Send ("{DEL}")
   Sleep (100)
   Send ($aPathFileName[$i+1])
   Sleep (100)
   Send ("{BS}{BS}{BS}{BS}")
   Send ("{Enter}")
   Sleep (500)
   WinWaitActive("Geomagic Design X")
   Send( "^n" )
   Send ("{TAB}{ENTER}")
Next
WinClose("Geomagic Design X")
Sleep(300)
MsgBox(64, "", "Done!" & @CRLF & $iCount & " files were converted.")
Exit







