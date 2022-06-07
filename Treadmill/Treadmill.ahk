#SingleInstance, force
#NoEnv
#MaxThreadsPerHotkey, 2
SetMouseDelay, -1
SetCapsLockState, Off
CoordMode, Pixel, Window
CoordMode, Mouse, Window

url:="bruh" ; use the url from Discord webhook bot
userid:="<@userid>" ; Copy user ID from discord
webhook = false

percentcheck = false
oldlevelselect = true ; 
autolog = 999 ;run for the number you selected and leave
timebeforeleave = 120000 ; auto leave after getting ctag/ ruin in milisec
settimer, chbn, 50
MsgBox, 4, Stamina or RunningSpeed?, Choose Stamina or RunningSpeed
IfMsgBox Yes
{
    tread = false
}
else
{
	tread = true
}

MsgBox, 4, Stamina Detection?,
IfMsgBox Yes
{
    detect = true
}
else
{
	detect = false
}

chbn()
{
	IfWinNotExist, Stamina or RunningSpeed?
	Return
	settimer, chbn, off
	WinActivate
	ControlSetText, Button1, &Stamina
	ControlSetText, Button2, &Running
}
if oldlevelselect = true
{
	InputBox, level, Treadmill Level, Please enter level., , 200, 150
	if ErrorLevel = 1
	{
		ExitApp
	}
	If not (level = "1" or level = "2" or level = "3" or level = "4" or level = "5")
	{
		tooltip, Look like level %level% not exist in this version of macro
		SetTimer, removetooltip, -3000
		return
	}
}


;; do not change under this
ruined = False
body = false
bodya=
(
	{
		"username": "i love vivace's macro",
		"content": "%userid% You have reach 65 fatigue!",
		"embeds": null
	}
)
combattag = false
combattaga=
(
	{
		"username": "i love vivace's macro",
		"content": "%userid% Combat tag detected!",
		"embeds": null
	}
)
foodranout = false
foodranouta=
(
	{
		"username": "i love vivace's macro",
		"content": "%userid% your food in ranout of inventory!",
		"embeds": null
	}
)
lowhunder = false
lowhundera=
(
	{
		"username": "i love vivace's macro",
		"content": "%userid% your hunger was too low!",
		"embeds": null
	}
)
Cash = false
Casha=
(
	{
		"username": "i love vivace's macro",
		"content": "%userid% your cash is ranout!",
		"embeds": null
	}
)
pushed = false
pusheda=
(
	{
		"username": "i love vivace's macro",
		"content": "%userid% you were pushed too far away from treadmill!",
		"embeds": null
	}
)
cantrun = false
cantruna=
(
	{
		"username": "i love vivace's macro",
		"content": "%userid% unable to continue the tread macro!",
		"embeds": null
	}
)
autoleave=
(
	{
		"username": "i love vivace's macro",
		"content": "auto leave in 10 seconds",
		"embeds": null
	}
)
wait=
(
	{
		"username": "i love vivace's macro",
		"content": "unable to leave due to combat tag",
		"embeds": null
	}
)
logged=
(
	{
		"username": "i love vivace's macro",
		"content": "Logged successfully",
		"embeds": null
	}
)
IfNotExist, %A_ScriptDir%\bin
{
	msgbox,, file missing,Look like you didn't extract file,3
	ExitApp 
}

if webhook = true
{
	if url = bruh
	{
		MsgBox, 0, Something Went Wrong, Your webhook was invalid, 3
		ExitApp
	}
	if userid = <@userid>
	{
		MsgBox, 0, Something Went Wrong, You have to put your userid after enable Webhook, 3
		ExitApp
	}
	WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	WebRequest.Open("POST", url, false)
	WebRequest.SetRequestHeader("Content-Type", "application/json")
}

if WinExist("Roblox") {
	WinActivate
    CenterWindow("ahk_exe RobloxPlayerBeta.exe")
} else {
	tooltip, Roblox not found
	settimer, removetooltip, -3000
	Sleep 3000
	ExitApp
}
CenterWindow(WinTitle) {	
	WinGetPos,,, Width, Height, %WinTitle%
	WinMove, %WinTitle%,,,, 800, 599
}
removetooltip() {
    tooltip
}
$end::ExitApp ; for stop macro

