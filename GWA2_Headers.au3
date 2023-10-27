#include-once

;############################
;#  by rheek				#
;#  modified by Zilvereyes	#
;############################
; v1.6, source: github.com/rheek123/GwBotApiPatcher
;
; This file contains all headers that gwa2 uses to communicate with the gameservers directly.
;
; The headers are named variables. The names should indicate what the header is about.
; The comments give a litte more detail about what the header does.
;
; This makes the source code of gwa2 a little better readable. Also it allows to update headers more easily, as they
; are all now in a small separate place as a list to work yourself through.
; If you need to update the headers, the comments give hints about what action to trigger while recording CtoGS packets..

;Last Update 16/06-2023

#Region ;=QUEST=
;GAME_SMSG_QUEST_ADD
Global Const $HEADER_QUEST_ACCEPT = 0x39			;Accepts a quest from the NPC
Global Const $HEADER_QUEST_REWARD = 0x4F			;Retrieves Quest reward from NPC
;GAME_CMSG_QUEST_ABANDON 0x0F or GAME_SMSG_QUEST_REMOVE 0x51
Global Const $HEADER_QUEST_ABANDON = 0x0F			;Abandons the quest
#EndRegion ;=QUEST=

#Region ;=HERO=
;GAME_CMSG_HERO_BEHAVIOR
Global Const $HEADER_HERO_AGGRESSION = 0x13			;Sets the heroes aggression level
;GAME_CMSG_HERO_LOCK_TARGET
Global Const $HEADER_HERO_LOCK = 0x14				;Locks the heroes target
;GAME_CMSG_HERO_SKILL_TOGGLE
Global Const $HEADER_HERO_TOGGLE_SKILL = 0x17		;Enables or disables the heroes skill
;GAME_CMSG_HERO_FLAG_SINGLE
Global Const $HEADER_HERO_PLACE_FLAG = 0x18			;Sets the heroes position flag, hero runs to position
Global Const $HEADER_HERO_CLEAR_FLAG = 0x18			;Clears the heroes position flag
;GAME_CMSG_HERO_ADD 0x1C or GAME_SMSG_PARTY_HERO_ADD 0x1C1
Global Const $HEADER_HERO_ADD = 0x1C				;Adds hero to party
;GAME_CMSG_HERO_KICK 0x1D or GAME_SMSG_PARTY_HERO_REMOVE 0x1C2
Global Const $HEADER_HERO_KICK = 0x1D				;Kicks hero from party
Global Const $HEADER_HEROES_KICK = 0x1D				;Kicks ALL heroes from party
Global Const $HEADER_USE_HERO_SKILL = 0x1A			;For use with UseHeroSkillByPacket() only
#EndRegion ;=HERO=

#Region ;=PARTY=
;GAME_CMSG_HERO_FLAG_ALL
Global Const $HEADER_PARTY_PLACE_FLAG = 0x19		;Sets the party position flag, all party-npcs runs to position
Global Const $HEADER_PARTY_CLEAR_FLAG = 0x19		;Clears the party position flag
;GAME_CMSG_PARTY_INVITE_NPC 0x9D or GAME_SMSG_PARTY_HENCHMAN_ADD 0x1BE
Global Const $HEADER_HENCHMAN_ADD = 0x9D			;Adds henchman to party
;GAME_CMSG_PARTY_LEAVE_GROUP
Global Const $HEADER_PARTY_LEAVE = 0xA0				;Leaves the party
;GAME_CMSG_PARTY_KICK_NPC 0xA6 or GAME_SMSG_PARTY_HENCHMAN_REMOVE 0x1BF
Global Const $HEADER_HENCHMAN_KICK = 0xA6			;Kicks a henchman from party
;GAME_CMSG_PARTY_INVITE_PLAYER 0x9E or GAME_SMSG_PARTY_INVITE_ADD 0x01C3
Global Const $HEADER_INVITE_TARGET = 0x9E			;Invite target player to party
;GAME_CMSG_PARTY_ACCEPT_CANCEL 0x9B or GAME_SMSG_PARTY_INVITE_CANCEL 0x01C5
Global Const $HEADER_INVITE_CANCEL = 0x9B			;Cancel invitation of player
;GAME_CMSG_PARTY_ACCEPT_INVITE 0x9A or GAME_SMSG_PARTY_JOIN_REQUEST 0x01C4
Global Const $HEADER_INVITE_ACCEPT = 0x9A			;Accept invitation to party
#EndRegion ;=PARTY=

