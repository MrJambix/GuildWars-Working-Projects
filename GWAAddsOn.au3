#include-once
#RequireAdmin
#include "GWA2_Headers.au3"
#include <Array.au3>
;#include "GWA².au3"
#include "GWA2.au3"


;GENERAL THNX to miracle444 for his work with GWA2

;=================================================================================================
; Function:
; Description:		Globals from GWCA still working in GWA2
; Parameter(s):
;
; Requirement(s):
; Return Value(s):
; Author(s):		GWCA team
;=================================================================================================
Global Enum $RARITY_White = 0x3D, $RARITY_Blue = 0x3F, $RARITY_Purple = 0x42, $RARITY_Gold = 0x40, $RARITY_Green = 0x43

Global Enum $BAG_Backpack = 1, $BAG_BeltPouch, $BAG_Bag1, $BAG_Bag2, $BAG_EquipmentPack, $BAG_UnclaimedItems = 7, $BAG_Storage1, $BAG_Storage2, _
		$BAG_Storage3, $BAG_Storage4, $BAG_StorageAnniversary, $BAG_Storage5, $BAG_Storage6, $BAG_Storage7, $BAG_Storage8

Global Enum $HERO_Norgu = 1, $HERO_Goren, $HERO_Tahlkora, $HERO_MasterOfWhispers, $HERO_AcolyteJin, $HERO_Koss, $HERO_Dunkoro, $HERO_AcolyteSousuke, $HERO_Melonni, _
		$HERO_ZhedShadowhoof, $HERO_GeneralMorgahn, $HERO_MargridTheSly, $HERO_Olias = 14, $HERO_Razah, $HERO_MOX, $HERO_Jora = 18, $HERO_PyreFierceshot, _
		$HERO_Livia = 21, $HERO_Hayda, $HERO_Kahmu, $HERO_Gwen, $HERO_Xandra, $HERO_Vekk, $HERO_Ogden
Global Enum $HEROMODE_Fight, $HEROMODE_Guard, $HEROMODE_Avoid

Global Enum $DYE_Blue = 2, $DYE_Green, $DYE_Purple, $DYE_Red, $DYE_Yellow, $DYE_Brown, $DYE_Orange, $DYE_Silver, $DYE_Black, $DYE_Gray, $DYE_White

Global Enum $ATTRIB_FastCasting, $ATTRIB_IllusionMagic, $ATTRIB_DominationMagic, $ATTRIB_InspirationMagic, _
		$ATTRIB_BloodMagic, $ATTRIB_DeathMagic, $ATTRIB_SoulReaping, $ATTRIB_Curses, _
		$ATTRIB_AirMagic, $ATTRIB_EarthMagic, $ATTRIB_FireMagic, $ATTRIB_WaterMagic, $ATTRIB_EnergyStorage, _
		$ATTRIB_HealingPrayers, $ATTRIB_SmitingPrayers, $ATTRIB_ProtectionPrayers, $ATTRIB_DivineFavor, _
		$ATTRIB_Strength, $ATTRIB_AxeMastery, $ATTRIB_HammerMastery, $ATTRIB_Swordsmanship, $ATTRIB_Tactics, _
		$ATTRIB_BeastMastery, $ATTRIB_Expertise, $ATTRIB_WildernessSurvival, $ATTRIB_Marksmanship, _
		$ATTRIB_DaggerMastery, $ATTRIB_DeadlyArts, $ATTRIB_ShadowArts, _
		$ATTRIB_Communing, $ATTRIB_RestorationMagic, $ATTRIB_ChannelingMagic, _
		$ATTRIB_CriticalStrikes, _
		$ATTRIB_SpawningPower, _
		$ATTRIB_SpearMastery, $ATTRIB_Command, $ATTRIB_Motivation, $ATTRIB_Leadership, _
		$ATTRIB_ScytheMastery, $ATTRIB_WindPrayers, $ATTRIB_EarthPrayers, $ATTRIB_Mysticism

Global Enum $EQUIP_Weapon, $EQUIP_Offhand, $EQUIP_Chest, $EQUIP_Legs, $EQUIP_Head, $EQUIP_Feet, $EQUIP_Hands

Global Enum $SKILLTYPE_Stance = 3, $SKILLTYPE_Hex, $SKILLTYPE_Spell, $SKILLTYPE_Enchantment, $SKILLTYPE_Signet, $SKILLTYPE_Well = 9, _
		$SKILLTYPE_Skill, $SKILLTYPE_Ward, $SKILLTYPE_Glyph, $SKILLTYPE_Attack = 14, $SKILLTYPE_Shout, $SKILLTYPE_Preparation = 19, _
		$SKILLTYPE_Trap = 21, $SKILLTYPE_Ritual, $SKILLTYPE_ItemSpell = 24, $SKILLTYPE_WeaponSpell, $SKILLTYPE_Chant = 27, $SKILLTYPE_EchoRefrain

Global Enum $REGION_International = -2, $REGION_America = 0, $REGION_Korea, $REGION_Europe, $REGION_China, $REGION_Japan

Global Enum $LANGUAGE_English = 0, $LANGUAGE_French = 2, $LANGUAGE_German, $LANGUAGE_Italian, $LANGUAGE_Spanish, $LANGUAGE_Polish = 9, $LANGUAGE_Russian

Global Const $FLAG_RESET = 0x7F800000; unflagging heores


Global $intSkillEnergy[8] = [0, 5, 5, 10, 15, 5, 5, 5]
; Change the next lines to your skill casting times in milliseconds. use ~250 for shouts/stances, ~1000 for attack skills:
Global $intSkillCastTime[8] = [1000, 750, 750, 750, 1000, 250,  250, 1000]
; Change the next lines to your skill adrenaline count (1 to 8). leave as 0 for skills without adren
Global $intSkillAdrenaline[8] = [0, 0, 0, 0, 0, 0, 0, 0]

