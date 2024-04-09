#Persistent
#SingleInstance, Force
#Include, CaptureScreen.ahk

Gui, Add, Edit, x10 y10 w400 h20 vWebhookLink, Enter Webhook Link Here
Gui, Add, Edit, x10 y40 w400 h20 vPingID, Enter Discord ID for Ping
Gui, Add, Edit, x10 y70 w400 h20 vScreenshotPath, Enter Screenshot Path
Gui, Add, Edit, x10 y100 w400 h20 vRarityNumber, Enter Rarity Number (1 = uncommon, 2 = rare, 3 = epic, 4 = legendary, 5 = mythic)
Gui, Add, Button, x10 y200 w100 h30 gStartButton, Start
Gui, Add, Button, x120 y200 w100 h30 gStopButton, Stop
Gui, Add, Checkbox, x10 y130 w200 h20 vEnableAuto, Toggle Auto-Reconnect
Gui, Add, Checkbox, x10 y150 w200 h40 vEnableSettings, Toggle only if you want to autoroll again after reconnect

Gui, Show, w420 h250, Blushney's PLAYER RNG Macro

LoadConfiguration()

return

GuiClose:
    SaveConfiguration()
    ExitApp

StartButton:
    Gui, Submit, NoHide
    SetTimer, CheckPixels, 250
    return

StopButton:
    SetTimer, CheckPixels, Off
    return

CheckPixels:
    CoordMode, Pixel, Window
    
    GuiControlGet, rarityNumber, , RarityNumber
    
    Loop
    {
        PixelSearch, Px1, Py1, 0, 0, 1920, 1080, 0x00A6FF, 0, Fast RGB

        If (!ErrorLevel)
        {
            Sleep, 1000
            CoordMode, Pixel, Window
            PixelSearch, Px2, Py2, 0, 0, 1920, 1080, 0x0C9B2F, 0, Fast RGB
            If (!ErrorLevel)
            {
	     	If (rarityNumber <= 0)
		{
                SendMessageToDiscordWebhook("New Player Rolled, Rarity (Uncommon)")
                Break
		}
            }
            CoordMode, Pixel, Window
            PixelSearch, Px2, Py2, 0, 0, 1920, 1080, 0x0082E4, 0, Fast RGB
            If (!ErrorLevel)
            {
		If (rarityNumber <= 1)
		{
                SendMessageToDiscordWebhook("New Player Rolled, Rarity (Rare)")
                Break
		}
            }

            CoordMode, Pixel, Window
            PixelSearch, Px2, Py2, 0, 0, 1920, 1080, 0xEC9E01, 0, Fast RGB
            If (!ErrorLevel)
            {
	     	If (rarityNumber <= 3)
		{
                SendMessageToDiscordWebhook("New Player Rolled, Rarity (Legendary)")
                Break
		}
            }

            PixelSearch, Px2, Py2, 0, 0, 1920, 1080, 0x8A01E0, 0, Fast RGB
            If (!ErrorLevel)
            {
	     	If (rarityNumber <= 2)
		{
                SendMessageToDiscordWebhook("New Player Rolled, Rarity (Epic)")
                Break
		}
            }

            PixelSearch, Px2, Py2, 0, 0, 1920, 1080, 0xE900E6, 0, Fast RGB
            If (!ErrorLevel)
            {
	     	If (rarityNumber <= 4)
		{
                SendMessageToDiscordWebhook("New Player Rolled, Rarity (MYTHIC)")
                Break
		}
            }
	    }

	    GuiControlGet, EnableAuto, , EnableAuto
            GuiControlGet, EnableSettings, , EnableSettings

If (EnableAuto = "1") {
    CoordMode, Pixel, Window
    PixelSearch, Px2, Py2, 0, 0, 1920, 1080, 0xFFFFFF, 0, Fast RGB
    If (!ErrorLevel)
    {
       PixelSearch, Px2, Py2, 0, 0, 1920, 1080, 0xA0A2A2, 0, Fast RGB
       If (!ErrorLevel)
       {

	   Sleep, 5000

           PixelSearch, Px2, Py2, 0, 0, 1920, 1080, 0x393B3D, 0, Fast RGB
           If (!ErrorLevel)
           {

	       Sleep, 2500
               PixelSearch, Px1, Py1, 0, 0, 1920, 1080, 0x00A6FF, 0, Fast RGB

               If (ErrorLevel)
               {

               PixelSearch, Px1, Py1, 0, 0, 1920, 1080, 0xCDB58B, 0, Fast RGB

               If (ErrorLevel)
               {

           PixelSearch, Px2, Py2, 0, 0, 1920, 1080, 0xBCBDBD, 0, Fast RGB
           If (!ErrorLevel)
           {

                    ClickSpam(1047, 592, 100)
                    If (EnableSettings = "1") {
                        Sleep, 25000
                        Click 1045, 987
			Sleep, 50
			Click, 873, 993
			If (rarityNumber = 0)
			{
			Click, 865, 694
			}
			If (rarityNumber = 1)
			{
			Click, 865, 684
			Sleep, 50
			Click, 865, 729
			}
			If (rarityNumber = 2)
			{
			Click, 865, 684
			Sleep, 50
			Click, 865, 729
			Sleep, 50
			Click, 865, 790
			}
			If (rarityNumber = 3)
			{
			Click, 865, 684
			Sleep, 50
			Click, 865, 729
			Sleep, 50
			Click, 865, 790
			Sleep, 50
			Click, 865, 827
			}
			If (rarityNumber = 4)
			{
			Click, 865, 684
			Sleep, 50
			Click, 865, 729
			Sleep, 50
			Click, 865, 790
			Sleep, 50
			Click, 865, 827
			Sleep, 50
			Click, 865, 885
			}
                        Sleep, 50
                        Click 822, 615
                        Sleep, 50
                        Click 957, 920
                    }
                    Break
                	}
			}
}
		    }
		}
            }
        }
    }