#Region ;=TARGET (Enemies or NPC)=
;GAME_CMSG_TARGET_CALL 0x21
Global Const $HEADER_CALL_TARGET = 0x21				;Calls the target without attacking (Ctrl+Shift+Space)
;GAME_CMSG_ATTACK_AGENT 0x24
Global Const $HEADER_ATTACK_AGENT = 0x24			;Attacks agent (Space IIRC)
;GAME_CMSG_CANCEL_MOVEMENT 0x26 or GAME_SMSG_SKILL_CANCEL 0xE2
Global Const $HEADER_CANCEL_ACTION = 0x26			;Cancels the current action
;GAME_CMSG_INTERACT_PLAYER 0x31
Global Const $HEADER_AGENT_FOLLOW = 0x31			;Follows the agent/npc. Ctrl+Click triggers "I am following Person" in chat
;GAME_CMSG_INTERACT_LIVING
Global Const $HEADER_NPC_TALK = 0x37				;talks/goes to npc
;GAME_CMSG_INTERACT_ITEM 0x3D or GAME_CMSG_INTERACT_GADGET 0x4F
Global Const $HEADER_SIGNPOST_RUN = 0x4F			;Runs to signpost
#EndRegion ;=TARGET (Enemies or NPC)=

#Region ;=DROP=
;GAME_CMSG_DROP_ITEM 0x2A
Global Const $HEADER_ITEM_DROP = 0x2A				;Drops item from inventory to ground
;GAME_CMSG_DROP_GOLD
Global Const $HEADER_GOLD_DROP = 0x2D				;Drops gold from inventory to ground
#EndRegion ;=DROP=

#Region ;=BUFFS=
;GAME_CMSG_DROP_BUFF
Global Const $HEADER_STOP_MAINTAIN_ENCH = 0x27		;Drops buff, cancel enchantmant, whatever you call it
#EndRegion ;=BUFFS=

#Region ;=ITEMS=
;GAME_CMSG_EQUIP_ITEM
Global Const $HEADER_ITEM_EQUIP = 0x2E				;Equips item from inventory/chest/no idea
;GAME_CMSG_INTERACT_ITEM
Global Const $HEADER_ITEM_PICKUP = 0x3D				;Picks up an item from ground
;GAME_CMSG_ITEM_DESTROY
Global Const $HEADER_ITEM_DESTROY = 0x67			;Destroys the item
;GAME_CMSG_ITEM_IDENTIFY
Global Const $HEADER_ITEM_ID = 0x6A					;Identifies item in inventory
;GAME_CMSG_ITEM_MOVE
Global Const $HEADER_ITEM_MOVE = 0x70				;Moves item in inventory
;GAME_CMSG_ITEM_ACCEPT_ALL
Global Const $HEADER_ITEMS_ACCEPT_UNCLAIMED = 0x71	;Accepts ITEMS not picked up in missions
;GAME_CMSG_ITEM_SPLIT_STACK
Global Const $HEADER_ITEM_MOVE_EX = 0x73			;Moves an item, with amount to be moved.
;GAME_CMSG_ITEM_SALVAGE_MATERIALS
Global Const $HEADER_SALVAGE_MATS = 0x78			;Salvages materials from item
;GAME_CMSG_ITEM_SALVAGE_UPGRADE
Global Const $HEADER_SALVAGE_MODS = 0x79			;Salvages mods from item
;GAME_CMSG_ITEM_SALVAGE_SESSION_OPEN
Global Const $HEADER_SALVAGE_SESSION = 0x75			;Salvages mods from item
;GAME_CMSG_ITEM_USE
Global Const $HEADER_ITEM_USE = 0x7C				;Uses item from inventory/chest
;GAME_CMSG_UNEQUIP_ITEM
Global Const $HEADER_ITEM_UNEQUIP = 0x4D			;Unequip item