Global $totalskills = 7

Global $iItems_Picked = 0

Global $DeadOnTheRun = 0



Global $lItemExtraStruct = DllStructCreate( _ ; haha obsolete and wrong^^
		"byte rarity;" & _  ;Display Color $RARITY_White = 0x3D, $RARITY_Blue = 0x3F, $RARITY_Purple = 0x42, $RARITY_Gold = 0x40, $RARITY_Green = 0x43
		"byte unknown1[3];" & _
		"byte modifier;" & _ ;Display Mods (hex values): 30 = Display first mod only (Insignia, 31 = Insignia + "of" Rune, 32 = Insignia + [Rune], 33 = ...
		"byte unknown2[13];" & _ ;[13]
		"byte lastModifier")
Global $lItemExtraStructPtr = DllStructGetPtr($lItemExtraStruct)
Global $lItemExtraStructSize = DllStructGetSize($lItemExtraStruct)
#comments-start
Global $lItemNameStruct = DllStructCreate("byte rarity;"& _; Colour of the item (can be used as rarity); follow $lItemExtraStruct ->same pointer
		"byte ModMode;" & _;
		"byte ModCount;" & _;Number of Mods in the item
		"byte Name[4];" & _;Name ID of the item
		"byte Prefix[4];" & _; Depending on Item, Insignia, Axe Haft, Sword Hilt etc.
		"byte Suffix1[4];" & _; Depending on Item, Rune, Axe Grip, Sword Pommel etc.
		"byte Suffix2[4]"); (Runes Only) Quality of the Suffix (e.g. superior)

Global $lItemNameStructPtr = DllStructGetPtr($lItemNameStruct)
Global $lItemNameStructSize = DllStructGetSize($lItemNameStruct)
#comments-end

;-------> Item Extra Req Struct Definition
Global $lItemExtraReqStruct = DllStructCreate( _
		"byte requirement;" & _
		"byte attribute");Skill Template Format
Global $lItemExtraReqStructPtr = DllStructGetPtr($lItemExtraReqStruct)
Global $lItemExtraReqStructSize = DllStructGetSize($lItemExtraReqStruct)
;-------> Item Mod Struct definition
Global $lItemModStruct = DllStructCreate( _
		"byte unknown1[28];" & _
		"byte armor")
Global $lItemModStructPtr = DllStructGetPtr($lItemModStruct)
Global $lItemModStructSize = DllStructGetSize($lItemModStruct)






#Region H&H

Func MoveHero($aX, $aY, $HeroID, $Random = 75); Parameter1 = heroID (1-7) reset flags $aX = 0x7F800000, $aY = 0x7F800000

	Switch $HeroID
		Case "All"
			CommandAll(_FloatToInt($aX) + Random(-$Random, $Random), _FloatToInt($aY) + Random(-$Random, $Random))
		Case 1
			CommandHero1(_FloatToInt($aX) + Random(-$Random, $Random), _FloatToInt($aY) + Random(-$Random, $Random))
		Case 2
			CommandHero2(_FloatToInt($aX) + Random(-$Random, $Random), _FloatToInt($aY) + Random(-$Random, $Random))
		Case 3
			CommandHero3(_FloatToInt($aX) + Random(-$Random, $Random), _FloatToInt($aY) + Random(-$Random, $Random))
		Case 4
			CommandHero4(_FloatToInt($aX) + Random(-$Random, $Random), _FloatToInt($aY) + Random(-$Random, $Random))
		Case 5
			CommandHero5(_FloatToInt($aX) + Random(-$Random, $Random), _FloatToInt($aY) + Random(-$Random, $Random))
		Case 6
			CommandHero6(_FloatToInt($aX) + Random(-$Random, $Random), _FloatToInt($aY) + Random(-$Random, $Random))
		Case 7
			CommandHero7(_FloatToInt($aX) + Random(-$Random, $Random), _FloatToInt($aY) + Random(-$Random, $Random))
	EndSwitch
EndFunc   ;==>MoveHero

Func CommandHero1($aX = 0x7F800000, $aY = 0x7F800000)
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x520]
	Local $lHeroStruct = MemoryReadPtr($mBasePointer, $lOffset)
	SendPacket(0x14, $HEADER_HERO_PLACE_FLAG, MEMORYREAD($lHeroStruct[1] + 0x4), $aX, $aY, 0)
EndFunc   ;==>CommandHero1

Func CommandHero2($aX = 0x7F800000, $aY = 0x7F800000)
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x520]
	Local $lHeroStruct = MemoryReadPtr($mBasePointer, $lOffset)
	SendPacket(0x14, $HEADER_HERO_PLACE_FLAG, MEMORYREAD($lHeroStruct[1] + 0x28), $aX, $aY, 0)
EndFunc   ;==>CommandHero2

Func CommandHero3($aX = 0x7F800000, $aY = 0x7F800000)
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x520]
	Local $lHeroStruct = MemoryReadPtr($mBasePointer, $lOffset)
	SendPacket(0x14, $HEADER_HERO_PLACE_FLAG, MEMORYREAD($lHeroStruct[1] + 0x4C), $aX, $aY, 0)
EndFunc   ;==>CommandHero3

Func CommandHero4($aX = 0x7F800000, $aY = 0x7F800000)
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x520]
	Local $lHeroStruct = MemoryReadPtr($mBasePointer, $lOffset)
	SendPacket(0x14, $HEADER_HERO_PLACE_FLAG, MEMORYREAD($lHeroStruct[1] + 0x70), $aX, $aY, 0)