return

ClickSpam(x, y, duration) {
    MouseGetPos, OriginalX, OriginalY
    
    EndTime := A_TickCount + duration
    While (A_TickCount < EndTime) {
        Click %x%, %y%
        Sleep, 50
    }
    
    ; Restore the original mouse coordinates
    MouseMove, OriginalX, OriginalY
}


CaptureScreenshot() {
    GuiControlGet, screenshotPath, , ScreenshotPath
    if !FileExist(screenshotPath)
    {
        MsgBox, % "Directory does not exist: " . screenshotPath
        return ""
    }
    
    screenshotFile := screenshotPath . "\" . A_Now . ".png"

    CaptureScreen("743, 341, 1200, 693", false, screenshotFile)
    return screenshotFile
}

SendMessageToDiscordWebhook(message) {
    GuiControlGet, webhookLink, , WebhookLink
    GuiControlGet, pingID, , PingID
    GuiControlGet, rarityNumber, , RarityNumber
    screenshotFile := CaptureScreenshot()
    if (screenshotFile = "")
    {
        MsgBox, % "Failed to capture screenshot."
        return
    }

    ; Check if the rolled rarity is equal to or higher than the configured rarity number
    if (InStr(message, "Uncommon") && rarityNumber >= 1) ||
       (InStr(message, "Rare") && rarityNumber >= 2) ||
       (InStr(message, "Legendary") && rarityNumber >= 3) ||
       (InStr(message, "Epic") && rarityNumber >= 4) ||
       (InStr(message, "MYTHIC") && rarityNumber >= 5)
    {
        objParam := {file: [screenshotFile], content: message}
        CreateFormData(PostData, hdr_ContentType, objParam)

        HTTP := ComObjCreate("WinHTTP.WinHTTPRequest.5.1")
        HTTP.Open("POST", webhookLink, true)
        HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko")
        HTTP.SetRequestHeader("Content-Type", hdr_ContentType)
        HTTP.SetRequestHeader("Pragma", "no-cache")
        HTTP.SetRequestHeader("Cache-Control", "no-cache, no-store")
        HTTP.SetRequestHeader("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT")
        HTTP.Send(PostData)
        HTTP.WaitForResponse()

        FileDelete, %screenshotFile%
    }
}

LoadConfiguration() {
    FileReadLine, webhookLink, %A_ScriptDir%\config.txt, 1
    FileReadLine, pingID, %A_ScriptDir%\config.txt, 2
    FileReadLine, screenshotPath, %A_ScriptDir%\config.txt, 3
    FileReadLine, rarityNumber, %A_ScriptDir%\config.txt, 4
    FileReadLine, EnableAuto, %A_ScriptDir%\config.txt, 5
    FileReadLine, EnableSettings, %A_ScriptDir%\config.txt, 6
    
    ; Check if any of the configuration lines are empty
    if (webhookLink = "" or pingID = "" or screenshotPath = "" or rarityNumber = "" or EnableAuto = "" or EnableSettings = "") {
        MsgBox, Configuration file is incomplete.
        return
    }
    
    GuiControl,, WebhookLink, %webhookLink%
    GuiControl,, PingID, %pingID%
    GuiControl,, ScreenshotPath, %screenshotPath%
    GuiControl,, RarityNumber, %rarityNumber%
    GuiControl,, EnableAuto, %EnableAuto%
    GuiControl,, EnableSettings, %EnableSettings%
}