; Uncomfirmed 16/06-2023)
Global Const $HEADER_UPGRADE = 0x86					;used by gwapi. is it even useful? NOT TESTED
Global Const $HEADER_UPGRADE_ARMOR_1 = 0x83			;used by gwapi. is it even useful? NOT TESTED
Global Const $HEADER_UPGRADE_ARMOR_2 = 0x86			;used by gwapi. is it even useful? NOT TESTED
Global Const $HEADER_EQUIP_BAG = 0x70
; End of Uncomfirmed 16/06-2023)
;Global Const $HEADER_USE_ITEM = 0x85
#EndRegion ;=ITEMS=

#Region ;=TRADE=
;GAME_CMSG_TRADE_INITIATE 0x47 or GAME_SMSG_TRADE_REQUEST 0x00
Global Const $HEADER_TRADE_PLAYER = 0x47			;Send trade request to player
;GAME_SMSG_TRADE_ADD_ITEM 0x02 or 0x04
Global Const $HEADER_TRADE_OFFER_ITEM = 0x04		;Add item to trade window
;GAME_CMSG_TRADE_SEND_OFFER
Global Const $HEADER_TRADE_SUBMIT_OFFER = 0x03		;Submit offer
;GAME_SMSG_TRADE_CHANGE_OFFER
Global Const $HEADER_TRADE_CHANGE_OFFER = 0x02		;Change offer
;GAME_CMSG_TRADE_CANCEL
Global Const $HEADER_TRADE_CANCEL = 0x01			;Cancel trade
;GAME_CMSG_TRADE_ACCEPT
Global Const $HEADER_TRADE_ACCEPT = 0x07			;Accept trade
#EndRegion ;=TRADE=

#Region ;=TRAVEL=
;GAME_CMSG_PARTY_TRAVEL
Global Const $HEADER_MAP_TRAVEL = 0xAF				;Travels to outpost via worldmap
;GAME_CMSG_PARTY_ENTER_GUILD_HALL
Global Const $HEADER_GUILDHALL_TRAVEL = 0xAE		;Travels to guild hall
;GAME_CMSG_PARTY_LEAVE_GUILD_HALL
Global Const $HEADER_GUILDHALL_LEAVE = 0xB0			;Leaves Guildhall
#EndRegion ;=TRAVEL=

#Region ;=FACTION=
;GAME_CMSG_DEPOSIT_FACTION
Global Const $HEADER_FACTION_DONATE = 0x89			;Donates kurzick/luxon faction to ally
#EndRegion ;=FACTION=

#Region ;=TITLE=
;GAME_CMSG_TITLE_DISPLAY 0x56 or GAME_SMSG_TITLE_RANK_DISPLAY 0xF3
Global Const $HEADER_TITLE_DISPLAY = 0x56			;Displays title
;GAME_CMSG_TITLE_HIDE
Global Const $HEADER_TITLE_CLEAR = 0x57				;Hides title
#EndRegion ;=TITLE=

#Region ;=DIALOG=
;GAME_CMSG_SEND_DIALOG
Global Const $HEADER_DIALOG = 0x39					;Sends a dialog to NPC
;GAME_CMSG_SKIP_CINEMATIC
Global Const $HEADER_CINEMATIC_SKIP = 0x61			;Skips the cinematic
; Uncomfirmed 16/06-2023)
Global Const $HEADER_HOM_DIALOG = 0x58
; End of Uncomfirmed 16/06-2023)
#EndRegion ;=DIALOG=