EndFunc   ;==>CommandHero4

Func CommandHero5($aX = 0x7F800000, $aY = 0x7F800000)
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x520]
	Local $lHeroStruct = MemoryReadPtr($mBasePointer, $lOffset)
	SendPacket(0x14, $HEADER_HERO_PLACE_FLAG, MEMORYREAD($lHeroStruct[1] + 0x94), $aX, $aY, 0)
EndFunc   ;==>CommandHero5

Func CommandHero6($aX = 0x7F800000, $aY = 0x7F800000)
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x520]
	Local $lHeroStruct = MemoryReadPtr($mBasePointer, $lOffset)
	SendPacket(0x14, $HEADER_HERO_PLACE_FLAG, MEMORYREAD($lHeroStruct[1] + 0xB8), $aX, $aY, 0)
EndFunc   ;==>CommandHero6

Func CommandHero7($aX = 0x7F800000, $aY = 0x7F800000)
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x520]
	Local $lHeroStruct = MemoryReadPtr($mBasePointer, $lOffset)
	SendPacket(0x14, $HEADER_HERO_PLACE_FLAG, MEMORYREAD($lHeroStruct[1] + 0xDC), $aX, $aY, 0)
EndFunc   ;==>CommandHero7


Func Fight($target, $totalskills, $x)
    Local $useSkill, $energy, $adrenaline, $recharge, $variabletosort = 0, $TargetAllegiance

    If $DeadOnTheRun = 0 Then
        For $i = 0 To $totalskills

            $recharge = DllStructGetData(GetSkillbar(), 'Recharge' & $i+1)
            $energy = GetEnergy(-2)
            $adrenaline = GetAdrenaline(-2)

            ; This is one of the checks you mentioned, which I've left unchanged:
            If DllStructGetData(GetCurrentTarget(), 'Effects') = 0x0010 Then Return

            If $recharge = 0 And $energy >= $intSkillEnergy[$i] And $adrenaline >= ($intSkillAdrenaline[$i]*25 - 25) Then
                $useSkill = $i + 1

                ; This is another one of the checks, which remains unchanged:
                If DllStructGetData(GetCurrentTarget(), 'Type') = 0x400 Then Return

                Switch $i
                    Case 0, 1, 2, 4, 5, 6, 8
                        Do
                            $energy = GetEnergy(-2)
                            If $energy >= $intSkillEnergy[$i] Then
                                UseSkill($useSkill, $target)
                                RndSlp(600)
                            EndIf
                            rndslp(200)
                            $variabletosort = $variabletosort + 1
                            if DllStructGetData(GetCurrentTarget(),'HP') = 0 then ExitLoop
                            if GetDistance($target, -2) > $x then ExitLoop
                            $TargetAllegiance = DllStructGetData(GetCurrentTarget(),'Allegiance')
                            if $TargetAllegiance = 0x1 OR $TargetAllegiance = 0x4 OR $TargetAllegiance = 0x5 OR $TargetAllegiance = 0x6 Then ExitLoop
                            If DllStructGetData(GetCurrentTarget(), 'Effects') = 0x0010 Then ExitLoop
                            If DllStructGetData(GetCurrentTarget(),'Type') = 0x400 then ExitLoop
                        Until (DllStructGetData(GetAgentByID(-1), 'LastStrike') = $i+1 OR $variabletosort = 3) Or DllStructGetData(GetSkillbar(), 'Recharge' & $i+1) > 0
                    Case Else
                        If $i > 5 And $i < 7 Then
                            UseSkill($useSkill, $target)
                            RndSlp($intSkillCastTime[$i+1]+500); -- +1 added
                        EndIf
                EndSwitch
            EndIf

            if $i = $totalskills then $i = -1 ; change -1
            If $DeadOnTheRun = 1 Then ExitLoop

        Next
    EndIf
EndFunc