SaveConfiguration() {
    GuiControlGet, webhookLink, , WebhookLink
    GuiControlGet, pingID, , PingID
    GuiControlGet, screenshotPath, , ScreenshotPath
    GuiControlGet, rarityNumber, , RarityNumber
    GuiControlGet, EnableAuto, , EnableAuto
    GuiControlGet, EnableSettings, , EnableSettings
    
    ; Only save configuration if all fields are filled
    if (webhookLink != "" && pingID != "" && screenshotPath != "" && rarityNumber != "") {
        FileDelete, %A_ScriptDir%\config.txt
        FileAppend, %webhookLink%, %A_ScriptDir%\config.txt
        FileAppend, % "`n" . pingID, %A_ScriptDir%\config.txt
        FileAppend, % "`n" . screenshotPath, %A_ScriptDir%\config.txt
        FileAppend, % "`n" . rarityNumber, %A_ScriptDir%\config.txt
        FileAppend, % "`n" . EnableAuto, %A_ScriptDir%\config.txt
        FileAppend, % "`n" . EnableSettings, %A_ScriptDir%\config.txt
    }
}



CreateFormData(ByRef retData, ByRef retHeader, objParam) {
    New CreateFormData(retData, retHeader, objParam)
}

Class CreateFormData {

    __New(ByRef retData, ByRef retHeader, objParam) {

        Local CRLF := "`r`n", i, k, v, str, pvData
        Local Boundary := this.RandomBoundary()
        Local BoundaryLine := "------------------------------" . Boundary

        this.Len := 0 ; GMEM_ZEROINIT|GMEM_FIXED = 0x40
        this.Ptr := DllCall( "GlobalAlloc", "UInt",0x40, "UInt",1, "Ptr"  )          ; allocate global memory

        ; Loop input paramters
        For k, v in objParam
        {
            If IsObject(v) {
                For i, FileName in v
                {
                    str := BoundaryLine . CRLF
                         . "Content-Disposition: form-data; name=""" . k . """; filename=""" . FileName . """" . CRLF
                         . "Content-Type: " . this.MimeType(FileName) . CRLF . CRLF
                    this.StrPutUTF8( str )
                    this.LoadFromFile( Filename )
                    this.StrPutUTF8( CRLF )
                }
            } Else {
                str := BoundaryLine . CRLF
                     . "Content-Disposition: form-data; name=""" . k """" . CRLF . CRLF
                     . v . CRLF
                this.StrPutUTF8( str )
            }
        }

        this.StrPutUTF8( BoundaryLine . "--" . CRLF )

        ; Create a bytearray and copy data in to it.
        retData := ComObjArray( 0x11, this.Len ) ; Create SAFEARRAY = VT_ARRAY|VT_UI1
        pvData  := NumGet( ComObjValue( retData ) + 8 + A_PtrSize )
        DllCall( "RtlMoveMemory", "Ptr",pvData, "Ptr",this.Ptr, "Ptr",this.Len )

        this.Ptr := DllCall( "GlobalFree", "Ptr",this.Ptr, "Ptr" )                   ; free global memory 

        retHeader := "multipart/form-data; boundary=----------------------------" . Boundary
    }

    StrPutUTF8( str ) {
        Local ReqSz := StrPut( str, "utf-8" ) - 1
        this.Len += ReqSz                                  ; GMEM_ZEROINIT|GMEM_MOVEABLE = 0x42
        this.Ptr := DllCall( "GlobalReAlloc", "Ptr",this.Ptr, "UInt",this.len + 1, "UInt", 0x42 )   
        StrPut( str, this.Ptr + this.len - ReqSz, ReqSz, "utf-8" )
    }

    LoadFromFile( Filename ) {
        Local objFile := FileOpen( FileName, "r" )
        this.Len += objFile.Length                     ; GMEM_ZEROINIT|GMEM_MOVEABLE = 0x42 
        this.Ptr := DllCall( "GlobalReAlloc", "Ptr",this.Ptr, "UInt",this.len, "UInt", 0x42 )
        objFile.RawRead( this.Ptr + this.Len - objFile.length, objFile.length )
        objFile.Close()       
    }

    RandomBoundary() {
        str := "0|1|2|3|4|5|6|7|8|9|a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z"
        Sort, str, D| Random
        str := StrReplace(str, "|")
        Return SubStr(str, 1, 12)
    }

    MimeType(FileName) {
        n := FileOpen(FileName, "r").ReadUInt()
        Return (n        = 0x474E5089) ? "image/png"
             : (n        = 0x38464947) ? "image/gif"
             : (n&0xFFFF = 0x4D42    ) ? "image/bmp"
             : (n&0xFFFF = 0xD8FF    ) ? "image/jpeg"
             : (n&0xFFFF = 0x4949    ) ? "image/tiff"
             : (n&0xFFFF = 0x4D4D    ) ? "image/tiff"
             : "application/octet-stream"
    }

}