#Region ;=SKILL / BUILD=
;GAME_CMSG_SKILLBAR_SKILL_SET
Global Const $HEADER_SET_SKILLBAR_SKILL = 0x5A		;Changes a skill on the skillbar
;GAME_CMSG_SKILLBAR_LOAD
Global Const $HEADER_LOAD_SKILLBAR = 0x5B			;Loads a complete build
;GAME_CMSG_CHANGE_SECOND_PROFESSION
Global Const $HEADER_CHANGE_SECONDARY = 0x3F		;Changes Secondary class (from Build window, not class changer)
; Uncomfirmed 16/06-2023) Maybe GAME_CMSG_HERO_USE_SKILL 0x1A
Global Const $HEADER_SKILL_USE_ALLY = 0x4B			;used by gwapi. appears to have changed
Global Const $HEADER_SKILL_USE_FOE = 0x4B			;used by gwapi. appears to have changed
Global Const $HEADER_SKILL_USE_ID = 0x4B			;
; End of Uncomfirmed 16/06-2023)
Global Const $HEADER_SET_ATTRIBUTES = 0x0F			;hidden in init stuff like sendchat
; Uncomfirmed 16/06-2023)
Global Const $HEADER_OPEN_SKILLS = 0x40
; End of Uncomfirmed 16/06-2023)
;GAME_CMSG_USE_SKILL
Global Const $HEADER_USE_SKILL = 0x44
; Uncomfirmed 16/06-2023) Maybe GAME_SMSG_PLAYER_UNLOCKED_PROFESSION 0xB5
Global Const $HEADER_PROFESSION_ULOCK = 0x40
; Uncomfirmed 16/06-2023)
#EndRegion ;=SKILL / BUILD=

#Region ;=CHEST=
; Uncomfirmed 16/06-2023)
;GAME_CMSG_OPEN_CHEST
Global Const $HEADER_CHEST_OPEN = 0x51				;Opens a chest (with key AFAIK)
;GAME_CMSG_ITEM_CHANGE_GOLD
Global Const $HEADER_CHANGE_GOLD = 0x7A				;Moves Gold (from chest to inventory, and otherway around IIRC)
; End of Uncomfirmed 16/06-2023)
#EndRegion ;=CHEST=

#Region ;=MISSION=
;GAME_CMSG_PARTY_SET_DIFFICULTY
Global Const $HEADER_MODE_SWITCH = 0x99				;Toggles hard- and normal mode
;GAME_CMSG_PARTY_ENTER_CHALLENGE
Global Const $HEADER_MISSION_ENTER = 0xA3			;Enter a mission/challenge
; Uncomfirmed 16/06-2023)
Global Const $HEADER_MISSION_FOREIGN_ENTER = 0xAE	;Enters a foreign mission/challenge (no idea honestly)
; End of Uncomfirmed 16/06-2023)
;GAME_CMSG_PARTY_RETURN_TO_OUTPOST
Global Const $HEADER_OUTPOST_RETURN = 0xA5			;Returns to outpost after /resign
#EndRegion ;=MISSION=

#Region ;=CHAT=
;GAME_CMSG_SEND_CHAT_MESSAGE
; Uncomfirmed 16/06-2023)
Global Const $HEADER_SEND_CHAT = 0x62				;Needed for sending messages in chat
; End of Uncomfirmed 16/06-2023)
#EndRegion ;=CHAT=

#Region ;=MOVEMENT=
;GAME_SMSG_AGENT_MOVEMENT_TICK
Global Const $HEADER_MOVEMENT_TICK = 0x1E
#EndRegion ;=MOVEMENT=

#Region ;=OTHER CONSTANTS=
; Uncomfirmed 16/06-2023)
Global Const $HEADER_MAX_ATTRIBUTES_CONST_5 = 0x04	;constant at word 5 of max attrib packet. Changed from 3 to four in most recent update
Global Const $HEADER_MAX_ATTRIBUTES_CONST_22 = 0x04	;constant at word 22 of max attrib packet. Changed from 3 to four in most recent update
Global Const $HEADER_OPEN_GB_WINDOW = 0x9E
Global Const $HEADER_CLOSE_GB_WINDOW = 0x9F
Global Const $HEADER_START_RATING_GVG = 0xA8
; End of Uncomfirmed 16/06-2023)
#EndRegion ;=OTHER CONSTANTS=