Func FightBug($x, $s = "enemies")
	ChangeWeaponSet(2)
	If $DeadOnTheRun = 0 Then
		Local $TimerToGetOut = TimerInit()
		Do
			If $DeadOnTheRun = 0 Then $useSkill = -1
			If $DeadOnTheRun = 0 Then $target = GetNearestEnemyToAgent(-2)
			;$target = GetNearestEnemyToAgent(GetHeroID(7))
			$distance = GetDistance($target, -2)
			If DllStructGetData($target, 'ID') <> 0 AND $distance < $x AND $DeadOnTheRun = 0 Then
				If $DeadOnTheRun = 0 Then ChangeTarget($target)
				If $DeadOnTheRun = 0 Then RndSlp(150)
				If GetAgentName($target) = "Khabuus" AND $DeadOnTheRun = 0 Then
					If $DeadOnTheRun = 0 Then TargetNextEnemy()
					If $DeadOnTheRun = 0 Then RndSlp(150)
					If $DeadOnTheRun = 0 Then $target = GetCurrentTarget()
					If $DeadOnTheRun = 0 Then ChangeTarget($target)
					If $DeadOnTheRun = 0 Then RndSlp(150)
				EndIf

				If $DeadOnTheRun = 0 Then CallTarget($target)
				If $DeadOnTheRun = 0 Then RndSlp(150)
				If $DeadOnTheRun = 0 Then Attack($target)
				If $DeadOnTheRun = 0 Then RndSlp(150)
			ElseIf DllStructGetData($target, 'ID') = 0 OR $distance > $x OR $DeadOnTheRun = 1 Then
				exitloop
			EndIf
			If $DeadOnTheRun = 0 Then

				For $i = 0 To $totalskills

					$targetHP = DllStructGetData(GetCurrentTarget(),'HP')
					if $targetHP = 0 then ExitLoop

					$distance = GetDistance($target, -2)
					if $distance > $x then ExitLoop

					$TargetAllegiance = DllStructGetData(GetCurrentTarget(),'Allegiance')
					if $TargetAllegiance = 0x1 OR $TargetAllegiance = 0x4 OR $TargetAllegiance = 0x5 OR $TargetAllegiance = 0x6 Then ExitLoop

					$TargetIsDead = DllStructGetData(GetCurrentTarget(), 'Effects')
					If $TargetIsDead = 0x0010 Then ExitLoop

					$TargetItem = DllStructGetData(GetCurrentTarget(),'Type')
					if $TargetItem = 0x400 then ExitLoop

					$energy = GetEnergy(-2)
					$recharge = DllStructGetData(GetSkillBar(), "Recharge" & $i+1)
					$adrenaline = DllStructGetData(GetSkillBar(), "Adrenaline" & $i+1)
					;Update($s & " - Fight!")
					If $recharge = 0 And $energy >= $intSkillEnergy[$i] And $adrenaline >= ($intSkillAdrenaline[$i]*25 - 25) Then
						$useSkill = $i + 1
						;PingSleep(250)
						$variabletosort = 0
						;UseSkill($useSkill, $target)
						If $i = 0 Then
							Do
								$energy = GetEnergy(-2)
								If $energy >= $intSkillEnergy[$i] Then
									UseSkill($useSkill, $target)
									RndSlp(600)
								EndIf
								rndslp(200)
								$variabletosort = $variabletosort + 1
								if DllStructGetData(GetCurrentTarget(),'HP') = 0 then ExitLoop
								if GetDistance($target, -2) > $x then ExitLoop
								$TargetAllegiance = DllStructGetData(GetCurrentTarget(),'Allegiance')
								if $TargetAllegiance = 0x1 OR $TargetAllegiance = 0x4 OR $TargetAllegiance = 0x5 OR $TargetAllegiance = 0x6 Then ExitLoop
								If DllStructGetData(GetCurrentTarget(), 'Effects') = 0x0010 Then ExitLoop
								If DllStructGetData(GetCurrentTarget(),'Type') = 0x400 then ExitLoop
							Until (DllStructGetData(GetAgentByID(-1), 'LastStrike') = 0x1 OR $variabletosort = 3) Or DllStructGetData(GetSkillbar(), 'Recharge1') > 0;--
						ElseIf $i = 1 Then
							Do
								$energy = GetEnergy(-2)
								If $energy >= $intSkillEnergy[$i] Then
									UseSkill($useSkill, $target)
									RndSlp(600)
								EndIf
								rndslp(200)
								$variabletosort = $variabletosort + 1
								if DllStructGetData(GetCurrentTarget(),'HP') = 0 then ExitLoop
								if GetDistance($target, -2) > $x then ExitLoop
								$TargetAllegiance = DllStructGetData(GetCurrentTarget(),'Allegiance')
								if $TargetAllegiance = 0x1 OR $TargetAllegiance = 0x4 OR $TargetAllegiance = 0x5 OR $TargetAllegiance = 0x6 Then ExitLoop
								If DllStructGetData(GetCurrentTarget(), 'Effects') = 0x0010 Then ExitLoop
								If DllStructGetData(GetCurrentTarget(),'Type') = 0x400 then ExitLoop
							Until(DllStructGetData(GetAgentByID(-1), 'LastStrike') = 0x2 OR $variabletosort = 3) Or DllStructGetData(GetSkillbar(), 'Recharge2') > 0 ;--
						ElseIf $i = 2 Then
							Do
								$energy = GetEnergy(-2)
								If $energy >= $intSkillEnergy[$i] Then
									UseSkill($useSkill, $target)
									RndSlp(600)
								EndIf
								rndslp(200)
								$variabletosort = $variabletosort + 1
								if DllStructGetData(GetCurrentTarget(),'HP') = 0 then ExitLoop
								if GetDistance($target, -2) > $x then ExitLoop
								$TargetAllegiance = DllStructGetData(GetCurrentTarget(),'Allegiance')
								if $TargetAllegiance = 0x1 OR $TargetAllegiance = 0x4 OR $TargetAllegiance = 0x5 OR $TargetAllegiance = 0x6 Then ExitLoop
								If DllStructGetData(GetCurrentTarget(), 'Effects') = 0x0010 Then ExitLoop
								If DllStructGetData(GetCurrentTarget(),'Type') = 0x400 then ExitLoop
							Until (DllStructGetData(GetAgentByID(-1), 'LastStrike') = 0x3 OR $variabletosort = 3) Or DllStructGetData(GetSkillbar(), 'Recharge3') > 0 ;--
						Else
							If $i > 5 Then
								UseSkill($useSkill, $target)
								RndSlp($intSkillCastTime[$i+1]+500);-- +1 geadded
							EndIf
						EndIf
					EndIf
					if $i = $totalskills then $i = -1 ; change -1
					If $DeadOnTheRun = 1 Then ExitLoop
				Next
			EndIf
			$TargetAllegiance = DllStructGetData(GetCurrentTarget(),'Allegiance')
			$TargetIsDead = DllStructGetData(GetCurrentTarget(), 'Effects')
			$targetHP = DllStructGetData(GetCurrentTarget(),'HP')
			$TargetItem = DllStructGetData(GetCurrentTarget(),'Type')
		Until DllStructGetData($target, 'ID') = 0 OR $distance > $x OR $DeadOnTheRun = 1 OR $TargetAllegiance = 0x1 OR $TargetAllegiance = 0x4 OR $TargetAllegiance = 0x5 OR $TargetAllegiance = 0x6 OR $TargetIsDead = 0x0010 OR $targetHP = 0 OR $TargetItem = 0x400 OR TimerDiff($TimerToGetOut) > 30000
	EndIf
	If TimerDiff($TimerToGetOut) > 30000 Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc
