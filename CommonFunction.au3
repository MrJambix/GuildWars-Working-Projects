#include-once

Global $strName = ""
Global $NumberRun = 0
global $boolrun = False
Global $strName = ""
Global $coords[2]
Global $Title, $sGW
Global $Bool_Donate = False, $Bool_IdAndSell = False, $Bool_HM = False, $Bool_Store = False, $Bool_PickUp = False

Global $File = @ScriptDir & "\Trace\Tra�a du " & @MDAY & "-" & @MON & " a " & @HOUR & "h et " & @MIN & "minutes.txt"

Opt("GUIOnEventMode", 1)

#Region ### START Koda GUI section ### Form=c:\bot\reputation farming\title package\form1.kxf
global $Form1_1 = GUICreate("Globeul Title Package 2023 Update", 400, 350, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Start = GUICtrlCreateButton("Start", 264, 248, 51, 25)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
GUICtrlCreateGroup("Title", 152, 8, 161, 129)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Radio_Asura = GUICtrlCreateRadio("Asura", 168, 32, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Deldrimor = GUICtrlCreateRadio("Deldrimor", 232, 32, 65, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Vanguard = GUICtrlCreateRadio("Vanguard", 232, 56, 73, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Norn = GUICtrlCreateRadio("Norn", 168, 56, 49, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Kurzick = GUICtrlCreateRadio("Kurzick", 232, 80, 65, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Luxon = GUICtrlCreateRadio("Luxon", 232, 104, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_SS_and_LB = GUICtrlCreateRadio("LB/SS", 168, 80, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_SS = GUICtrlCreateRadio("SS", 168, 104, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateGroup("General Config", 152, 136, 161, 105)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Gui_Id_and_sell = GUICtrlCreateCheckbox("Id and Sell", 168, 184, 75, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Gui_Store_unid = GUICtrlCreateCheckbox("Store Unid", 168, 160, 73, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Gui_HM_enable = GUICtrlCreateCheckbox("HM", 168, 208, 49, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Gui_Donate = GUICtrlCreateCheckbox("Donate", 248, 208, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Gui_PickUp = GUICtrlCreateCheckbox("PickUp", 248, 184, 60, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $txtName = GUICtrlCreateInput($strName, 152, 248, 105, 21)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateGroup("Points Status", 8, 8, 157, 181)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Asura", 24, 32, 31, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Deldrimor", 24, 48, 48, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Vanguard", 24, 64, 50, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Norn", 24, 80, 27, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Kurzick", 24, 96, 39, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Luxon", 24, 112, 33, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("LB", 24, 128, 17, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("SS", 24, 144, 18, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_Asura = GUICtrlCreateLabel("0", 96, 32, 40, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x808000)
global $Pt_Deldrimor  = GUICtrlCreateLabel("0", 96, 48, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_Vanguard  = GUICtrlCreateLabel("0", 96, 64, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_Norn  = GUICtrlCreateLabel("0", 96, 80, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_Kurzick  = GUICtrlCreateLabel("0", 96, 96, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_Luxon  = GUICtrlCreateLabel("0", 96, 112, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_LB  = GUICtrlCreateLabel("0", 96, 128, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_SS  = GUICtrlCreateLabel("0", 96, 144, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Current action :", 40, 192, 79, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $STATUS = GUICtrlCreateLabel("Script Not Started Yet", 16, 208, 124, 17, $SS_CENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $label_stat = GUICtrlCreateLabel("min: 000  sec: 00", 24, 176, 105, 17, $SS_CENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateGroup("Runs", 8, 224, 137, 49)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Total Runs", 16, 248, 56, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x008000)
global $gui_status_runs = GUICtrlCreateLabel("0", 96, 248, 10, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x008000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUISetOnEvent($GUI_EVENT_CLOSE, "gui_eventHandler")
GUICtrlSetState($Gui_Id_and_sell, $GUI_CHECKED)
GUICtrlSetState($Gui_Store_unid, $GUI_CHECKED)
GUICtrlSetState($Gui_HM_enable, $GUI_CHECKED)
GUICtrlSetState($Gui_PickUp, $GUI_CHECKED)
GUICtrlSetState($Radio_Asura, $GUI_CHECKED)
GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
GUISetState(@SW_SHOW)
GUICtrlCreateLabel("", 8, 330, 305, 40)
#EndRegion ### END Koda GUI section ### do i need the region



func gui_eventHandler()
	switch (@GUI_CtrlId)
		Case $Radio_Deldrimor
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_Asura
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_Vanguard
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_Norn
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_Kurzick
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_CHECKED)
		Case $Radio_Luxon
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_CHECKED)
		Case $Radio_SS
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_SS_and_LB
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		case $GUI_EVENT_CLOSE
			exit
		case $Start
			$NumberRun = 0
			$RunSuccess = 0
			$boolrun = True

			GUICtrlSetState($Radio_Asura, $GUI_DISABLE)
			GUICtrlSetState($Radio_Deldrimor, $GUI_DISABLE)
			GUICtrlSetState($Radio_Vanguard, $GUI_DISABLE)
			GUICtrlSetState($Radio_Norn, $GUI_DISABLE)
			GUICtrlSetState($Radio_Kurzick, $GUI_DISABLE)
			GUICtrlSetState($Radio_Luxon, $GUI_DISABLE)
			GUICtrlSetState($Radio_SS_and_LB, $GUI_DISABLE)
			GUICtrlSetState($Radio_SS, $GUI_DISABLE)
			GUICtrlSetState($Gui_Id_and_sell, $GUI_DISABLE)
			GUICtrlSetState($Gui_Store_unid, $GUI_DISABLE)
			GUICtrlSetState($Gui_HM_enable, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Start, $GUI_DISABLE)
			GUICtrlSetState($txtName, $GUI_DISABLE)

			If BitAND(GUICtrlRead($Radio_Asura), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Asura"
			ElseIf BitAND(GUICtrlRead($Radio_Deldrimor), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Deldrimor"
			ElseIf BitAND(GUICtrlRead($Radio_Vanguard), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Vanguard"
			ElseIf BitAND(GUICtrlRead($Radio_Norn), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Norn"
			ElseIf BitAND(GUICtrlRead($Radio_Kurzick), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Kurzick"
			ElseIf BitAND(GUICtrlRead($Radio_Luxon), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Luxon"
			ElseIf BitAND(GUICtrlRead($Radio_SS_and_LB), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "SS and LB"
			ElseIf BitAND(GUICtrlRead($Radio_SS), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "SS"
			EndIf

			$Size = WinGetPos($Form1_1)
			WinMove ( $Form1_1, "", $Size[0], $Size[1], 155, 310, 1)

			If BitAND(GUICtrlRead($Gui_Id_and_sell), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_IdAndSell = True
			If BitAND(GUICtrlRead($Gui_Store_unid), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_Store = True
			If BitAND(GUICtrlRead($Gui_HM_enable), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_HM = True
			If BitAND(GUICtrlRead($Gui_Donate), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_Donate = True
			If BitAND(GUICtrlRead($Gui_PickUp), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_PickUp = True

			If GUICtrlRead($txtName) = "" Then
				MsgBox(0, "Error", "Plz enter your name in the input box")
				Exit
			Else
				If Initialize(GUICtrlRead($txtName), "Guild Wars - " & GUICtrlRead($txtName)) = False Then
					MsgBox(0, "Error", "Can't find a Guild Wars client with that character name.")
					Exit
				EndIf
			EndIf
			$sGW = "Guild Wars - " & GUICtrlRead($txtName)
			AdlibRegister("ReduceMemory", 20000)
	endswitch
endfunc

Func ReduceMemory()
	$hWnd = WinGetHandle($sGW)
	If WinExists($hWnd) Then
		$pid = WinGetProcess($hWnd)
		$Pr_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $pid)
		DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $Pr_Handle[0])
		DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $Pr_Handle[0])
	EndIf
EndFunc


Func CurrentAction($MSG)
	GUICtrlSetData($STATUS, $MSG)
	GUICtrlSetData($gui_status_runs, $NumberRun)
	FileWriteLine($File, "Run : " & $NumberRun + 1 & " � : " & @Hour & ":" & @MIN & "." & @Sec & "   " & $MSG & @CRLF)
EndFunc   ;==>CurrentAction

Func SellItemToMerchant()
	If $Bool_Store Then
		CurrentAction("Storing Gold Unid")
		StoreGolds()
		RNDSLP(1000)
	EndIf
	If $Bool_IdAndSell Then
		CurrentAction("Going to merchant")
		If $Title = "Asura" Then
			$merchant = GetNearestNPCToCoords(18653, 13934)
		ElseIf $Title = "Deldrimor" Then
			$merchant = GetNearestNPCToCoords(-21032,10979)
		ElseIf $Title = "Vanguard" Then
			$merchant = GetNearestNPCToCoords(-19166, 17980)
		ElseIf $Title = "Norn" Then
			$merchant = GetNearestNPCToCoords(1598, -951)
		ElseIf $Title = "Kurzick" Then
			MoveTo(8481, 2005)
			$merchant = GetNearestNPCToCoords(8481, 2005)
		ElseIf $Title = "Luxon" Then
			$merchant = GetNearestNPCToCoords(-4318, 11298)
		ElseIf $Title = "SS and LB" Then
			$merchant = GetNearestNPCToCoords(-1795, -2482)
		ElseIf $Title = "SS" Then
			$merchant = GetNearestNPCToCoords(498, 1297)
		EndIf
		RNDSLP(1000)
		GoToNPC($merchant)
		RNDSLP(1000)
		If $Title = "Vanguard" Then
			rndslp(2000)
			Dialog(0x0000007F)
		EndIf
		BuyIDKit()
		RNDSLP(1000)
		CurrentAction("Ident inventory")
		Ident(1)
		Ident(2)
		Ident(3)
		Ident(4)
		CurrentAction("Sell inventory")
		Sell(1)
		Sell(2)
		Sell(3)
		Sell(4)
	EndIf
EndFunc  ;==>SellItemToMerchant

Func GetExtraItemInfo($aitem)
    If IsDllStruct($aitem) = 0 Then $aAgent = GetItemByItemID($aitem)
    $lItemExtraPtr = DllStructGetData($aitem, "namestring")

    DllCall($mHandle[0], 'int', 'ReadProcessMemory', 'int', $mHandle[1], 'int', $lItemExtraPtr, 'ptr', $lItemExtraStructPtr, 'int', $lItemExtraStructSize, 'int', '')
    Return $lItemExtraStruct
EndFunc   ;==>GetExtraItemInfo


Func GoMerchant($id_merchant, $xmerchant, $ymerchant)
	Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance, $lAgentToCompare

	For $i = 1 To GetMaxAgents()
		$lAgentToCompare = GetAgentByID($i)
		If DllStructGetData($lAgentToCompare, 'PlayerNumber') <> $id_merchant then ContinueLoop
		rndslp(150)
		ChangeTarget($lAgentToCompare)
		rndslp(150)
		GoNPC($lAgentToCompare)
		ExitLoop
	Next
	Do
		rndslp(100)
	Until CheckArea($xmerchant, $ymerchant)
	rndslp(2000)
EndFunc

Func StoreGolds()
	GoldIs(1, 20)
	GoldIs(2, 5)
	GoldIs(3, 10)
	GoldIs(4, 10)
EndFunc

Func GoldIs($bagIndex, $numOfSlots)
	For $i = 1 To $numOfSlots
		$aItem = GetItemBySlot($bagIndex, $i)
		ConsoleWrite("Checking items: " & $bagIndex & ", " & $i & @CRLF & DllStructGetData(GetExtraItemInfo($aItem), 'rarity') & @crlf)
		If DllStructGetData($aItem, 'ID') <> 0 And DllStructGetData(GetExtraItemInfo($aItem), 'rarity') = $RARITY_Gold Then
				Do
					For $bag = 8 To 12; Storage panels are form 8 till 16 (I have only standard amount plus aniversary one)
						$slot = FindEmptySlot($bag)
						$slot = @extended
						If $slot <> 0 Then
							$FULL = False
							$nSlot = $slot
							ExitLoop 2; finding first empty $slot in $bag and jump out
						Else
							$FULL = True; no empty slots :(
						EndIf
						Sleep(400)
					Next
				Until $FULL = True
				If $FULL = False Then
					MoveItem($aItem, $bag, $nSlot)
					ConsoleWrite("Gold item moved ...."& @CRLF)
					Sleep(Random(450, 550))
				EndIf
		EndIf
	Next
EndFunc   ;==>GoldIs

Func CheckIfInventoryIsFull()
	If CountSlots() = 0 Then
		return true
	Else
		return false
	EndIf
EndFunc   ;==>CheckIfInventoryIsFull

Func WaitForLoad()
	CurrentAction("Loading zone")
	InitMapLoad()
	$deadlock = 0
	Do
		Sleep(100)
		$deadlock += 100
		$load = GetMapLoading()
		$lMe = GetAgentByID(-2)

	Until $load = 2 And DllStructGetData($lMe, 'X') = 0 And DllStructGetData($lMe, 'Y') = 0 Or $deadlock > 10000

	$deadlock = 0
	Do
		Sleep(100)
		$deadlock += 100

		$deadlock += 100
		$load = GetMapLoading()
		$lMe = GetAgentByID(-2)

	Until $load <> 2 And DllStructGetData($lMe, 'X') <> 0 And DllStructGetData($lMe, 'Y') <> 0 Or $deadlock > 30000
	CurrentAction("Load complete")
	rndslp(3000)
EndFunc   ;==>WaitForLoad

Func CountSlots()
	Local $bag
	Local $temp = 0
	$bag = GetBag(1)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(2)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(3)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	Return $temp
EndFunc   ;==>CountSlots


Func AggroMoveToEx($x, $y, $s = "", $z = 1300)

	local $TimerToKill = TimerInit()
	If $DeadOnTheRun = 0 Then CurrentAction("Hunting " & $s)
	$random = 50
	$iBlocked = 0

	If $DeadOnTheRun = 0 Then Move($x, $y, $random)
	$Me = GetAgentByID()
	$coords[0] = DllStructGetData($Me, 'X')
	$coords[1] = DllStructGetData($Me, 'Y')
	If $DeadOnTheRun = 0 Then
		Do
			If $DeadOnTheRun = 0 Then RndSleep(250)
			$oldCoords = $coords

			$enemy = GetNearestEnemyToAgent(-2)
			$distance = ComputeDistance(DllStructGetData($enemy, 'X'),DllStructGetData($enemy, 'Y'),DllStructGetData(GetAgentByID(-2), 'X'),DllStructGetData(GetAgentByID(-2), 'Y'))
			If $distance < $z AND $enemy <> 0 and $DeadOnTheRun = 0 Then
				If $DeadOnTheRun = 0 Then Fight($z, $s) 
				If $DeadOnTheRun = 0 Then CurrentAction("Hunting " & $s)
			EndIf
			If $DeadOnTheRun = 0 Then RndSleep(250)
			$Me = GetAgentByID()
			$coords[0] = DllStructGetData($Me, 'X')
			$coords[1] = DllStructGetData($Me, 'Y')
			If $oldCoords[0] = $coords[0] AND $oldCoords[1] = $coords[1] and $DeadOnTheRun = 0 Then
				$iBlocked += 1
				If $DeadOnTheRun = 0 Then MoveTo($coords[0], $coords[1], 300)
				If $DeadOnTheRun = 0 Then RndSleep(350)
				If $DeadOnTheRun = 0 Then Move($x, $y)
			EndIf

		Until ComputeDistance($coords[0], $coords[1], $x, $y) < 250 OR $iBlocked > 20 or $DeadOnTheRun = 1
	EndIf
	$TimerToKillDiff = TimerDiff($TimerToKill)
	$Text = StringFormat("min: %03u  sec: %02u ", $TimerToKillDiff/1000/60, Mod($TimerToKillDiff/1000,60))
	FileWriteLine($File, $s & " en ================================== >   " & $Text & @CRLF)
EndFunc
