#SingleInstance, force
#NoEnv
#MaxThreadsPerHotkey, 2
SetBatchLines, -1
CoordMode, Pixel, Window
CoordMode, Mouse, Window
url:="bruh" ; use the url from Discord webhook bot
userid:="<@userid>" ; tag
; True, False
autorhythm = false
flow = True
Webhook = false
; do not change
ruined = False
lol = false
Running = false
rhythm = False
; - dialog -
combattag = false
combattag=
(
	{
		"username": "i love vivace's macro",
		"avatar_url": "https://cdn.discordapp.com/attachments/919400611030650910/956032138942226462/004453D2-4B9F-4867-B090-4F88858C287B.jpg",
		"content": "%userid% Combat tag detected!",
		"embeds": null
	}
)
foodranout = false
foodranout=
(
	{
		"username": "i love vivace's macro",
		"avatar_url": "https://cdn.discordapp.com/attachments/919400611030650910/956032138942226462/004453D2-4B9F-4867-B090-4F88858C287B.jpg",
		"content": "%userid% your food in ranout of inventory!",
		"embeds": null
	}
)
lowhunder = false
lowhunder=
(
	{
		"username": "i love vivace's macro",
		"avatar_url": "https://cdn.discordapp.com/attachments/919400611030650910/956032138942226462/004453D2-4B9F-4867-B090-4F88858C287B.jpg",
		"content": "%userid% your hunger was too low!",
		"embeds": null
	}
)
autoleave=
(
	{
		"username": "i love vivace's macro",
		"avatar_url": "https://cdn.discordapp.com/attachments/919400611030650910/956032138942226462/004453D2-4B9F-4867-B090-4F88858C287B.jpg",
		"content": "auto leave in 3 minutes",
		"embeds": null
	}
)
IfNotExist, %A_ScriptDir%\bin2
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
	WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2), 800, 599
}
removetooltip() {
    tooltip
}
$end::reload ; for stop macro
$f1:: ; change hotkey here https://www.autohotkey.com/docs/KeyList.htm key list
toggle := !toggle
if (toggle)
{ ;remember to make less loop possible for best performence and always put timer in loop if stuck in loop
	Loop, ; Start of the loop
	{
		; misc
		If Flow = True
		{
			PixelSearch, x, y, 409, 151, 411, 153, 0x242424,, Fast ;auto flow
            If ErrorLevel = 0
            {
                Send e
            }
		}
		; Food System
		
		PixelSearch, x, y, 70, 144, 75, 146, 0x3A3A3A, 40, Fast
		if ErrorLevel = 0
		{
			rhythm = false
			Send 1
			Sleep 100
			Sendinput, 234567890
			Sleep 300
			ImageSearch, x, y, 60, 515, 710, 585, *10 %A_ScriptDir%\bin2\equip.png ;if not found equiped slot / not found food in slot
			If ErrorLevel = 1
			{
				Send, {Shift}{VKC0}
				MouseMove, 90, 480
				Sleep 350
				search = 0
				Loop, 21 ;Search for Food Slot
				{
					ImageSearch, foodx, foody, 80, 180, 680, 460, *20 %A_ScriptDir%\bin2\Image%A_Index%.png  ; Search For food
					If ErrorLevel = 0
					{
						fullslot = false
						Loop, ;Empty Slot
						{
							ImageSearch, Emptyx, Emptyy, 130, 520, 755, 585, %A_ScriptDir%\bin2\Slot%A_Index%.png  
							If errorlevel = 0 
							{
								Break
							}
							if A_Index = 10
							{
								fullslot = true
								Break
							}
						}
						if fullslot = false
						{
							MouseMove, foodx+10, foody+10 ;Drag food
							MouseMove, foodx+10, foody+11
							Sleep 20
							Send {Click, Down}
							MouseMove, Emptyx+10, Emptyy+20
							MouseMove, Emptyx+10, Emptyy+21
							Sleep 20
							Send {Click, Up}
							Sleep 10
						}
						else
						{
							Break
						}
					}
					else
					{
						search++
						if search = 21 ;searched 21 time not found any food on inventory
						{
							foodranout = true
						}
					}
				}
				MouseMove, 90, 480
				Send, {VKC0}{Shift}
			}
			awww = 0
			time := A_TickCount
			Loop, ; Eating part
			{
				Click
				Sleep 100
				Pixelsearch, x, y, 80, 95, 81, 96, 0x37378A, 10, Fast
				if ErrorLevel = 0
				{
					combattag = true
					Break
				}
				PixelSearch, x, y, 119, 144, 110, 146, 0x3A3A3A, 40, Fast ; full hunger
				If ErrorLevel = 1
				{
					Break
				}
				ImageSearch, x, y, 60, 515, 710, 585, *20 %A_ScriptDir%\bin2\equip.png ;if not found equiped slot /and still not full hunger
				If ErrorLevel = 1
				{
					awww++
					Sendinput, 234567890
				}
				if awww = 3
				{
					Break
				}
			} Until A_TickCount - time > 60000
			Sleep 100
			Send 1
		}

		PixelSearch, x, y, 40, 144, 55, 146, 0x3A3A3A, 40, Fast ; too low hunger
		If ErrorLevel = 0
		{
			if webhook = true
			{
				lowhunder = true
			}
			else
			{
				send !{f4}
				ExitApp
			}
		}
		; Stamina control & Punch
		PixelSearch, x, y, 170, 132, 171, 134, 0x3A3A3A, 40, Fast ;enough stamina for sp gain
		If ErrorLevel = 1 ; If not
		{
			rhythm = false
			If Running = False
			{
				Sendinput, {w down}{w up}{w down}{s down}
				Sleep 2000
				Running = True
			}
			PixelSearch, x, y, 249, 132, 250, 134, 0x3A3A3A, 40, Fast ;Full Stamina
			If ErrorLevel = 1 ; If Found
			{
				Running = False
				Sendinput, {w up}{s up}
			}
		} 
		else 
		{ ; if True
			if Running = True
			{
				Sendinput, {w up}{s up}
				Running = False			
			}
			if autorhythm = True ; Auto Rythm
			{
				if rhythm = false
				{
					Sendinput, r
					rhythm = True
				}
			}
			; Start Punching
			Click, 50 ; m1 Combo
			Click, Right ; Right Click can be disable by put " ; " on the first of this line
			; Stamina Check
			PixelSearch, x, y, 50, 132, 51, 134, 0x3A3A3A, 40, Fast ;if staming was too low
			If ErrorLevel = 0
			{
				Aaa := A_TickCount ;start counting
                Loop,
                {
					if webhook = true
					{
						If combattag = false
						{
							Pixelsearch, x, y, 80, 95, 81, 96, 0x37378A, 10, Fast ; search for combat tag
							if ErrorLevel = 0
							{
								combattag = true
							}
						}
					}
					Sleep 200
                } Until A_TickCount - Aaa > 10000
			}
		}
		; Webhook
		Pixelsearch, x, y, 80, 95, 81, 96, 0x37378A, 10, Fast ; Combat Tag 
		if ErrorLevel = 0
		{
			combattag = true
			ruined = true
		}
		if webhook = true
		{
			If ruined = true
			{
				if foodranout = true
				{
					WebRequest.Send(foodranout) 
				}
				if combattag = true
				{
					WebRequest.Send(combattag) 
				}
				if lowhunder = true
				{
					WebRequest.Send(lowhunder)
				}
				WebRequest.Send(autoleave)
				Sleep 120000
				Send !{f4}
				Sleep 200
				ExitApp
			}
		}
	}
}
else
{
	ExitApp ; if not toggle
}
Return