#Region Item related commands

;=================================================================================================
; Function:			PickUpItems($iItems = -1, $fMaxDistance = 1012)
; Description:		PickUp defined number of items in defined area around default = 1012
; Parameter(s):		$iItems:	number of items to be picked
;					$fMaxDistance:	area within items should be picked up
; Requirement(s):	GW must be running and Memory must have been scanned for pointers (see Initialize())
; Return Value(s):	On Success - Returns $iItemsPicked (number of items picked)
; Author(s):		GWCA team, recoded by ddarek, thnx to The ArkanaProject
;=================================================================================================
Func PickupItems($iItems = -1, $fMaxDistance = 3036)
    Local $aItemID, $lNearestDistance, $lDistance, $iItems_Picked = 0
    $tDeadlock = TimerInit()

    Do
        $aItem = GetNearestItemToAgent(-2)
        $lDistance = @extended
        $aItemID = DllStructGetData($aItem, 'ID')
        $aModelID = DllStructGetData($aItem, 'ModelID') 

        If ($aModelID <> 25410 And $aModelID <> 25416) Or $aItemID = 0 Or $lDistance > $fMaxDistance Or TimerDiff($tDeadlock) > 30000 Then 
            ExitLoop
        Else
            PickUpItem($aItem)
            $iItems_Picked += 1
        EndIf

        $tDeadlock2 = TimerInit()
        Do
            Sleep(500)
            If TimerDiff($tDeadlock2) > 5000 Then ContinueLoop 2
        Until DllStructGetData(GetAgentById($aItemID), 'ID') == 0

    Until $iItems_Picked = $iItems
    Return $iItems_Picked
EndFunc   ;==>PickupItems


;=================================================================================================
; Function:			GetNearestItemToAgent($aAgent)
; Description:		Get nearest item lying on floor around $aAgent ($aAgent = -2 ourself), necessary to work with PickUpItems func
; Parameter(s):		$aAgent: ID of Agent
; Requirement(s):	GW must be running and Memory must have been scanned for pointers (see Initialize())
; Return Value(s):	On Success - Returns ID of nearest item
;					@extended  - distance to item
; Author(s):		GWCA team, recoded by ddarek
;=================================================================================================
Func GetNearestItemToAgent2($aAgent)
	Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance, $lAgentToCompare

	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	For $i = 1 To GetMaxAgents()
		$lAgentToCompare = GetAgentByID($i)

	If DllStructGetData($lAgentToCompare, 'Type') <> 0x400 Then ContinueLoop
		$lDistance = (DllStructGetData($lAgentToCompare, 'Y') - DllStructGetData($aAgent, 'Y')) ^ 2 + (DllStructGetData($lAgentToCompare, 'X') - DllStructGetData($aAgent, 'X')) ^ 2
		If $lDistance < $lNearestDistance Then
			$lNearestAgent = $lAgentToCompare
			$lNearestDistance = $lDistance
		EndIf
	Next
	SetExtended(Sqrt($lNearestDistance)) ;this could be used to retrieve the distance also
	Return $lNearestAgent
EndFunc   ;==>GetNearestItemToAgent


Func GetNearestItemByModelId($ModelId, $aAgent = -2 )
Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance, $lAgentToCompare

	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)

	For $i = 1 To GetMaxAgents()
		$lAgentToCompare = GetAgentByID($i)
		If DllStructGetData($lAgentToCompare, 'Type') <> 0x400 Then ContinueLoop
		If DllStructGetData(GetItemByAgentID($i), 'ModelID') <> $ModelId Then ContinueLoop
		$lDistance = (DllStructGetData($lAgentToCompare, 'Y') - DllStructGetData($aAgent, 'Y')) ^ 2 + (DllStructGetData($lAgentToCompare, 'X') - DllStructGetData($aAgent, 'X')) ^ 2
		If $lDistance < $lNearestDistance Then
			$lNearestAgent = $lAgentToCompare
			$lNearestDistance = $lDistance
		EndIf

	Next
	Return $lNearestAgent; return struct of Agent not item!
EndFunc   ;==>GetNearestItemByModelId

Func GetNumberOfAlliesInRangeOfAgent($aAgent = -2, $fMaxDistance = 3036)
	Local $lDistance, $lCount = 0

	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	For $i = 1 To GetMaxAgents()
		$lAgentToCompare = GetAgentByID($i)
		If GetIsDead($lAgentToCompare) <> 0 Then ContinueLoop
		If DllStructGetData($lAgentToCompare, 'Allegiance') = 0x1 Then
			$lDistance = GetDistance($lAgentToCompare, $aAgent)
			If $lDistance < $fMaxDistance Then
				$lCount += 1
				;ConsoleWrite("Counts: " &$lCount & @CRLF)
			EndIf
		EndIf
	Next
	Return $lCount
EndFunc   ;==>GetNumberOfAlliesInRangeOfAgent

Func GetNumberOfItemsInRangeOfAgent($aAgent = -2, $fMaxDistance = 3036)
	Local $lDistance, $lCount = 0

	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	For $i = 1 To GetMaxAgents()
		$lAgentToCompare = GetAgentByID($i)
		If DllStructGetData($lAgentToCompare, 'Type') = 0x400 Then
			$lDistance = GetDistance($lAgentToCompare, $aAgent)
			If $lDistance < $fMaxDistance Then
				$lCount += 1
				;ConsoleWrite("Counts: " &$lCount & @CRLF)
			EndIf
		EndIf
	Next
	Return $lCount