$f1:: ; change hotkey here https://www.autohotkey.com/docs/KeyList.htm key list
macro_on := !macro_on
if (macro_on)
{
	Loop, ; Loop Searching for full stamina
	{
		if percentcheck = true
		{
			ImageSearch, x, y, 330, 110, 350, 125, *30 %A_ScriptDir%\bin\65.png
			If ErrorLevel = 0
			{
				ruined = true
				if webhook = true
				{
					body = true
				}
			}
			ImageSearch, x, y, 330, 110, 350, 125, *30 %A_ScriptDir%\bin\66.png
			If ErrorLevel = 0
			{
				ruined = true
				if webhook = true
				{
					body = true
				}
			}
		}
		
		PixelSearch , x, y, 249, 129, 250, 130, 0x3A3A3A, 40, Fast
		If ErrorLevel = 1
		{				
			if tread = true ; rs
			{
				Click , 520, 310
				Click , 520, 311
				Sleep 1000
			}
			if tread = false ; stam
			{
				Click , 290, 310
				Click , 290, 311
				Sleep 1000
			}
			aa = 0
			if oldlevelselect = true
			{
				if level = 5
				{
					Click , 340, 370
					Click , 340, 371
					Sleep 200
				}
				if level = 4
				{
					Click , 340, 340
					Click , 340, 341
					Sleep 200
				}
				if level = 3
				{
					Click , 340, 310
					Click , 340, 311
					Sleep 200
				}
				if level = 2
				{
					Click , 340, 280
					Click , 340, 281
					Sleep 200
				}
				if level = 1
				{
					Click , 340, 250
					Click , 340, 251
					Sleep 200
				}
				Sleep 200
				Loop, 20
				{
					Click , 410, 355
					Click , 410, 351
				}
			}
			else
			{
				Loop, 6
				{
					aa++
					Sleep 100
					ImageSearch, x, y, 370, 210, 430, 390, *20 %A_ScriptDir%\bin\%aa%.png
					If ErrorLevel = 0
					{
						MouseMove, x+1, y, 0
						MouseMove, x, y, 0
						Click, 5
						Sleep 400
						Loop, 20
						{
							Click , 410, 355
							Click , 410, 351
						}
						Break
					}
					If aa = 6 ; not found any 
					{
						if webhook = true
						{
							pushed = true
							ruined = true
						}
						else
						{
							MsgBox, Not detect level stopped the macro
							ExitApp
						}
						Break
					}
				}
			}
			Sleep 3000
			ImageSearch, x, y, 370, 210, 430, 390, *20 %A_ScriptDir%\bin\%aa%.png
			If ErrorLevel = 0
			{
				; Cash Ranout
				if webhook = true
				{
					cash = true
					ruined = true
				} else {
					msgbox, Cash ranout 
					ExitApp
				}
			}
			StartTime := A_TickCount
			Loop,
			{
				aa := A_TickCount - StartTime
				ImageSearch, x, y, 200, 240, 600, 300, *50 %A_ScriptDir%\bin\w.png
				if Errorlevel = 0
				{				
					Send w
				}			
				ImageSearch, x, y, 200, 240, 600, 300, *50 %A_ScriptDir%\bin\a.png
				if Errorlevel = 0
				{				
					Send a
				}
				ImageSearch, x, y, 200, 240, 600, 300, *50 %A_ScriptDir%\bin\s.png
				if Errorlevel = 0
				{				
					Send s
				}			
				ImageSearch, x, y, 200, 240, 600, 300, *50 %A_ScriptDir%\bin\d.png
				if Errorlevel = 0
				{				
					Send d
				}
				if ( aa > 58000 )
				{
					PixelSearch , x, y, 70, 144, 71, 146, 0x3A3A3A, 40, Fast
					If ErrorLevel = 1
					{
						Click, 409, 296
						Click, 409, 295
					}
				}
				if detect = true
				{
					PixelSearch , x, y, 30, 130, 40, 133, 0x3A3A3A, 40, Fast
					If ErrorLevel = 0
					{				
						StartTime3 := A_TickCount
						Loop,
						{
							PixelSearch , x, y, 70, 144, 71, 146, 0x3A3A3A, 40, Fast
							If ErrorLevel = 1
							{
								Click, 409, 296
								Click, 409, 295
							}
						} Until A_TickCount - StartTime3 > 9000
						
					}
				}
				Pixelsearch, x, y, 80, 95, 81, 96, 0x37378A, 10, Fast ; Combat Tag 
				if ErrorLevel = 0
				{
					combattag = true
					ruined = true
				}
				if ruined = true
				{
					Break
				}
			} Until A_TickCount - StartTime > 65000
			PixelSearch , x, y, 70, 144, 75, 146, 0x3A3A3A, 40, Fast
			If ErrorLevel = 0
			{
				ImageSearch, x, y, 370 , 335 , 445 , 355, *10 %A_ScriptDir%\bin\leave2.png
				If ErrorLevel = 0
				{
					Click, 410, 345
					Sleep 2000
				}
				Sleep 500
				Sendinput, 1234567890
				Sleep 200
				time := A_TickCount
				aw = 0
				Loop, ; Eating part
				{
					Click, 400, 610, 10
					Sleep 100
					PixelSearch, x, y, 119, 144, 110, 146, 0x3A3A3A, 40, Fast ; full hunger
					If ErrorLevel = 1
					{
						Break
					}
					ImageSearch, x, y, 60, 515, 760, 600, *20 %A_ScriptDir%\bin\equip.png ;if not found equiped slot /and still not full hunger
					If ErrorLevel = 1
					{
						Sendinput, 1234567890
						aw++
					}
					if aw = 3
					{
						Break
					}
					Pixelsearch, x, y, 80, 95, 81, 96, 0x37378A, 10, Fast ; Combat Tag 
					if ErrorLevel = 0
					{
						ruined = true
						combattag = true
					}
					if ruined = true
					{
						Break
					}
					
				} Until A_TickCount - time > 60000
				Send {BackSpace}
			}
			ImageSearch, x, y, 370 , 335 , 445 , 355, *10 %A_ScriptDir%\bin\leave2.png
			If ErrorLevel = 1
			{
				StartTime2 := A_TickCount
				Loop ,
				{			
					Click , 409, 296
					Click , 409, 295
				} Until A_TickCount - StartTime2 > 4000
			}
			okk++
			if okk = autolog
			{
				ruined = true
				if webhook = true
				{
					cantrun = true
				}
			}
		}
		
		PixelSearch, x, y, 40, 144, 50, 146, 0x3A3A3A, 40, Fast ; too low hunger
		If ErrorLevel = 0
		{
			ruined = true
			if webhook = true
			{
				lowhunder = true
			}
		}

		Pixelsearch, x, y, 80, 95, 81, 96, 0x37378A, 10, Fast ; Combat Tag 
		if ErrorLevel = 0
		{
			combattag = true
			ruined = true
		}
		if ruined = true
		{
			if webhook = true
			{
				if body = true
				{
					WebRequest.Send(bodya)
				}
				if foodranout = true
				{
					WebRequest.Send(foodranouta)
				}
				if combattag = true
				{
					WebRequest.Send(combattaga) 
				}
				if lowhunder = true
				{
					WebRequest.Send(lowhundera)
				}
				if pushed = true
				{
					WebRequest.Send(pusheda)
				}
				if cantrun = true
				{
					WebRequest.Send(cantruna)
				}
				if cash = true
				{
					WebRequest.Send(casha)
				}
				WebRequest.Send(autoleave)
				Sleep 10000
				Pixelsearch, x, y, 80, 95, 81, 96, 0x37378A, 10, Fast ; Combat Tag 
				if ErrorLevel = 0
				{
					WebRequest.Send(wait)
				}
				Loop,
				{
					Pixelsearch, x, y, 80, 95, 81, 96, 0x37378A, 10, Fast ; Combat Tag 
					if ErrorLevel = 1
					{
						Break
					}
				}
				Send !{f4}
				WebRequest.Send(logged)
				Sleep 200
				ExitApp
			}
			else
			{
				Sleep 10000
				Loop,
				{
					Pixelsearch, x, y, 80, 95, 81, 96, 0x37378A, 10, Fast ; Combat Tag 
					if ErrorLevel = 1
					{
						Break
					}
				}
				Send !{f4}
				;shutdown 
				Sleep 200
				ExitApp
			}
		}
	}
}
else
{
	ExitApp
}
Return