EndFunc   ;==>GetNumberOfItemsInRangeOfAgent

Func GetNearestEnemyToCoords($aX, $aY)
	Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance, $lAgentToCompare

	For $i = 1 To GetMaxAgents()
		$lAgentToCompare = GetAgentByID($i)
		If DllStructGetData($lAgentToCompare, 'HP') < 0.005 Or DllStructGetData($lAgentToCompare, 'Allegiance') <> 0x3 Then ContinueLoop

		$lDistance = ($aX - DllStructGetData($lAgentToCompare, 'X')) ^ 2 + ($aY - DllStructGetData($lAgentToCompare, 'Y')) ^ 2
		If $lDistance < $lNearestDistance Then
			$lNearestAgent = $lAgentToCompare
			$lNearestDistance = $lDistance
		EndIf
	Next

	Return $lNearestAgent
EndFunc   ;==>GetNearestAgentToCoords
;=================================================================================================
; Function:			Ident($bagIndex = 1, $numOfSlots)
; Description:		Idents items in $bagIndex, NEEDS ANY ID kit in inventory!
; Parameter(s):		$bagIndex -> check Global enums
;					$numOfSlots -> correspondend number of slots in $bagIndex
; Requirement(s):	GW must be running and Memory must have been scanned for pointers (see Initialize())
; Return Value(s):
; Author(s):		GWCA team, recoded by ddarek, thnx to The ArkanaProject
;=================================================================================================

Func Ident($bagIndex, $numOfSlots)
	If FindIDKit() = False Then
	;	UpdateStatus("Buying ID Kit..........")
		BuyIDKit();Buy IDKit
		Sleep(Random(240, 260))
	EndIf
	For $i = 1 To $numOfSlots
		;UpdateStatus("Identifying item: " & $bagIndex & ", " & $i)
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, 'ID') = 0 Then ContinueLoop
		IdentifyItem($aItem)
		Sleep(Random(500, 750))
	Next
EndFunc   ;==>Ident
;=================================================================================================
; Function:			CanSell($aItem); only part of it can do
; Description:		general precaution not to sell things we want to save; ModelId page = http://wiki.gamerevision.com/index.php/Model_IDs
; Parameter(s):		$aItem-object
;
; Requirement(s):	GW must be running and Memory must have been scanned for pointers (see Initialize())
; Return Value(s):	On Success - Returns boolean
; Author(s):		GWCA team, recoded by ddarek, thnx to The ArkanaProject
;=================================================================================================

Func CanSell($aItem)
	$m = DllStructGetData($aItem, 'ModelID')
	$q = DllStructGetData($aItem, 'Quantity')
	$r = DllStructGetData(GetEtraItemInfoByItemId($aItem), 'Rarity')
	If $m = 0 Or $q > 1 OR $r = $Rarity_Gold OR $r = $Rarity_Green Then
		Return False
	ElseIf $m > 21785 And $m < 21806 Then ;Tomes not for sale
		Return False
	ElseIf $m = 146 Or $m = 22751 Then ; 146 = dyes, 22751 = lockpick not for sale
		Return False
	ElseIf $m = 5899 Or $m = 5900 Then ;Sup ID/Salvage not for sale
		Return False
	ElseIf $m = 5594 Or $m = 5595 Or $m = 5611 Or $m = 5853 Or $m = 5975 Or $m = 5976 Or $m = 21233 Then ;scrolls not for sale
		Return False
	ElseIf $m = 923 OR $m = 931 OR $m = 6533 Then			;Jade/Eye/Claw
		Return False
	ElseIf ($m = 1175 OR $m = 1176 OR $m = 1152 OR $m = 1153 OR $m = 920 OR $m = 0) AND $r <> $Rarity_White Then
		Return False
	ElseIf $m = 27033 Then ; D-Cores not for sale
		Return False
	Else
		Return True
	EndIf
EndFunc   ;==>CanSell

;=================================================================================================
; Function:			Sell($bagIndex, $numOfSlots)
; Description:		Sell items in $bagIndex, need open Dialog with Trader!
; Parameter(s):		$bagIndex -> check Global enums
;					$numOfSlots -> correspondend number of slots in $bagIndex
; Requirement(s):	GW must be running and Memory must have been scanned for pointers (see Initialize())
; Return Value(s):
; Author(s):		GWCA team, recoded by ddarek, thnx to The ArkanaProject
;=================================================================================================


Func Sell($bagIndex, $numOfSlots)
	Sleep(Random(150, 250))
	For $i = 1 To $numOfSlots
		$aItem = GetItemBySlot($bagIndex, $i)
		If CanSell($aItem) Then SellItem($aItem)
		Sleep(Random(500, 550))
	Next
EndFunc   ;==>Sell

Func GetEtraItemInfoByItemId($aItem)
	$item = GetItemByItemID($aItem)
	$lItemExtraPtr = DllStructGetData($item, "ModPtr")

	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lItemExtraPtr, 'ptr', $lItemExtraStructPtr, 'int', $lItemExtraStructSize, 'int', '')
	Return $lItemExtraStruct
EndFunc   ;==>GetEtraInfoByItemId

Func GetEtraItemInfoByAgentId($aItem)
	$item = GetItemByAgentID($aItem)
	$lItemExtraPtr = DllStructGetData($item, "ModPtr")

	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lItemExtraPtr, 'ptr', $lItemExtraStructPtr, 'int', $lItemExtraStructSize, 'int', '')
	Return $lItemExtraStruct
EndFunc   ;==>GetEtraInfoByAgentId

Func GetEtraItemInfoByModelId($aItem)
	$item = GetItemByModelID($aItem)
	$lItemExtraPtr = DllStructGetData($item, "ModPtr")

	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lItemExtraPtr, 'ptr', $lItemExtraStructPtr, 'int', $lItemExtraStructSize, 'int', '')
	Return $lItemExtraStruct
EndFunc   ;==>GetEtraInfoByModelId

Func GetExtraItemReqBySlot($aBag, $aSlot)
	$item = GetItembySlot($aBag, $aSlot)
	$lItemExtraReqPtr = DllStructGetData($item, "extraItemReq")

	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lItemExtraReqPtr, 'ptr', $lItemExtraReqStructPtr, 'int', $lItemExtraReqStructSize, 'int', '')
	Return $lItemExtraReqStruct
	;ConsoleWrite($rarity & @CRLF)
EndFunc   ;==>GetExtraItemReqBySlot

Func GetExtraItemReqByItemId($aItem)
	$item = GetItemByItemID($aItem)
	$lItemExtraReqPtr = DllStructGetData($item, "extraItemReq")

	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lItemExtraReqPtr, 'ptr', $lItemExtraReqStructPtr, 'int', $lItemExtraReqStructSize, 'int', '')
	Return $lItemExtraReqStruct
EndFunc   ;==>GetEtraItemReqByItemId

Func GetExtraItemReqByAgentId($aItem)
	$item = GetItemByAgentID($aItem)
	$lItemExtraReqPtr = DllStructGetData($item, "extraItemReq")

	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lItemExtraReqPtr, 'ptr', $lItemExtraReqStructPtr, 'int', $lItemExtraReqStructSize, 'int', '')
	Return $lItemExtraReqStruct
EndFunc   ;==>GetEtraItemReqByAgentId

Func GetExtraItemReqByModelId($aItem)
	$item = GetItemByModelID($aItem)
	$lItemExtraReqPtr = DllStructGetData($item, "extraItemReq")

	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lItemExtraReqPtr, 'ptr', $lItemExtraReqStructPtr, 'int', $lItemExtraReqStructSize, 'int', '')
	Return $lItemExtraReqStruct
EndFunc   ;==>GetEtraItemReqByModelId

Func FindEmptySlot($bagIndex) ;Parameter = bag index to start searching from. Returns integer with item slot. This function also searches the storage. If any of the returns = 0, then no empty slots were found
	Local $lItemInfo, $aSlot

	For $aSlot = 0 To DllStructGetData(GetBag($bagIndex), 'Slots')-1
		Sleep(40)
		ConsoleWrite("Checking: " & $bagIndex & ", " & $aSlot & @CRLF)
		$lItemInfo = GetItemBySlot($bagIndex, $aSlot)
		If DllStructGetData($lItemInfo, 'ID') = 0 Then
			ConsoleWrite($bagIndex & ", " & $aSlot & "  <-Empty! " & @CRLF)
			SetExtended($aSlot +1)
			ExitLoop
		EndIf
	Next
	Return 0
EndFunc   ;==>FindEmptySlot
#Region Misc

Func GetHPPips($aAgent = -2); Thnx to The Arkana Project
   If IsDllStruct($aAgent) == 0 Then $aAgent = GetAgentByID($aAgent)
   Return Round(DllStructGetData($aAgent, 'hppips') * DllStructGetData($aAgent, 'maxhp') / 2, 0)
EndFunc

Func GetTeam($aTeam); Thnx to The Arkana Project. Only works in PvP!
	Local $lTeamNumber
	Local $lTeam[1][2]
	Local $lTeamSmall[1] = [0]
	Local $lAgent
	If IsString($aTeam) Then
		Switch $aTeam
			Case "Blue"
				$lTeamNumber = 1
			Case "Red"
				$lTeamNumber = 2
			Case "Yellow"
				$lTeamNumber = 3
			Case "Purple"
				$lTeamNumber = 4
			Case "Cyan"
				$lTeamNumber = 5
			Case Else
				$lTeamNumber = 0
		EndSwitch
	Else
		$lTeamNumber = $aTeam
	EndIf
	$lTeam[0][0] = 0
	$lTeam[0][1] = $lTeamNumber
	If $lTeamNumber == 0 Then Return $lTeamSmall
	For $i = 1 To GetMaxAgents()
		$lAgent = GetAgentByID($i)
		If DllStructGetData($lAgent, 'ID') == 0 Then ContinueLoop
		If GetIsLiving($lAgent) And DllStructGetData($lAgent, 'Team') == $lTeamNumber And (DllStructGetData($lAgent, 'LoginNumber') <> 0 Or StringRight(GetAgentName($lAgent), 9) == "Henchman]") Then
			$lTeam[0][0] += 1
			ReDim $lTeam[$lTeam[0][0]+1][2]
			$lTeam[$lTeam[0][0]][0] = DllStructGetData($lAgent, 'id')
			$lTeam[$lTeam[0][0]][1] = DllStructGetData($lAgent, 'PlayerNumber')
		EndIf
	Next
	_ArraySort($lTeam, 0, 1, 0, 1)
	Redim $lTeamSmall[$lTeam[0][0]+1]
	For $i = 0 To $lTeam[0][0]
		$lTeamSmall[$i] = $lTeam[$i][0]
	Next
	Return $lTeamSmall
EndFunc

Func FormatName($aAgent); Thnx to The Arkana Project. Only works in PvP!
	If IsDllStruct($aAgent) == 0 Then $aAgent = GetAgentByID($aAgent)
	Local $lString
	Switch DllStructGetData($aAgent, 'Primary')
		Case 1
			$lString &= "W"
		Case 2
			$lString &= "R"
		Case 3
			$lString &= "Mo"
		Case 4
			$lString &= "N"
		Case 5
			$lString &= "Me"
		Case 6
			$lString &= "E"
		Case 7
			$lString &= "A"
		Case 8
			$lString &= "Rt"
		Case 9
			$lString &= "P"
		Case 10
			$lString &= "D"
	EndSwitch
	Switch DllStructGetData($aAgent, 'Secondary')
		Case 1
			$lString &= "/W"
		Case 2
			$lString &= "/R"
		Case 3
			$lString &= "/Mo"
		Case 4
			$lString &= "/N"
		Case 5
			$lString &= "/Me"
		Case 6
			$lString &= "/E"
		Case 7
			$lString &= "/A"
		Case 8
			$lString &= "/Rt"
		Case 9
			$lString &= "/P"
		Case 10
			$lString &= "/D"
	EndSwitch
	$lString &= " - "
	If DllStructGetData($aAgent, 'LoginNumber') > 0 Then
		$lString &= GetPlayerName($aAgent)
	Else
		$lString &= StringReplace(GetAgentName($aAgent), "Corpse of ", "")
	EndIf
	Return $lString
EndFunc

; #FUNCTION: Death ==============================================================================================================
; Description ...: Checks the dead
; Syntax.........: Death()
; Parameters ....:
; Author(s):		Syc0n
; ===============================================================================================================================
Func Death()
	If DllStructGetData(GetAgentByID(-2), "Effects") = 0x0010 Then
		Return 1	; Whatever you want to put here in case of death
	Else
		Return 0
	EndIf
EndFunc   ;==>Death

; #FUNCTION: RndSlp =============================================================================================================
; Description ...: RandomSleep (5% Variation) with Deathcheck
; Syntax.........: RndSlp(§wert)
; Parameters ....: $val = Sleeptime
; Author(s):		Syc0n
; ===============================================================================================================================

Func RNDSLP($val)
	$wert = Random($val * 0.95, $val * 1.05, 1)
	If $wert > 45000 Then
		For $i = 0 To 6
			Sleep($wert / 6)
			DEATH()
		Next
	ElseIf $wert > 36000 Then
		For $i = 0 To 5
			Sleep($wert / 5)
			DEATH()
		Next
	ElseIf $wert > 27000 Then
		For $i = 0 To 4
			Sleep($wert / 4)
			DEATH()
		Next
	ElseIf $wert > 18000 Then
		For $i = 0 To 3
			Sleep($wert / 3)
			DEATH()
		Next
	ElseIf $wert >= 9000 Then
		For $i = 0 To 2
			Sleep($wert / 2)
			DEATH()
		Next
	Else
		Sleep($wert)
		DEATH()
	EndIf
EndFunc   ;==>RndSlp

; #FUNCTION: Slp ================================================================================================================
; Description ...: Sleep with Deathcheck
; Syntax.........: Slp(§wert)
; Parameters ....: $wert = Sleeptime
; ===============================================================================================================================

Func SLP($val)
	If $val > 45000 Then
		For $i = 0 To 6
			Sleep($val / 6)
			DEATH()
		Next
	ElseIf $val > 36000 Then
		For $i = 0 To 5
			Sleep($val / 5)
			DEATH()
		Next
	ElseIf $val > 27000 Then
		For $i = 0 To 4
			Sleep($val / 4)
			DEATH()
		Next
	ElseIf $val > 18000 Then
		For $i = 0 To 3
			Sleep($val / 3)
			DEATH()
		Next
	ElseIf $val >= 9000 Then
		For $i = 0 To 2
			Sleep($val / 2)
			DEATH()
		Next
	Else
		Sleep($val)
		DEATH()
	EndIf
EndFunc   ;==>Slp

Func _FloatToInt($fFloat)
	Local $tFloat, $tInt

	$tFloat = DllStructCreate("float")
	$tInt = DllStructCreate("int", DllStructGetPtr($tFloat))
	DllStructSetData($tFloat, 1, $fFloat)
	Return DllStructGetData($tInt, 1)

EndFunc   ;==>_FloatToInt

Func _IntToFloat($fInt)
	Local $tFloat, $tInt

	$tInt = DllStructCreate("int")
	$tFloat = DllStructCreate("float", DllStructGetPtr($tInt))
	DllStructSetData($tInt, 1, $fInt)
	Return DllStructGetData($tFloat, 1)

EndFunc   ;==>_IntToFloat


Func PingSleep($msExtra = 0)
	$ping = GetPing()
	Sleep($ping + $msExtra)
EndFunc   ;==>PingSleep

Func ComputeDistanceEx($x1, $y1, $x2, $y2)
	Return Sqrt(($y2 - $y1) ^ 2 + ($x2 - $x1) ^ 2)
	$dist = Sqrt(($y2 - $y1) ^ 2 + ($x2 - $x1) ^ 2)
	ConsoleWrite("Distance: " & $dist & @CRLF)

EndFunc   ;==>ComputeDistanceEx

Func GoNearestNPCToCoords($aX, $aY)
	Local $NPC
	MoveTo($aX, $aY)
	$NPC = GetNearestNPCToCoords($aX, $aY)
	Do
		RndSleep(250)
		GoNPC($NPC)
	Until GetDistance($NPC, -2) < 250
	RndSleep(500)
EndFunc

;Func CheckArea($aX, $aY, $n = 200)
;	$ret = False
;	$pX = DllStructGetData(GetAgentByID(-2), "X")
;	$pY = DllStructGetData(GetAgentByID(-2), "Y")
;
;	If ($pX < $aX + $n) And ($pX > $aX - $n) And ($pY < $aY + $n) And ($pY > $aY - $n) Then
;		$ret = True
;	EndIf
;	Return $ret
;EndFunc

#EndRegion Misc