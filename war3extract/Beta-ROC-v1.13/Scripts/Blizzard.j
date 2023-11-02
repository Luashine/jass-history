//===========================================================================
// Blizzard.j ( define Jass2 functions that need to be in every map script )
//===========================================================================


globals
    constant real     bj_PI                      =   3.14159
    constant real     bj_E                       =   2.71828
    constant real     bj_CELLWIDTH               = 128.00000
    constant real     bj_UNIT_FACING             = 270.00000
    constant real     bj_RADTODEG                = 180.00000/bj_PI
    constant real     bj_DEGTORAD                = bj_PI/180.00000
    constant integer  bj_MAX_INVENTORY           =   6
    constant integer  bj_MAX_PLAYERS             =  12
    constant integer  bj_PLAYER_NEUTRAL_VICTIM   =  13
    constant integer  bj_MAX_PLAYER_SLOTS        =  16
    constant integer  bj_CAMERA_MIN_FARZ         = 100
    constant integer  bj_CAMERA_DEFAULT_DISTANCE = 1650
    constant integer  bj_CAMERA_DEFAULT_FARZ     = 5000
    constant integer  bj_CAMERA_DEFAULT_AOA      = 304
    constant integer  bj_CAMERA_DEFAULT_FOV      = 70
    constant integer  bj_CAMERA_DEFAULT_ROLL     = 0
    constant integer  bj_CAMERA_DEFAULT_ROTATION = 90

    // Constants for trigger behavior
    constant boolean  bj_CHANGE_COLOR_ON_RESCUE  = true
    constant real     bj_TRANSMISSION_PING_TIME  = 1.00
    constant integer  bj_TRANSMISSION_IND_RED    = 255
    constant integer  bj_TRANSMISSION_IND_BLUE   = 255
    constant integer  bj_TRANSMISSION_IND_GREEN  = 255
    constant integer  bj_TRANSMISSION_IND_ALPHA  = 255
    constant real     bj_CINEMODE_INTERFACEFADE  = 0.50
    constant gamespeed bj_CINEMODE_GAMESPEED     = MAP_SPEED_NORMAL

    // Constants for Melee Games:
    //   - Starting Time of Day (TOD)
    //   - Starting Gold
    //   - Starting Lumber
    //   - Starting Hero Tokens (free heroes)
    //   - Max heroes allowed per player
    //   - Distance from start loc to search for nearby mines
    //
    constant real     bj_MELEE_STARTING_TOD         = 6.00
    constant integer  bj_MELEE_STARTING_GOLD        = 750
    constant integer  bj_MELEE_STARTING_LUMBER      = 200
    constant integer  bj_MELEE_STARTING_HERO_TOKENS = 1
    constant integer  bj_MELEE_HERO_LIMIT           = 3
    constant integer  bj_MELEE_HERO_TYPE_LIMIT      = 1
    constant real     bj_MELEE_MINE_SEARCH_RADIUS   = 2000

    // Delay between a creep's death and the time it may drop an item.
    constant real     bj_CREEP_ITEM_DELAY         = 0.50

    // Force constants
    force             bj_FORCE_ALL_PLAYERS        = null
    force array       bj_FORCE_PLAYER

    // Globals used in utility functions
    integer           bj_forLoopAIndex            = 0
    integer           bj_forLoopBIndex            = 0
    integer           bj_forLoopAIndexEnd         = 0
    integer           bj_forLoopBIndexEnd         = 0

    boolean           bj_slotControlReady         = false
    boolean array     bj_slotControlUsed
    mapcontrol array  bj_slotControl

    sound             bj_dawnSound                = null
    sound             bj_duskSound                = null

    trigger           bj_meleeVisibilityDay       = null
    trigger           bj_meleeVisibilityNight     = null
    trigger           bj_meleeVisibilityTrained   = null
    boolean           bj_meleeVisibilityIsDay     = true
    player            bj_meleeClearUnitsPlayer    = null
    location          bj_meleeNearestMineToLoc    = null
    unit              bj_meleeNearestMine         = null
    real              bj_meleeNearestMineDist     = 0.00
    boolean array     bj_meleeDefeated
    boolean array     bj_meleeVictoried
    gamespeed         bj_cineModePriorSpeed       = MAP_SPEED_NORMAL
    boolean           bj_cineModePriorFogSetting  = false
    boolean           bj_cineModePriorMaskSetting = false
    boolean           bj_cineModePriorSpeedLocked = false
    boolean           bj_cineModeAlreadyIn        = false

    integer           bj_groupCountUnits          = 0
    integer           bj_groupEnumTypeId          = 0
    player            bj_groupEnumOwningPlayer    = null
    group             bj_groupAddGroupDest        = null
    group             bj_groupRemoveGroupDest     = null
    integer           bj_groupRandomConsidered    = 0
    unit              bj_groupRandomCurrentPick   = null
    integer           bj_forceRandomConsidered    = 0
    player            bj_forceRandomCurrentPick   = null
    unit              bj_makeUnitRescuableUnit    = null
    boolean           bj_makeUnitRescuableFlag    = true

    constant integer  bj_ALLIANCE_UNALLIED        = 0
    constant integer  bj_ALLIANCE_UNALLIED_VISION = 1
    constant integer  bj_ALLIANCE_ALLIED          = 2
    constant integer  bj_ALLIANCE_ALLIED_VISION   = 3
    constant integer  bj_ALLIANCE_ALLIED_UNITS    = 4
    constant integer  bj_ALLIANCE_ALLIED_ADVUNITS = 5

    constant integer  bj_TIMETYPE_ADD             = 0
    constant integer  bj_TIMETYPE_SET             = 1

    playercolor       bj_setPlayerTargetColor     = null
    boolean           bj_isUnitGroupDeadResult    = true

	integer           bj_randDistCount            = 0
	integer array     bj_randDistID
	integer array     bj_randDistChance

    unit              bj_lastCreatedUnit          = null
    item              bj_lastCreatedItem          = null
    item              bj_lastRemovedItem          = null
    destructable      bj_lastCreatedDestructable  = null
    group             bj_lastCreatedGroup         = CreateGroup()
    fogmodifier       bj_lastCreatedFogModifier   = null
    weathereffect     bj_lastCreatedWeatherEffect = null
    sound             bj_lastPlayedSound          = null
    string            bj_lastPlayedMusic          = ""
endglobals



//***************************************************************************
//*
//*  Debugging Functions
//*
//***************************************************************************

//===========================================================================
function BJDebugMsg takes string msg returns nothing
    local integer i = 0
    loop
        call DisplayTimedTextToPlayer(Player(i),0,0,60,msg)
        set i = i + 1
        exitwhen i == bj_MAX_PLAYERS
    endloop
endfunction

//***************************************************************************
//*
//*  Utility Constructs
//*
//***************************************************************************

//===========================================================================
// Runs the trigger's actions if the trigger's conditions evaluate to true.
//
function ConditionalTriggerExecute takes trigger trig returns nothing
    if TriggerEvaluate(trig) then
        call TriggerExecute(trig)
    endif
endfunction

//===========================================================================
// Arranges for a trigger to fire almost immediately, except that the calling
// trigger is not interrupted as is the case with a TriggerExecute call.
// Since the trigger executes normally, its conditions are still evaluated.
//
function PostTriggerExecute takes trigger trig, boolean checkConditions returns nothing
    if checkConditions then
        if not (TriggerEvaluate(trig)) then
            return
        endif
    endif
    call TriggerRegisterTimerEvent(trig, 0, false)
endfunction

//===========================================================================
// %%% Obsolete - Custom-scripted by WorldEdit.
//function IfThenElse takes boolexpr ifCondition, code ifAction, code elseAction returns nothing
//    local trigger trig = CreateTrigger()
//
//    call TriggerAddCondition(trig, ifCondition)
//    if TriggerEvaluate(trig) then
//        call TriggerAddAction(trig, ifAction)
//    else
//        call TriggerAddAction(trig, elseAction)
//    endif
//    call TriggerExecute(trig)
//    call DestroyTrigger(trig)
//endfunction

//===========================================================================
function GetForLoopIndexA takes nothing returns integer
    return bj_forLoopAIndex
endfunction

//===========================================================================
function SetForLoopIndexA takes integer newIndex returns nothing
    set bj_forLoopAIndex = newIndex
endfunction

//===========================================================================
// %%% Obsolete - Custom-scripted by WorldEdit.
//function ForLoopA takes integer indexStart, integer indexFinish, code forAction returns nothing
//    local trigger trig = CreateTrigger()
//
//    call TriggerAddAction(trig, forAction)
//    set bj_forLoopAIndex = indexStart
//    loop
//        exitwhen bj_forLoopAIndex > indexFinish
//        call TriggerExecute(trig)
//        set bj_forLoopAIndex = bj_forLoopAIndex + 1
//    endloop
//
//    call DestroyTrigger(trig)
//endfunction

//===========================================================================
function GetForLoopIndexB takes nothing returns integer
    return bj_forLoopBIndex
endfunction

//===========================================================================
function SetForLoopIndexB takes integer newIndex returns nothing
    set bj_forLoopBIndex = newIndex
endfunction

//===========================================================================
// %%% Obsolete - Custom-scripted by WorldEdit.
//function ForLoopB takes integer indexStart, integer indexFinish, code forAction returns nothing
//    local trigger trig = CreateTrigger()
//
//    call TriggerAddAction(trig, forAction)
//    set bj_forLoopBIndex = indexStart
//    loop
//        exitwhen bj_forLoopBIndex > indexFinish
//        call TriggerExecute(trig)
//        set bj_forLoopBIndex = bj_forLoopBIndex + 1
//    endloop
//
//    call DestroyTrigger(trig)
//endfunction



//***************************************************************************
//*
//*  General Utility functions
//*  These functions exist purely to make the trigger dialogs cleaner and
//*  more comprehensible.
//*
//***************************************************************************

//===========================================================================
function DoNothing takes nothing returns nothing
endfunction

//===========================================================================
// This function does nothing.  WorldEdit should should eventually ignore
// CommentString triggers during script generation, but until such a time,
// this function will serve as a stub.
//
function CommentString takes string commentString returns nothing
endfunction

//===========================================================================
// Temporary function, to be removed when Null gets hard-coded in the editor.
function Null takes nothing returns boolean
    return true
endfunction

//===========================================================================
// The ability to set a condition that always fails is useful for debugging
// maps, as it allows a simple method of disabling triggers.
function GetFalse takes nothing returns boolean
    return false
endfunction

//===========================================================================
// This is basically a conversion function from a simple boolean reference
// to a boolexpr function.
function GetBooleanVariableValue takes boolean whatValue returns boolean
    return whatValue
endfunction

//===========================================================================
function GetBooleanAnd takes boolean valueA, boolean valueB returns boolean
    return valueA and valueB
endfunction

//===========================================================================
function GetBooleanOr takes boolean valueA, boolean valueB returns boolean
    return valueA or valueB
endfunction

//===========================================================================
// Converts a percentage (real, 0..100) into a scaled integer (0..max),
// clipping the result to 0..max in case the input is invalid.
//
function PercentToInt takes real percentage, integer max returns integer
    local integer result = R2I(percentage * I2R(max) * 0.01)

    if (result < 0) then
        set result = 0
    elseif (result > max) then
        set result = max
    endif

    return result
endfunction

//===========================================================================
function PercentTo255 takes real percentage returns integer
    return PercentToInt(percentage, 255)
endfunction

//===========================================================================
function GetTimeOfDay takes nothing returns real
    return GetFloatGameState(GAME_STATE_TIME_OF_DAY)
endfunction

//===========================================================================
function SetTimeOfDay takes real whatTime returns nothing
    call SetFloatGameState(GAME_STATE_TIME_OF_DAY, whatTime)
endfunction

//===========================================================================
function CreateUnitAtLocSaveLast takes player id, integer unitid, location whichLocation, real face returns unit
    set bj_lastCreatedUnit = CreateUnitAtLoc( id, unitid, whichLocation, face )
    return bj_lastCreatedUnit
endfunction

//===========================================================================
function GetLastCreatedUnit takes nothing returns unit
    return bj_lastCreatedUnit
endfunction

//===========================================================================
function CreateNUnitsAtLoc takes integer count, integer unitId, player whichPlayer, location loc, real face returns group
    set bj_lastCreatedGroup = CreateGroup()
    loop
        set count = count - 1
        exitwhen count < 0
        call CreateUnitAtLocSaveLast(whichPlayer, unitId, loc, face)
        call GroupAddUnit(bj_lastCreatedGroup, bj_lastCreatedUnit)
    endloop
    return bj_lastCreatedGroup
endfunction

//===========================================================================
function GetLastCreatedGroup takes nothing returns group
    return bj_lastCreatedGroup
endfunction

//===========================================================================
function CreateDestructableLoc takes integer bj_objectid, location bj_loc, real bj_face, real bj_scale, integer bj_variation returns destructable
    set bj_lastCreatedDestructable = CreateDestructable(bj_objectid, GetLocationX(bj_loc), GetLocationY(bj_loc), bj_face, bj_scale, bj_variation)
    return bj_lastCreatedDestructable
endfunction

//===========================================================================
function GetLastCreatedDestructable takes nothing returns destructable
    return bj_lastCreatedDestructable
endfunction

//===========================================================================
function PlaySound takes string soundName returns nothing
    local sound soundHandle = CreateSound(soundName, false, false, true, 12700, 12700, "")
    call StartSound(soundHandle)
    call KillSoundWhenDone(soundHandle)
endfunction



//***************************************************************************
//*
//*  Camera Utility Functions
//*
//***************************************************************************

//===========================================================================
function GetCurrentCameraSetup takes nothing returns camerasetup
    local camerasetup theCam = CreateCameraSetup()
    local real duration = 0
    call CameraSetupSetField(theCam, CAMERA_FIELD_TARGET_DISTANCE, GetCameraField(CAMERA_FIELD_TARGET_DISTANCE), duration)
    call CameraSetupSetField(theCam, CAMERA_FIELD_FARZ, GetCameraField(CAMERA_FIELD_TARGET_DISTANCE), duration)
    call CameraSetupSetField(theCam, CAMERA_FIELD_ANGLE_OF_ATTACK, GetCameraField(CAMERA_FIELD_TARGET_DISTANCE), duration)
    call CameraSetupSetField(theCam, CAMERA_FIELD_FIELD_OF_VIEW, GetCameraField(CAMERA_FIELD_TARGET_DISTANCE), duration)
    call CameraSetupSetField(theCam, CAMERA_FIELD_ROLL, GetCameraField(CAMERA_FIELD_TARGET_DISTANCE), duration)
    call CameraSetupSetField(theCam, CAMERA_FIELD_ROTATION, GetCameraField(CAMERA_FIELD_TARGET_DISTANCE), duration)
    call CameraSetupSetField(theCam, CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_TARGET_DISTANCE), duration)
    call CameraSetupSetDestPosition(theCam, GetCameraTargetPositionX(), GetCameraTargetPositionY(), duration)
    return theCam
endfunction

//===========================================================================
function CameraSetupApplyForPlayer takes boolean doPan, camerasetup whichSetup, player whichPlayer, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call CameraSetupApplyForceDuration(whichSetup, doPan, duration)
    endif
endfunction

//===========================================================================
function CameraSetupGetFieldSwap takes camerafield whichField, camerasetup whichSetup returns real
    return CameraSetupGetField(whichSetup, whichField)
endfunction

//===========================================================================
function SetCameraFields takes real dist, real farZ, real aoa, real fov, real roll, real rot, real duration returns nothing
    call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, dist, duration)
    call SetCameraField(CAMERA_FIELD_FARZ,            farZ, duration)
    call SetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK, aoa,  duration)
    call SetCameraField(CAMERA_FIELD_FIELD_OF_VIEW,   fov,  duration)
    call SetCameraField(CAMERA_FIELD_ROLL,            roll, duration)
    call SetCameraField(CAMERA_FIELD_ROTATION,        rot,  duration)
endfunction

//===========================================================================
function AdjustCameraFields takes real dist, real farZ, real aoa, real fov, real roll, real rot, real duration returns nothing
    call AdjustCameraField(CAMERA_FIELD_TARGET_DISTANCE, dist, duration)
    call AdjustCameraField(CAMERA_FIELD_FARZ,            farZ, duration)
    call AdjustCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK, aoa,  duration)
    call AdjustCameraField(CAMERA_FIELD_FIELD_OF_VIEW,   fov,  duration)
    call AdjustCameraField(CAMERA_FIELD_ROLL,            roll, duration)
    call AdjustCameraField(CAMERA_FIELD_ROTATION,        rot,  duration)
endfunction

//===========================================================================
function SetCameraFieldForPlayer takes player whichPlayer, camerafield whichField, real value, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call SetCameraField(whichField, value, duration)
    endif
endfunction

//===========================================================================
function SetCameraFieldsForPlayer takes player whichPlayer, real dist, real farZ, real aoa, real fov, real roll, real rot, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call SetCameraFields(dist, farZ, aoa, fov, roll, rot, duration)
    endif
endfunction

//===========================================================================
function AdjustCameraFieldForPlayer takes player whichPlayer, camerafield whichField, real value, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call AdjustCameraField(whichField, value, duration)
    endif
endfunction

//===========================================================================
function AdjustCameraFieldsForPlayer takes player whichPlayer, real dist, real farZ, real aoa, real fov, real roll, real rot, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call AdjustCameraFields(dist, farZ, aoa, fov, roll, rot, duration)
    endif
endfunction

//===========================================================================
function SetCameraTargetControllerNoZForPlayer takes player whichPlayer, unit whichUnit, real xoffset, real yoffset, boolean inheritOrientation returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call SetCameraTargetController(whichUnit, xoffset, yoffset, inheritOrientation)
    endif
endfunction

//===========================================================================
function SetCameraPositionForPlayer takes player whichPlayer, real x, real y returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call SetCameraPosition(x, y)
    endif
endfunction

//===========================================================================
function SetCameraPositionLocForPlayer takes player whichPlayer, location loc returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call SetCameraPosition(GetLocationX(loc), GetLocationY(loc))
    endif
endfunction

//===========================================================================
function PanCameraToForPlayer takes player whichPlayer, real x, real y returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PanCameraTo(x, y)
    endif
endfunction

//===========================================================================
function PanCameraToLocForPlayer takes player whichPlayer, location loc returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PanCameraTo(GetLocationX(loc), GetLocationY(loc))
    endif
endfunction

//===========================================================================
function PanCameraToTimedForPlayer takes player whichPlayer, real x, real y, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PanCameraToTimed(x, y, duration)
    endif
endfunction

//===========================================================================
function PanCameraToTimedLocForPlayer takes player whichPlayer, location loc, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PanCameraToTimed(GetLocationX(loc), GetLocationY(loc), duration)
    endif
endfunction

//===========================================================================
function PanCameraToTimedLocWithZForPlayer takes player whichPlayer, location loc, real zOffset, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PanCameraToTimedWithZ(GetLocationX(loc), GetLocationY(loc), zOffset, duration)
    endif
endfunction

//===========================================================================
function SetCinematicCameraForPlayer takes player whichPlayer, string cameraModelFile returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call SetCinematicCamera(cameraModelFile)
    endif
endfunction

//===========================================================================
function ResetToGameCameraForPlayer takes player whichPlayer, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call ResetToGameCamera(duration)
    endif
endfunction

//===========================================================================
function CameraSetSourceNoiseForPlayer takes player whichPlayer, real magnitude, real velocity returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call CameraSetSourceNoise(magnitude, velocity)
    endif
endfunction

//===========================================================================
function CameraSetTargetNoiseForPlayer takes player whichPlayer, real magnitude, real velocity returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call CameraSetTargetNoise(magnitude, velocity)
    endif
endfunction

//===========================================================================
function CameraClearNoiseForPlayer takes player whichPlayer returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call CameraSetSourceNoise(0, 0)
        call CameraSetTargetNoise(0, 0)
    endif
endfunction

//===========================================================================
function SetCameraBoundsToRect takes rect r returns nothing
    local real minX = GetRectMinX(r)
    local real minY = GetRectMinY(r)
    local real maxX = GetRectMaxX(r)
    local real maxY = GetRectMaxY(r)
    call SetCameraBounds(minX, minY, minX, maxY, maxX, maxY, maxX, minY)
endfunction

//===========================================================================
function SetCameraQuickPositionForPlayer takes player whichPlayer, real x, real y returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call SetCameraQuickPosition(x, y)
    endif
endfunction

//===========================================================================
function SetCameraQuickPositionLocForPlayer takes player whichPlayer, location loc returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call SetCameraQuickPosition(GetLocationX(loc), GetLocationY(loc))
    endif
endfunction

//===========================================================================
function SetCameraQuickPositionLoc takes location loc returns nothing
    call SetCameraQuickPosition(GetLocationX(loc), GetLocationY(loc))
endfunction



//***************************************************************************
//*
//*  Cinematics Utility Functions
//*
//***************************************************************************

//===========================================================================
function ResetUnitAnimation takes unit whichUnit returns nothing
    call SetUnitAnimation(whichUnit, "")
endfunction

//===========================================================================
function SetUnitTimeScalePercent takes unit whichUnit, real percentScale returns nothing
    call SetUnitTimeScale(whichUnit, percentScale * 0.01)
endfunction

//===========================================================================
function SetUnitScalePercent takes unit whichUnit, real percentScaleX, real percentScaleY, real percentScaleZ returns nothing
    call SetUnitScale(whichUnit, percentScaleX * 0.01, percentScaleY * 0.01, percentScaleZ * 0.01)
endfunction

//===========================================================================
function PauseGameOn takes nothing returns nothing
    call PauseGame(true)
endfunction

//===========================================================================
function PauseGameOff takes nothing returns nothing
    call PauseGame(false)
endfunction

//===========================================================================
function SetUserControlForceOn takes force whichForce returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call EnableUserControl(true)
    endif
endfunction

//===========================================================================
function SetUserControlForceOff takes force whichForce returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call EnableUserControl(false)
    endif
endfunction

//===========================================================================
function ShowInterfaceForceOn takes force whichForce, real fadeDuration returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call ShowInterface(true, fadeDuration)
    endif
endfunction

//===========================================================================
function ShowInterfaceForceOff takes force whichForce, real fadeDuration returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call ShowInterface(false, fadeDuration)
    endif
endfunction

//===========================================================================
function PingMinimapForForce takes force whichForce, real x, real y, real duration returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PingMinimap(x, y, duration)
    endif
endfunction

//===========================================================================
function PingMinimapLocForForce takes force whichForce, location loc, real duration returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PingMinimap(GetLocationX(loc), GetLocationY(loc), duration)
    endif
endfunction

//===========================================================================
function PingMinimapForPlayer takes player whichPlayer, real x, real y, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PingMinimap(x, y, duration)
    endif
endfunction

//===========================================================================
function PingMinimapLocForPlayer takes player whichPlayer, location loc, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PingMinimap(GetLocationX(loc), GetLocationY(loc), duration)
    endif
endfunction



//***************************************************************************
//*
//*  Text Utility Functions
//*
//***************************************************************************

//===========================================================================
function DisplayTextToForce takes force toForce, string message returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), toForce)) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, message)
    endif
endfunction

//===========================================================================
function DisplayTimedTextToForce takes force toForce, real duration, string message returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), toForce)) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, duration, message)
    endif
endfunction

//===========================================================================
// The parameters for the API Substring function are unintuitive, so this
// merely performs a translation for the starting index.
//
function SubStringBJ takes string source, integer start, integer end returns string
    return SubString(source, start-1, end)
endfunction



//***************************************************************************
//*
//*  Event Registration Utility Functions
//*
//***************************************************************************

//===========================================================================
function TriggerRegisterTimerEventPeriodic takes trigger trig, real timeout returns event
    return TriggerRegisterTimerEvent(trig, timeout, true)
endfunction

//===========================================================================
function TriggerRegisterTimerEventSingle takes trigger trig, real timeout returns event
    return TriggerRegisterTimerEvent(trig, timeout, false)
endfunction

//===========================================================================
function TriggerRegisterPlayerUnitEventSimple takes trigger trig, player whichPlayer, playerunitevent whichEvent returns event
    return TriggerRegisterPlayerUnitEvent(trig, whichPlayer, whichEvent, null)
endfunction

//===========================================================================
function TriggerRegisterPlayerEventVictory takes trigger trig, player whichPlayer returns event
    return TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_VICTORY)
endfunction

//===========================================================================
function TriggerRegisterPlayerEventDefeat takes trigger trig, player whichPlayer returns event
    return TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_DEFEAT)
endfunction

//===========================================================================
function TriggerRegisterPlayerEventAllianceChanged takes trigger trig, player whichPlayer returns event
    return TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_ALLIANCE_CHANGED)
endfunction

//===========================================================================
function TriggerRegisterPlayerEventEndCinematic takes trigger trig, player whichPlayer returns event
    return TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_END_CINEMATIC)
endfunction

//===========================================================================
function TriggerRegisterGameStateEventPlayersInt takes trigger trig, limitop opcode, integer limitval returns event
    return TriggerRegisterGameStateEvent(trig, GAME_STATE_PLAYERS, opcode, I2R(limitval))
endfunction

//===========================================================================
function TriggerRegisterGameStateEventPlayers takes trigger trig, limitop opcode, real limitval returns event
    return TriggerRegisterGameStateEvent(trig, GAME_STATE_PLAYERS, opcode, limitval)
endfunction

//===========================================================================
function TriggerRegisterGameStateEventTimeOfDay takes trigger trig, limitop opcode, real limitval returns event
    return TriggerRegisterGameStateEvent(trig, GAME_STATE_TIME_OF_DAY, opcode, limitval)
endfunction

//===========================================================================
function TriggerRegisterEnterRegionSimple takes trigger trig, region whichRegion returns event
    return TriggerRegisterEnterRegion(trig, whichRegion, null)
endfunction

//===========================================================================
function TriggerRegisterLeaveRegionSimple takes trigger trig, region whichRegion returns event
    return TriggerRegisterLeaveRegion(trig, whichRegion, null)
endfunction

//===========================================================================
function TriggerRegisterEnterRectSimple takes trigger trig, rect r returns event
    local region rectRegion = CreateRegion()
    call RegionAddRect(rectRegion, r)
    return TriggerRegisterEnterRegion(trig, rectRegion, null)
endfunction

//===========================================================================
function TriggerRegisterLeaveRectSimple takes trigger trig, rect r returns event
    local region rectRegion = CreateRegion()
    call RegionAddRect(rectRegion, r)
    return TriggerRegisterLeaveRegion(trig, rectRegion, null)
endfunction

//===========================================================================
function TriggerRegisterDistanceBetweenUnits takes trigger trig, unit whichUnit, boolexpr condition, real range returns event
    return TriggerRegisterUnitInRange(trig, whichUnit, range, condition)
endfunction

//===========================================================================
function TriggerRegisterUnitInRangeSimple takes trigger trig, real range, unit whichUnit returns event
    return TriggerRegisterUnitInRange(trig, whichUnit, range, null)
endfunction

//===========================================================================
function TriggerRegisterUnitLifeEvent takes trigger trig, unit whichUnit, limitop opcode, real limitval returns event
    return TriggerRegisterUnitStateEvent(trig, whichUnit, UNIT_STATE_LIFE, opcode, limitval)
endfunction

//===========================================================================
function TriggerRegisterUnitManaEvent takes trigger trig, unit whichUnit, limitop opcode, real limitval returns event
    return TriggerRegisterUnitStateEvent(trig, whichUnit, UNIT_STATE_MANA, opcode, limitval)
endfunction



//***************************************************************************
//*
//*  Environment Utility Functions
//*
//***************************************************************************

//===========================================================================
function AddWeatherEffectSaveLast takes rect where, integer effectID returns weathereffect
    set bj_lastCreatedWeatherEffect = AddWeatherEffect(where, effectID)
    return bj_lastCreatedWeatherEffect
endfunction

//===========================================================================
function GetLastCreatedWeatherEffect takes nothing returns weathereffect
    return bj_lastCreatedWeatherEffect
endfunction

//===========================================================================
function CreateFogModifierRectSimple takes player whichPlayer, fogstate whichFogState, rect r, boolean afterUnits returns fogmodifier
    set bj_lastCreatedFogModifier = CreateFogModifierRect(whichPlayer, whichFogState, r, true, afterUnits)
    return bj_lastCreatedFogModifier
endfunction

//===========================================================================
function CreateFogModifierRadiusLocSimple takes player whichPlayer, fogstate whichFogState, location center, real radius, boolean afterUnits returns fogmodifier
    set bj_lastCreatedFogModifier = CreateFogModifierRadiusLoc(whichPlayer, whichFogState, center, radius, true, afterUnits)
    return bj_lastCreatedFogModifier
endfunction

//===========================================================================
// Version of CreateFogModifierRect that assumes use of sharedVision and
// gives the option of immediately enabling the modifier, so that triggers
// can default to modifiers that are immediately enabled.
//
function CreateFogModifierRectBJ takes boolean enabled, player whichPlayer, fogstate whichFogState, rect r returns fogmodifier
    set bj_lastCreatedFogModifier = CreateFogModifierRect(whichPlayer, whichFogState, r, true, false)
    if enabled then
        call FogModifierStart(bj_lastCreatedFogModifier)
    endif
    return bj_lastCreatedFogModifier
endfunction

//===========================================================================
// Version of CreateFogModifierRadius that assumes use of sharedVision and
// gives the option of immediately enabling the modifier, so that triggers
// can default to modifiers that are immediately enabled.
//
function CreateFogModifierRadiusLocBJ takes boolean enabled, player whichPlayer, fogstate whichFogState, location center, real radius returns fogmodifier
    set bj_lastCreatedFogModifier = CreateFogModifierRadiusLoc(whichPlayer, whichFogState, center, radius, true, false)
    if enabled then
        call FogModifierStart(bj_lastCreatedFogModifier)
    endif
    return bj_lastCreatedFogModifier
endfunction

//===========================================================================
function GetLastCreatedFogModifier takes nothing returns fogmodifier
    return bj_lastCreatedFogModifier
endfunction

//===========================================================================
function FogEnableOn takes nothing returns nothing
    call FogEnable(true)
endfunction

//===========================================================================
function FogEnableOff takes nothing returns nothing
    call FogEnable(false)
endfunction

//===========================================================================
function FogMaskEnableOn takes nothing returns nothing
    call FogMaskEnable(true)
endfunction

//===========================================================================
function FogMaskEnableOff takes nothing returns nothing
    call FogMaskEnable(false)
endfunction

//===========================================================================
function UseTimeOfDayBJ takes boolean flag returns nothing
    call SuspendTimeOfDay(not flag)
endfunction



//***************************************************************************
//*
//*  Sound Utility Functions
//*
//***************************************************************************

//===========================================================================
function PlaySoundBJ takes sound soundHandle returns nothing
    set bj_lastPlayedSound = soundHandle
    call StartSound(soundHandle)
endfunction

//===========================================================================
function StopSoundBJ takes sound soundHandle, boolean fadeOut returns nothing
    call StopSound(soundHandle, false, fadeOut)
endfunction

//===========================================================================
function SetSoundVolumeBJ takes sound soundHandle, real volumePercent returns nothing
    call SetSoundVolume(soundHandle, PercentToInt(volumePercent, 127))
endfunction

//===========================================================================
function SetSoundDistanceCutoffBJ takes sound soundHandle, real cutoff returns nothing
    call SetSoundDistanceCutoff(soundHandle, cutoff)
endfunction

//===========================================================================
function SetSoundPitchBJ takes sound soundHandle, real pitch returns nothing
    call SetSoundPitch(soundHandle, pitch)
endfunction

//===========================================================================
function SetSoundPositionLocBJ takes sound soundHandle, location loc, real z returns nothing
    call SetSoundPosition(soundHandle, GetLocationX(loc), GetLocationY(loc), z)
endfunction

//===========================================================================
function SetSoundConeAnglesBJ takes sound soundHandle, real inside, real outside, real outsideVolumePercent returns nothing
    call SetSoundConeAngles(soundHandle, inside, outside, PercentToInt(outsideVolumePercent, 127))
endfunction

//===========================================================================
function KillSoundWhenDoneBJ takes sound soundHandle returns nothing
    call KillSoundWhenDone(soundHandle)
endfunction

//===========================================================================
function PlayMusicBJ takes string musicFileName returns nothing
    set bj_lastPlayedMusic = musicFileName
    call PlayMusic(musicFileName)
endfunction

//===========================================================================
function PlayThematicMusicBJ takes string musicName returns nothing
    call PlayThematicMusic(musicName)
endfunction

//===========================================================================
function StopMusicBJ takes boolean fadeOut returns nothing
    call StopMusic(fadeOut)
endfunction

//===========================================================================
function ResumeMusicBJ takes nothing returns nothing
    call ResumeMusic()
endfunction

//===========================================================================
function SetMusicVolumeBJ takes real volumePercent returns nothing
    call SetMusicVolume(PercentToInt(volumePercent, 127))
endfunction

//===========================================================================
function GetSoundDurationBJ takes sound soundHandle returns real
    return I2R(GetSoundDuration(soundHandle)) * 0.001
endfunction

//===========================================================================
function GetSoundFileDurationBJ takes string musicFileName returns real
    return I2R(GetSoundFileDuration(musicFileName)) * 0.001
endfunction

//===========================================================================
function GetLastPlayedSound takes nothing returns sound
    return bj_lastPlayedSound
endfunction

//===========================================================================
function GetLastPlayedMusic takes nothing returns string
    return bj_lastPlayedMusic
endfunction



//***************************************************************************
//*
//*  Hero and Item Utility Functions
//*
//***************************************************************************

//===========================================================================
function AddHeroXPSwapped takes integer xpToAdd, unit whichHero, boolean showEyeCandy returns nothing
    call AddHeroXP(whichHero, xpToAdd, showEyeCandy)
endfunction

//===========================================================================
function UnitAddItemSwapped takes item whichItem, unit whichHero returns boolean
    return UnitAddItem(whichHero, whichItem)
endfunction

//===========================================================================
function UnitAddItemByIdSwapped takes integer itemId, unit whichHero returns item
    set bj_lastCreatedItem = UnitAddItemById(whichHero, itemId)
    return bj_lastCreatedItem
endfunction

//===========================================================================
function UnitRemoveItemSwapped takes item whichItem, unit whichHero returns nothing
    set bj_lastRemovedItem = whichItem
    call UnitRemoveItem(whichHero, whichItem)
endfunction

//===========================================================================
// Translates 0-based slot indices to 1-based slot indices.
//
function UnitRemoveItemFromSlotSwapped takes integer itemSlot, unit whichHero returns item
    set bj_lastRemovedItem = UnitRemoveItemFromSlot(whichHero, itemSlot-1)
    return bj_lastRemovedItem
endfunction

//===========================================================================
function CreateItemLoc takes integer itemId, location loc returns item
    set bj_lastCreatedItem = CreateItem(itemId, GetLocationX(loc), GetLocationY(loc))
    return bj_lastCreatedItem
endfunction

//===========================================================================
function GetLastCreatedItem takes nothing returns item
    return bj_lastCreatedItem
endfunction

//===========================================================================
function GetLastRemovedItem takes nothing returns item
    return bj_lastRemovedItem
endfunction

//===========================================================================
function SetItemPositionLoc takes item whichItem, location loc returns nothing
    call SetItemPosition(whichItem, GetLocationX(loc), GetLocationY(loc))
endfunction

//===========================================================================
function SuspendHeroXPBJ takes boolean flag, unit whichHero returns nothing
    call SuspendHeroXP(whichHero, not flag)
endfunction

//===========================================================================
// Two distinct trigger actions can't share the same function name, so this
// dummy function simply mimics the behavior of an existing call.
//
function UnitUseItemDestructable takes unit whichUnit, item whichItem, widget target returns boolean
    return UnitUseItemTarget(whichUnit, whichItem, target)
endfunction

//===========================================================================
function UnitUseItemPointLoc takes unit whichUnit, item whichItem, location loc returns boolean
    return UnitUseItemPoint(whichUnit, whichItem, GetLocationX(loc), GetLocationY(loc))
endfunction

//===========================================================================
// Translates 0-based slot indices to 1-based slot indices.
//
function UnitItemInSlotBJ takes unit whichUnit, integer itemSlot returns item
    return UnitItemInSlot(whichUnit, itemSlot-1)
endfunction

//===========================================================================
// Translates 0-based slot indices to 1-based slot indices.
//
function GetInventoryIndexOfItemTypeBJ takes unit whichUnit, integer itemId returns integer
    local integer index
    local item    indexItem

    set index = 0
    loop
        set indexItem = UnitItemInSlot(whichUnit, index)
        if (indexItem != null) and (GetItemTypeId(indexItem) == itemId) then
            return index+1
        endif

        set index = index + 1
        exitwhen index >= bj_MAX_INVENTORY
    endloop
    return 0
endfunction

//===========================================================================
function GetItemOfTypeFromUnitBJ takes unit whichUnit, integer itemId returns item
    local integer index = GetInventoryIndexOfItemTypeBJ(whichUnit, itemId)
    return UnitItemInSlot(whichUnit, index-1)
endfunction

//===========================================================================
function UnitHasItemOfTypeBJ takes unit whichUnit, integer itemId returns boolean
    return GetInventoryIndexOfItemTypeBJ(whichUnit, itemId) > 0
endfunction



//***************************************************************************
//*
//*  Unit Utility Functions
//*
//***************************************************************************

//===========================================================================
function GetUnitStateSwap takes unitstate whichState, unit whichUnit returns real
    return GetUnitState(whichUnit, whichState)
endfunction

//===========================================================================
function SelectUnitSingle takes unit whichUnit returns nothing
    call ClearSelection()
    call SelectUnit(whichUnit, true)
endfunction

//===========================================================================
function SelectUnitAdd takes unit whichUnit returns nothing
    call SelectUnit(whichUnit, true)
endfunction

//===========================================================================
function SelectUnitRemove takes unit whichUnit returns nothing
    call SelectUnit(whichUnit, false)
endfunction

//===========================================================================
function SetUnitLifeBJ takes unit whichUnit, real newValue returns nothing
    call SetUnitState(whichUnit, UNIT_STATE_LIFE, newValue)
endfunction

//===========================================================================
function SetUnitManaBJ takes unit whichUnit, real newValue returns nothing
    call SetUnitState(whichUnit, UNIT_STATE_MANA, newValue)
endfunction

//===========================================================================
function SetUnitLifePercentBJ takes unit whichUnit, real percent returns nothing
    call SetUnitState(whichUnit, UNIT_STATE_LIFE, GetUnitState(whichUnit, UNIT_STATE_MAX_LIFE) * percent * 0.01)
endfunction

//===========================================================================
function SetUnitManaPercentBJ takes unit whichUnit, real percent returns nothing
    call SetUnitState(whichUnit, UNIT_STATE_MANA, GetUnitState(whichUnit, UNIT_STATE_MAX_MANA) * percent * 0.01)
endfunction

//===========================================================================
function IsUnitDeadBJ takes unit whichUnit returns boolean
    return GetUnitState(whichUnit, UNIT_STATE_LIFE) <= 0
endfunction

//===========================================================================
function IsUnitGroupDeadBJEnum takes nothing returns nothing
    if not IsUnitDeadBJ(GetEnumUnit()) then
        set bj_isUnitGroupDeadResult = false
    endif
endfunction

//===========================================================================
// Returns true if every unit of the group is dead.
//
function IsUnitGroupDeadBJ takes group g returns boolean
    set bj_isUnitGroupDeadResult = true
    call ForGroup(g, function IsUnitGroupDeadBJEnum)
    return bj_isUnitGroupDeadResult
endfunction

//===========================================================================
function ShowUnitHide takes unit whichUnit returns nothing
    call ShowUnit(whichUnit, false)
endfunction

//===========================================================================
function ShowUnitShow takes unit whichUnit returns nothing
    call ShowUnit(whichUnit, true)
endfunction

//===========================================================================
function IssueBuildOrderByIdLocBJ takes unit whichPeon, integer unitId, location loc returns boolean
    return IssueBuildOrderById(whichPeon, unitId, GetLocationX(loc), GetLocationY(loc))
endfunction

//===========================================================================
function GetAttackedUnitBJ takes nothing returns unit
    return GetTriggerUnit()
endfunction



//***************************************************************************
//*
//*  Math Utility Functions
//*
//***************************************************************************

//===========================================================================
function SinBJ takes real degrees returns real
    return Sin(degrees * bj_DEGTORAD)
endfunction

//===========================================================================
function CosBJ takes real degrees returns real
    return Cos(degrees * bj_DEGTORAD)
endfunction

//===========================================================================
function TanBJ takes real degrees returns real
    return Tan(degrees * bj_DEGTORAD)
endfunction

//===========================================================================
function AsinBJ takes real degrees returns real
    return Asin(degrees) * bj_RADTODEG
endfunction

//===========================================================================
function AcosBJ takes real degrees returns real
    return Acos(degrees) * bj_RADTODEG
endfunction

//===========================================================================
function AtanBJ takes real degrees returns real
    return Atan(degrees) * bj_RADTODEG
endfunction

//===========================================================================
function Atan2BJ takes real y, real x returns real
    return Atan2(y, x) * bj_RADTODEG
endfunction

//===========================================================================
function AngleBetweenPoints takes location locA, location locB returns real
    return bj_RADTODEG * Atan2(GetLocationY(locB) - GetLocationY(locA), GetLocationX(locB) - GetLocationX(locA))
endfunction

//===========================================================================
function DistanceBetweenPoints takes location locA, location locB returns real
    local real dx = GetLocationX(locB) - GetLocationX(locA)
    local real dy = GetLocationY(locB) - GetLocationY(locA)
    return SquareRoot(dx * dx + dy * dy)
endfunction

//===========================================================================
function GetRandomDirectionDeg takes nothing returns real
    return GetRandomReal(0, 360)
endfunction

//===========================================================================
function GetRandomLocInRect takes rect whichRect returns location
    return Location(GetRandomReal(GetRectMinX(whichRect), GetRectMaxX(whichRect)), GetRandomReal(GetRectMinY(whichRect), GetRectMaxY(whichRect)))
endfunction

//===========================================================================
// Calculate the modulus/remainder of (dividend) divided by (divisor).
// Examples:  18 mod 5 = 3.  15 mod 5 = 0.  -8 mod 5 = 2.
//
function ModuloInteger takes integer dividend, integer divisor returns integer
    local integer modulus = dividend - (dividend / divisor) * divisor

    // If the dividend was negative, the above modulus calculation will
    // be negative, but within (-divisor..0).  We can add (divisor) to
    // shift this result into the desired range of (0..divisor).
    if (modulus < 0) then
        set modulus = modulus + divisor
    endif

    return modulus
endfunction

//===========================================================================
// Calculate the modulus/remainder of (dividend) divided by (divisor).
// Examples:  13.000 mod 2.500 = 0.500.  -6.000 mod 2.500 = 1.500.
//
function ModuloReal takes real dividend, real divisor returns real
    local real modulus = dividend - I2R(R2I(dividend / divisor)) * divisor

    // If the dividend was negative, the above modulus calculation will
    // be negative, but within (-divisor..0).  We can add (divisor) to
    // shift this result into the desired range of (0..divisor).
    if (modulus < 0) then
        set modulus = modulus + divisor
    endif

    return modulus
endfunction



//***************************************************************************
//*
//*  Group and Force Utility Functions
//*
//***************************************************************************

//===========================================================================
function GroupAddUnitSimple takes unit whichUnit, group whichGroup returns nothing
    call GroupAddUnit(whichGroup, whichUnit)
endfunction

//===========================================================================
function GroupRemoveUnitSimple takes unit whichUnit, group whichGroup returns nothing
    call GroupRemoveUnit(whichGroup, whichUnit)
endfunction

//===========================================================================
function GroupAddGroupEnum takes nothing returns nothing
    call GroupAddUnit(bj_groupAddGroupDest, GetEnumUnit())
endfunction

//===========================================================================
function GroupAddGroup takes group sourceGroup, group destGroup returns nothing
    set bj_groupAddGroupDest = destGroup
    call ForGroup(sourceGroup, function GroupAddGroupEnum)
endfunction

//===========================================================================
function GroupRemoveGroupEnum takes nothing returns nothing
    call GroupRemoveUnit(bj_groupRemoveGroupDest, GetEnumUnit())
endfunction

//===========================================================================
function GroupRemoveGroup takes group sourceGroup, group destGroup returns nothing
    set bj_groupRemoveGroupDest = destGroup
    call ForGroup(sourceGroup, function GroupRemoveGroupEnum)
endfunction

//===========================================================================
function ForceAddPlayerSimple takes player whichPlayer, force whichForce returns nothing
    call ForceAddPlayer(whichForce, whichPlayer)
endfunction

//===========================================================================
function ForceRemovePlayerSimple takes player whichPlayer, force whichForce returns nothing
    call ForceRemovePlayer(whichForce, whichPlayer)
endfunction

//===========================================================================
// Consider each unit, one at a time, keeping a "current pick".   Once all units
// are considered, this "current pick" will be the resulting random unit.
//
// The chance of picking a given unit over the "current pick" is 1/N, where N is
// the number of units considered thusfar (including the current consideration).
//
function GroupPickRandomUnitEnum takes nothing returns nothing
    set bj_groupRandomConsidered = bj_groupRandomConsidered + 1
    if (GetRandomInt(1,bj_groupRandomConsidered) == 1) then
        set bj_groupRandomCurrentPick = GetEnumUnit()
    endif
endfunction

//===========================================================================
// Picks a random unit from a group.
//
function GroupPickRandomUnit takes group whichGroup returns unit
    set bj_groupRandomConsidered = 0
    set bj_groupRandomCurrentPick = null
    call ForGroup(whichGroup, function GroupPickRandomUnitEnum)
    return bj_groupRandomCurrentPick
endfunction

//===========================================================================
// See GroupPickRandomUnitEnum for the details of this algorithm.
//
function ForcePickRandomPlayerEnum takes nothing returns nothing
    set bj_forceRandomConsidered = bj_forceRandomConsidered + 1
    if (GetRandomInt(1,bj_forceRandomConsidered) == 1) then
        set bj_forceRandomCurrentPick = GetEnumPlayer()
    endif
endfunction

//===========================================================================
// Picks a random player from a force.
//
function ForcePickRandomPlayer takes force whichForce returns player
    set bj_forceRandomConsidered = 0
    set bj_forceRandomCurrentPick = null
    call ForForce(whichForce, function ForcePickRandomPlayerEnum)
    return bj_forceRandomCurrentPick
endfunction

//===========================================================================
function EnumUnitsSelected takes player whichPlayer, boolexpr enumFilter, code enumAction returns nothing
    local group g = CreateGroup()
    call SyncSelections()
    call GroupEnumUnitsSelected(g, whichPlayer, enumFilter)
    call ForGroup(g, enumAction)
endfunction

//===========================================================================
function EnumDestructablesInRectAll takes rect r, code actionFunc returns nothing
    call EnumDestructablesInRect(r, null, actionFunc)
endfunction

//===========================================================================
function GetUnitsInRectMatching takes rect r, boolexpr filter returns group
    local group g = CreateGroup()
    call GroupEnumUnitsInRect(g, r, filter)
    return g
endfunction

//===========================================================================
function GetUnitsInRectAll takes rect r returns group
    return GetUnitsInRectMatching(r, null)
endfunction

//===========================================================================
function GetUnitsInRectOfPlayerFilter takes nothing returns boolean
    return GetOwningPlayer(GetFilterUnit()) == bj_groupEnumOwningPlayer
endfunction

//===========================================================================
function GetUnitsInRectOfPlayer takes rect r, player whichPlayer returns group
    set bj_groupEnumOwningPlayer = whichPlayer
    return GetUnitsInRectMatching(r, Filter(function GetUnitsInRectOfPlayerFilter))
endfunction

//===========================================================================
function GetUnitsInRangeOfLocMatching takes real radius, location whichLocation, boolexpr filter returns group
    local group g = CreateGroup()
    call GroupEnumUnitsInRangeOfLoc(g, whichLocation, radius, filter)
    return g
endfunction

//===========================================================================
function GetUnitsInRangeOfLocAll takes real radius, location whichLocation returns group
    return GetUnitsInRangeOfLocMatching(radius, whichLocation, null)
endfunction

//===========================================================================
function GetUnitsOfTypeIdAllFilter takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == bj_groupEnumTypeId
endfunction

//===========================================================================
function GetUnitsOfTypeIdAll takes integer unitid returns group
    local group   result = CreateGroup()
    local group   g      = CreateGroup()
    local integer index

    set index = 0
    loop
        set bj_groupEnumTypeId = unitid
        call GroupClear(g)
        call GroupEnumUnitsOfPlayer(g, Player(index), Filter(function GetUnitsOfTypeIdAllFilter))
        call GroupAddGroup(g, result)

        set index = index + 1
        exitwhen index == bj_MAX_PLAYERS
    endloop

    return result
endfunction

//===========================================================================
function GetUnitsOfPlayerMatching takes player whichPlayer, boolexpr filter returns group
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, whichPlayer, filter)
    return g
endfunction

//===========================================================================
function GetUnitsOfPlayerAll takes player whichPlayer returns group
    return GetUnitsOfPlayerMatching(whichPlayer, null)
endfunction

//===========================================================================
function GetUnitsOfPlayerAndTypeIdFilter takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == bj_groupEnumTypeId
endfunction

//===========================================================================
function GetUnitsOfPlayerAndTypeId takes player whichPlayer, integer unitid returns group
    local group g = CreateGroup()
    set bj_groupEnumTypeId = unitid
    call GroupEnumUnitsOfPlayer(g, whichPlayer, Filter(function GetUnitsOfPlayerAndTypeIdFilter))
    return g
endfunction

//===========================================================================
function GetUnitsSelectedAll takes player whichPlayer returns group
    local group g = CreateGroup()
    call SyncSelections()
    call GroupEnumUnitsSelected(g, whichPlayer, null)
    return g
endfunction

//===========================================================================
function GetForceOfPlayer takes player whichPlayer returns force
    local force f = CreateForce()
    call ForceAddPlayer(f, whichPlayer)
    return f
endfunction

//===========================================================================
function GetPlayersAll takes nothing returns force
    local force f = CreateForce()
    call ForceEnumPlayers(f, null)
    return f
endfunction

//===========================================================================
function GetPlayersByMapControl takes mapcontrol whichControl returns force
    local force f = CreateForce()
    local integer playerIndex
    local player  indexPlayer

    set playerIndex = 0
    loop
        set indexPlayer = Player(playerIndex)
        if GetPlayerController(indexPlayer) == whichControl then
            call ForceAddPlayer(f, indexPlayer)
        endif

        set playerIndex = playerIndex + 1
        exitwhen playerIndex == bj_MAX_PLAYERS
    endloop

    return f
endfunction

//===========================================================================
function GetPlayersAllies takes player whichPlayer returns force
    local force f = CreateForce()
    call ForceEnumAllies(f, whichPlayer, null)
    return f
endfunction

//===========================================================================
function GetPlayersEnemies takes player whichPlayer returns force
    local force f = CreateForce()
    call ForceEnumEnemies(f, whichPlayer, null)
    return f
endfunction

//===========================================================================
function GetPlayersMatching takes boolexpr filter returns force
    local force f = CreateForce()
    call ForceEnumPlayers(f, filter)
    return f
endfunction

//===========================================================================
function CountUnitsInGroupEnum takes nothing returns nothing
    set bj_groupCountUnits = bj_groupCountUnits + 1
endfunction

//===========================================================================
function CountUnitsInGroup takes group g returns integer
    set bj_groupCountUnits = 0
    call ForGroup(g, function CountUnitsInGroupEnum)
    return bj_groupCountUnits
endfunction



//***************************************************************************
//*
//*  Animation Utility Functions
//*
//***************************************************************************

//===========================================================================
// This version differs from the common.j interface in that the alpha value
// is reversed so as to be displayed as transparency, and all four parameters
// are treated as percentages rather than bytes.
//
function SetUnitVertexColorBJ takes unit whichUnit, real red, real green, real blue, real transparency returns nothing
    call SetUnitVertexColor(whichUnit, PercentTo255(red), PercentTo255(green), PercentTo255(blue), PercentTo255(100.0-transparency))
endfunction

//===========================================================================
function UnitAddIndicatorBJ takes unit whichUnit, real red, real green, real blue, real transparency returns nothing
    call UnitAddIndicator(whichUnit, PercentTo255(red), PercentTo255(green), PercentTo255(blue), PercentTo255(100.0-transparency))
endfunction

//===========================================================================
function StartPortraitTalkBJ takes integer sequence, real duration returns nothing
    call StartPortraitTalk(duration, sequence)
endfunction

//===========================================================================
// Sets a unit's facing to point directly at a location.
//
function SetUnitFacingToFaceLocTimed takes unit whichUnit, location target, real duration returns nothing
    call SetUnitFacingTimed(whichUnit, AngleBetweenPoints(GetUnitLoc(whichUnit), target), duration)
endfunction

//===========================================================================
// Sets a unit's facing to point directly at a location.
//
function SetUnitFacingToFaceUnitTimed takes unit whichUnit, unit target, real duration returns nothing
    call SetUnitFacingToFaceLocTimed(whichUnit, GetUnitLoc(target), duration)
endfunction

//===========================================================================
// %%% Obsoleted
// Sets the unit's facing to point directly at a location.
//
function SetUnitFacingToFaceLoc takes unit whichUnit, location target returns nothing
    call SetUnitFacing(whichUnit, AngleBetweenPoints(GetUnitLoc(whichUnit), target))
endfunction

//===========================================================================
// %%% Obsoleted
// Sets the unit's facing to point directly at another unit.
//
function SetUnitFacingToFaceUnit takes unit whichUnit, unit target returns nothing
    call SetUnitFacingToFaceLoc(whichUnit, GetUnitLoc(target))
endfunction



//***************************************************************************
//*
//*  Alliance Utility Functions
//*
//***************************************************************************

//===========================================================================
function SetPlayerAllianceBJ takes player sourcePlayer, alliancetype whichAllianceSetting, boolean value, player otherPlayer returns nothing
    call SetPlayerAlliance(sourcePlayer, otherPlayer, whichAllianceSetting, value)
endfunction

//===========================================================================
function SetPlayerAllianceStateBJ takes player sourcePlayer, player otherPlayer, integer allianceState returns nothing
    if allianceState == bj_ALLIANCE_UNALLIED then
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_PASSIVE, false)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION, false)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_CONTROL, false)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    elseif allianceState == bj_ALLIANCE_UNALLIED_VISION then
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_PASSIVE, false)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION, true)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_CONTROL, false)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    elseif allianceState == bj_ALLIANCE_ALLIED then
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_PASSIVE, true)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION, false)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_CONTROL, false)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    elseif allianceState == bj_ALLIANCE_ALLIED_VISION then
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_PASSIVE, true)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION, true)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_CONTROL, false)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    elseif allianceState == bj_ALLIANCE_ALLIED_UNITS then
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_PASSIVE, true)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION, true)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_CONTROL, true)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    elseif allianceState == bj_ALLIANCE_ALLIED_ADVUNITS then
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_PASSIVE, true)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION, true)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_CONTROL, true)
        call SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL, true)
    endif
endfunction

//===========================================================================
// Test to see if two players are co-allied (allied with each other).
//
function PlayersAreCoAllied takes player playerA, player playerB returns boolean
    // Players are considered to be allied with themselves.
    if (playerA == playerB) then
        return true
    endif

    // Co-allies are both allied with each other.
    if GetPlayerAlliance(playerA, playerB, ALLIANCE_PASSIVE) then
        if GetPlayerAlliance(playerB, playerA, ALLIANCE_PASSIVE) then
            return true
        endif
    endif
    return false
endfunction

//===========================================================================
// Force (whichPlayer) to share vision and advanced unit control with all of his/her allies.
//
function ShareEverythingWithTeam takes player whichPlayer returns nothing
    local integer playerIndex
    local player  indexPlayer

    set playerIndex = 0
    loop
        set indexPlayer = Player(playerIndex)
        if (PlayersAreCoAllied(whichPlayer, indexPlayer) and whichPlayer != indexPlayer) then
            call SetPlayerAlliance(whichPlayer, indexPlayer, ALLIANCE_SHARED_VISION, true)
            call SetPlayerAlliance(whichPlayer, indexPlayer, ALLIANCE_SHARED_CONTROL, true)
            call SetPlayerAlliance(whichPlayer, indexPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL, true)
        endif

        set playerIndex = playerIndex + 1
        exitwhen playerIndex == bj_MAX_PLAYERS
    endloop
endfunction

//===========================================================================
// Creates a 'Neutral Victim' player slot.  This slot is passive towards all
// other players, but all other players are aggressive towards him/her.
// 
function ConfigureNeutralVictim takes nothing returns nothing
    local integer index
    local player indexPlayer
    local player neutralVictim = Player(bj_PLAYER_NEUTRAL_VICTIM)

    set index = 0
    loop
        set indexPlayer = Player(index)

        call SetPlayerAlliance(neutralVictim, indexPlayer, ALLIANCE_PASSIVE, true)
        call SetPlayerAlliance(indexPlayer, neutralVictim, ALLIANCE_PASSIVE, false)

        set index = index + 1
        exitwhen index == bj_MAX_PLAYERS
    endloop

    // Neutral Victim and Neutral Aggressive should not fight each other.
    set indexPlayer = Player(PLAYER_NEUTRAL_AGGRESSIVE)
    call SetPlayerAlliance(neutralVictim, indexPlayer, ALLIANCE_PASSIVE, true)
    call SetPlayerAlliance(indexPlayer, neutralVictim, ALLIANCE_PASSIVE, true)

    // Neutral Victim does not give bounties.
    call SetPlayerState(neutralVictim, PLAYER_STATE_GIVES_BOUNTY, 0)
endfunction

//===========================================================================
function MakeUnitsPassiveForPlayerEnum takes nothing returns nothing
    call SetUnitOwner(GetEnumUnit(), Player(bj_PLAYER_NEUTRAL_VICTIM), false)
endfunction

//===========================================================================
// Change ownership for every unit of (whichPlayer)'s team to neutral passive.
//
function MakeUnitsPassiveForPlayer takes player whichPlayer returns nothing
    local group   playerUnits = CreateGroup()

    call GroupEnumUnitsOfPlayer(playerUnits, whichPlayer, null)
    call ForGroup(playerUnits, function MakeUnitsPassiveForPlayerEnum)
endfunction

//===========================================================================
// Change ownership for every unit of (whichPlayer)'s team to neutral passive.
//
function MakeUnitsPassiveForTeam takes player whichPlayer returns nothing
    local integer playerIndex
    local player  indexPlayer

    set playerIndex = 0
    loop
        set indexPlayer = Player(playerIndex)
        if PlayersAreCoAllied(whichPlayer, indexPlayer) then
            call MakeUnitsPassiveForPlayer(indexPlayer)
        endif

        set playerIndex = playerIndex + 1
        exitwhen playerIndex == bj_MAX_PLAYERS
    endloop
endfunction

//===========================================================================
// Determine whether or not victory/defeat is disabled via cheat codes.
//
function AllowVictoryDefeat takes playergameresult gameResult returns boolean
    if (gameResult == PLAYER_GAME_RESULT_VICTORY) then
        return not IsNoVictoryCheat()
    endif
    if (gameResult == PLAYER_GAME_RESULT_DEFEAT) then
        return not IsNoDefeatCheat()
    endif
    return true
endfunction

//===========================================================================
function RemovePlayerBJ takes player whichPlayer, playergameresult gameResult, string message returns nothing
    if AllowVictoryDefeat(gameResult) then
        call RemovePlayer(whichPlayer, gameResult, message)
    endif
endfunction

//===========================================================================
function ChangeLevelBJ takes string nextLevelScript, playergameresult gameResult, string message returns nothing
    if AllowVictoryDefeat(gameResult) then
        call ChangeLevel(nextLevelScript, gameResult, message)
    endif
endfunction

//===========================================================================
// Rescues a unit for a player.  This performs the default rescue behavior,
// including a rescue sound, flashing selection circle, ownership change,
// and optionally a unit color change.
//
function RescueUnitBJ takes unit whichUnit, player rescuer, boolean changeColor returns nothing
    // %%% To do - Play a "dah-ding" sound.
    call SetUnitOwner(whichUnit, rescuer, changeColor)
    call UnitAddIndicator(whichUnit, 0, 255, 0, 255)
endfunction

//===========================================================================
function MakeUnitRescuableToForceBJEnum takes nothing returns nothing
    call SetUnitRescuable(bj_makeUnitRescuableUnit, GetEnumPlayer(), bj_makeUnitRescuableFlag)
endfunction

//===========================================================================
function MakeUnitRescuableToForceBJ takes unit whichUnit, boolean isRescuable, force whichForce returns nothing
    // Flag the unit as rescuable/unrescuable for the appropriate players.
    set bj_makeUnitRescuableUnit = whichUnit
    set bj_makeUnitRescuableFlag = isRescuable
    call ForForce(whichForce, function MakeUnitRescuableToForceBJEnum)
endfunction

//===========================================================================
function AllowPlayerToRescueBJ takes boolean allow, player rescuer, player rescuee returns nothing
    call SetPlayerAlliance(rescuee, rescuer, ALLIANCE_RESCUABLE, allow)
endfunction



//***************************************************************************
//*
//*  Cinematic Utility Functions
//*
//***************************************************************************

//===========================================================================
function GetTransmissionDuration takes sound soundHandle, integer timeType, real timeVal returns real
    local real duration

    if (timeType == bj_TIMETYPE_ADD) then
        set duration = GetSoundDurationBJ(soundHandle) + timeVal
    elseif (timeType == bj_TIMETYPE_SET) then
        set duration = timeVal
    else
        // If timeType is unknown, ignore timeVal
        set duration = GetSoundDurationBJ(soundHandle)
    endif

    // Make sure we have a non-negative duration.
    if (duration < 0) then
        set duration = 0
    endif
    return duration
endfunction

//===========================================================================
// Display a text message to a Player Group with an accompanying sound,
// portrait, speech indicator, and all that good stuff.
//   - Query duration of sound
//   - Play sound
//   - Display text message for duration
//   - Ping the minimap
//   - Display a speech indicator for the unit
//   - Set a camera spacebar-point
//
// To do:
//   - Dim music volume for duration  (note - may need to create a timer w/callback func to revert music volume)
//   - Display portrait for duration
//   - Animate portrait for duration
//
function TransmissionFromUnitBJ takes force toForce, unit whichUnit, sound soundHandle, string message, integer timeType, real timeVal, boolean wait returns nothing
    local real x = GetUnitX(whichUnit)
    local real y = GetUnitY(whichUnit)
    local real duration = GetTransmissionDuration(soundHandle, timeType, timeVal)

    if (IsPlayerInForce(GetLocalPlayer(), toForce)) then
        // Use only local code (no net traffic) within this block to avoid desyncs.

        call PlaySoundBJ(soundHandle)
        // %%% Display portrait for duration (unitId, duration)
        //call StartPortraitTalk(duration, 1)
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, duration, message)
        call PingMinimap(x, y, bj_TRANSMISSION_PING_TIME)
        call UnitAddIndicator(whichUnit, bj_TRANSMISSION_IND_RED, bj_TRANSMISSION_IND_BLUE, bj_TRANSMISSION_IND_GREEN, bj_TRANSMISSION_IND_ALPHA)
        call SetCameraQuickPosition(x, y)
    endif

    if wait and (duration > 0) then
        call TriggerSleepAction(duration)
    endif
endfunction

//===========================================================================
// This operates like TransmissionFromUnitBJ, but for a unit type rather
// than a unit instance.  As such, no speech indicator is employed.
//
function TransmissionFromUnitTypeBJ takes force toForce, integer unitId, location loc, sound soundHandle, string message, integer timeType, real timeVal, boolean wait returns nothing
    local real x = GetLocationX(loc)
    local real y = GetLocationY(loc)
    local real duration = GetTransmissionDuration(soundHandle, timeType, timeVal)

    if (IsPlayerInForce(GetLocalPlayer(), toForce)) then
        // Use only local code (no net traffic) within this block to avoid desyncs.

        call PlaySoundBJ(soundHandle)
        // %%% Display portrait for duration (unitId, duration)
        //call StartPortraitTalk(duration, 1)
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, duration, message)
        call PingMinimap(x, y, bj_TRANSMISSION_PING_TIME)
        call SetCameraQuickPosition(x, y)
    endif

    if wait and (duration > 0) then
        call TriggerSleepAction(duration)
    endif
endfunction

//===========================================================================
// Makes many common UI settings changes at once, for use when beginning and
// ending cinematic sequences.  Note that some affects apply to all players,
// such as game speed.  This is unavoidable.
//   - Hide interface UI (letterbox mode)
//   - Disable user control
//   - Disable occlusion
//   - Set game speed (for all players)
//   - Lock game speed (for all players)
//   - Disable Black Mask (for all players)
//   - Disable Fog of War (for all players)
//
// To do:
//   - Hide aura graphics
//
function CinematicModeBJ takes boolean cineMode, force forForce returns nothing
    if (cineMode) then
        // Save the UI state so that we can restore it later.
        if (not bj_cineModeAlreadyIn) then
            set bj_cineModeAlreadyIn = true
            set bj_cineModePriorSpeed = GetGameSpeed()
            set bj_cineModePriorFogSetting = IsFogEnabled()
            set bj_cineModePriorMaskSetting = IsFogMaskEnabled()
            set bj_cineModePriorSpeedLocked = IsMapFlagSet(MAP_LOCK_SPEED)
        endif

        // Perform local changes
        if (IsPlayerInForce(GetLocalPlayer(), forForce)) then
            // Use only local code (no net traffic) within this block to avoid desyncs.
            call ShowInterface(false, bj_CINEMODE_INTERFACEFADE)
            call EnableUserControl(false)
            call EnableOcclusion(false)
        endif

        // Perform global changes
        call SetGameSpeed(bj_CINEMODE_GAMESPEED)
        call SetMapFlag(MAP_LOCK_SPEED, true)
        call FogMaskEnable(false)
        call FogEnable(false)
    else
        set bj_cineModeAlreadyIn = false

        // Perform local changes
        if (IsPlayerInForce(GetLocalPlayer(), forForce)) then
            // Use only local code (no net traffic) within this block to avoid desyncs.
            call ShowInterface(true, bj_CINEMODE_INTERFACEFADE)
            call EnableUserControl(true)
            call EnableOcclusion(true)
        endif

        // Perform global changes
        call SetMapFlag(MAP_LOCK_SPEED, bj_cineModePriorSpeedLocked)
        call SetGameSpeed(bj_cineModePriorSpeed)
        call FogMaskEnable(bj_cineModePriorMaskSetting)
        call FogEnable(bj_cineModePriorFogSetting)
    endif
endfunction



//***************************************************************************
//*
//*  Miscellaneous Utility Functions
//*
//***************************************************************************

//===========================================================================
function GetItemLoc takes item whichItem returns location
    return Location(GetItemX(whichItem), GetItemY(whichItem))
endfunction

//===========================================================================
function GetDestructableLoc takes destructable whichDestructable returns location
    return Location(GetDestructableX(whichDestructable), GetDestructableY(whichDestructable))
endfunction

//===========================================================================
function GetPlayerStartLocationX takes player whichPlayer returns real
    return GetStartLocationX(GetPlayerStartLocation(whichPlayer))
endfunction

//===========================================================================
function GetPlayerStartLocationY takes player whichPlayer returns real
    return GetStartLocationY(GetPlayerStartLocation(whichPlayer))
endfunction

//===========================================================================
function GetPlayerStartLocationLoc takes player whichPlayer returns location
    return GetStartLocationLoc(GetPlayerStartLocation(whichPlayer))
endfunction

//===========================================================================
function GetRectCenter takes rect whichRect returns location
    return Location(GetRectCenterX(whichRect), GetRectCenterY(whichRect))
endfunction

//===========================================================================
function GetCameraBoundsMapRect takes nothing returns rect
    return Rect(GetCameraBoundMinX(), GetCameraBoundMinY(), GetCameraBoundMaxX(), GetCameraBoundMaxY())
endfunction

//===========================================================================
function GetPlayableMapRect takes nothing returns rect
    return Rect(GetCameraBoundMinX()-bj_CELLWIDTH*4, GetCameraBoundMinY()-bj_CELLWIDTH*2, GetCameraBoundMaxX()+bj_CELLWIDTH*4, GetCameraBoundMaxY()+bj_CELLWIDTH*2)
endfunction

//===========================================================================
function GetEntireMapRect takes nothing returns rect
    return Rect(GetCameraBoundMinX()-bj_CELLWIDTH*10, GetCameraBoundMinY()-bj_CELLWIDTH*10, GetCameraBoundMaxX()+bj_CELLWIDTH*10, GetCameraBoundMaxY()+bj_CELLWIDTH*6)
endfunction

//===========================================================================
function IsPlayerSlotState takes player whichPlayer, playerslotstate whichState returns boolean
    return GetPlayerSlotState(whichPlayer) == whichState
endfunction

//===========================================================================
function GetFadeFromSeconds takes real seconds returns integer
    if (seconds != 0) then
        return 128 / seconds
    else
        return 10000
    endif
endfunction

//===========================================================================
function AdjustPlayerState takes player whichPlayer, playerstate whichPlayerState, integer delta returns nothing
    call SetPlayerState(whichPlayer, whichPlayerState, GetPlayerState(whichPlayer, whichPlayerState) + delta)
endfunction

//===========================================================================
function AdjustPlayerStateBJ takes integer delta, player whichPlayer, playerstate whichPlayerState returns nothing
    call SetPlayerState(whichPlayer, whichPlayerState, GetPlayerState(whichPlayer, whichPlayerState) + delta)
endfunction

//===========================================================================
function AddResourceAmountBJ takes integer delta, unit whichUnit returns nothing
    call AddResourceAmount(whichUnit, delta)
endfunction

//===========================================================================
function GetConvertedPlayerId takes player whichPlayer returns integer
    return GetPlayerId(whichPlayer) + 1
endfunction

//===========================================================================
function ConvertedPlayer takes integer convertedPlayerId returns player
    return Player(convertedPlayerId - 1)
endfunction

//===========================================================================
function OffsetLocation takes location loc, real dx, real dy returns location
    return Location(GetLocationX(loc) + dx, GetLocationY(loc) + dy)
endfunction

//===========================================================================
function RectContainsCoords takes rect r, real x, real y returns boolean
    return (GetRectMinX(r) <= x) and (x <= GetRectMaxX(r)) and (GetRectMinY(r) <= y) and (y <= GetRectMaxY(r))
endfunction

//===========================================================================
function RectContainsLoc takes rect r, location loc returns boolean
    return RectContainsCoords(r, GetLocationX(loc), GetLocationY(loc))
endfunction

//===========================================================================
function RectContainsUnit takes rect r, unit whichUnit returns boolean
    return RectContainsCoords(r, GetUnitX(whichUnit), GetUnitY(whichUnit))
endfunction

//===========================================================================
function GetRectWidthBJ takes rect r returns real
    return GetRectMaxX(r) - GetRectMinX(r)
endfunction

//===========================================================================
function GetRectHeightBJ takes rect r returns real
    return GetRectMaxY(r) - GetRectMinY(r)
endfunction

//===========================================================================
function SetPlayerTechResearchedSwap takes integer techid, integer levels, player whichPlayer returns integer
    return SetPlayerTechResearched(whichPlayer, techid, levels)
endfunction

//===========================================================================
function SetPlayerTechMaxAllowedSwap takes integer techid, integer maximum, player whichPlayer returns integer
    return SetPlayerTechMaxAllowed(whichPlayer, techid, maximum)
endfunction

//===========================================================================
function GetPlayerTechCountSimple takes integer techid, player whichPlayer returns integer
    return GetPlayerTechCount(whichPlayer, techid, true)
endfunction

//===========================================================================
function GetPlayerTechMaxAllowedSwap takes integer techid, player whichPlayer returns integer
    return GetPlayerTechMaxAllowed(whichPlayer, techid)
endfunction

//===========================================================================
// Replaces a gold mine with a blighted gold mine for the given player.
//
function BlightGoldMineForPlayer takes unit goldMine, player whichPlayer returns unit
    local real    mineX
    local real    mineY
    local integer mineGold
    local unit    newMine

    // Make sure we're replacing a Gold Mine and not some other type of unit.
    if GetUnitTypeId(goldMine) != 'ngol' then
        return null
    endif

    // Save the Gold Mine's properties and remove it.
    set mineX    = GetUnitX(goldMine)
    set mineY    = GetUnitY(goldMine)
    set mineGold = GetResourceAmount(goldMine)
    call RemoveUnit(goldMine)

    // Create a Haunted Gold Mine to replace the Gold Mine.
    set newMine = CreateBlightedGoldmine(whichPlayer, mineX, mineY, bj_UNIT_FACING)
    call SetResourceAmount(newMine, mineGold)
    return newMine
endfunction

//===========================================================================
function SetPlayerColorBJEnum takes nothing returns nothing
    call SetUnitColor(GetEnumUnit(), bj_setPlayerTargetColor)
endfunction

//===========================================================================
function SetPlayerColorBJ takes player whichPlayer, playercolor color, boolean changeExisting returns nothing
    local group g

    call SetPlayerColor(whichPlayer, color)
    if changeExisting then
        set bj_setPlayerTargetColor = color
        set g = CreateGroup()
        call GroupEnumUnitsOfPlayer(g, whichPlayer, null)
        call ForGroup(g, function SetPlayerColorBJEnum)
    endif
endfunction

//===========================================================================
function SetPlayerUnitAvailableBJ takes integer unitId, boolean allowed, player whichPlayer returns nothing
    if allowed then
        call SetPlayerTechMaxAllowed(whichPlayer, unitId, 10000)
    else
        call SetPlayerTechMaxAllowed(whichPlayer, unitId, 0)
    endif
endfunction

//===========================================================================
function LockGameSpeedBJ takes nothing returns nothing
    call SetMapFlag(MAP_LOCK_SPEED, true)
endfunction

//===========================================================================
function UnlockGameSpeedBJ takes nothing returns nothing
    call SetMapFlag(MAP_LOCK_SPEED, false)
endfunction

//===========================================================================
// Two distinct trigger actions can't share the same function name, so this
// dummy function simply mimics the behavior of an existing call.
//
function IssueTargetDestructableOrder takes unit whichUnit, string order, widget targetWidget returns boolean
    return IssueTargetOrder(whichUnit, order, targetWidget)
endfunction

//===========================================================================
// Two distinct trigger actions can't share the same function name, so this
// dummy function simply mimics the behavior of an existing call.
//
function GroupTargetDestructableOrder takes group whichGroup, string order, widget targetWidget returns boolean
    return GroupTargetOrder(whichGroup, order, targetWidget)
endfunction

//===========================================================================
function GetDyingDestructable takes nothing returns destructable
    return GetTriggerWidget()
endfunction

//===========================================================================
function SetBlightRectBJ takes boolean addBlight, player whichPlayer, rect r returns nothing
    call SetBlightRect(whichPlayer, r, addBlight)
endfunction

//===========================================================================
function SetBlightRadiusLocBJ takes boolean addBlight, player whichPlayer, location loc, real radius returns nothing
    call SetBlightLoc(whichPlayer, loc, radius, addBlight)
endfunction



//***************************************************************************
//*
//*  Melee Template Visibility Settings
//*
//***************************************************************************

//===========================================================================
function MeleeVisibilityDay takes nothing returns nothing
    call StartSound(bj_dawnSound)
endfunction

//===========================================================================
function MeleeVisibilityNight takes nothing returns nothing
    call StartSound(bj_duskSound)
endfunction

//===========================================================================
function MeleeStartingVisibility takes nothing returns nothing
    // Start by setting the ToD.
    call SetFloatGameState(GAME_STATE_TIME_OF_DAY, bj_MELEE_STARTING_TOD)

    call FogMaskEnable(true)
    call FogEnable(true)

    // Create sounds to be played at dawn and dusk.
    set bj_dawnSound = CreateSoundFromLabel("RoosterSound", false, false, false, 10000, 10000)
    set bj_duskSound = CreateSoundFromLabel("WolfSound", false, false, false, 10000, 10000)

    // Set up triggers to respond to dawn and dusk.
    set bj_meleeVisibilityDay   = CreateTrigger()
    set bj_meleeVisibilityNight = CreateTrigger()
    call TriggerRegisterGameStateEvent(bj_meleeVisibilityDay,   GAME_STATE_TIME_OF_DAY, EQUAL,  6.00)
    call TriggerRegisterGameStateEvent(bj_meleeVisibilityNight, GAME_STATE_TIME_OF_DAY, EQUAL, 18.00)
    call TriggerAddAction(bj_meleeVisibilityDay,   function MeleeVisibilityDay)
    call TriggerAddAction(bj_meleeVisibilityNight, function MeleeVisibilityNight)
endfunction



//***************************************************************************
//*
//*  Melee Template Starting Resources
//*
//***************************************************************************

//===========================================================================
function MeleeStartingResources takes nothing returns nothing
    local integer index
    local player  indexPlayer

    // Set each player's starting resources.
    set index = 0
    loop
        set indexPlayer = Player(index)
        if (GetPlayerSlotState(indexPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            call SetPlayerState(indexPlayer, PLAYER_STATE_RESOURCE_GOLD, bj_MELEE_STARTING_GOLD)
            call SetPlayerState(indexPlayer, PLAYER_STATE_RESOURCE_LUMBER, bj_MELEE_STARTING_LUMBER)
        endif

        set index = index + 1
        exitwhen index == bj_MAX_PLAYERS
    endloop
endfunction



//***************************************************************************
//*
//*  Melee Template Clear Start Locations
//*
//***************************************************************************

//===========================================================================
function MeleeClearExcessUnit takes nothing returns nothing
    local unit theUnit = GetEnumUnit()
    if (GetOwningPlayer(theUnit) == bj_meleeClearUnitsPlayer) then
        call RemoveUnit(theUnit)
    endif
endfunction

//===========================================================================
function MeleeClearNearbyUnits takes real x, real y, real range returns nothing
    local group nearbyUnits
    
    set bj_meleeClearUnitsPlayer = Player(PLAYER_NEUTRAL_AGGRESSIVE)
    set nearbyUnits = CreateGroup()
    call GroupEnumUnitsInRange(nearbyUnits, x, y, range, null)
    call ForGroup(nearbyUnits, function MeleeClearExcessUnit)
endfunction

//===========================================================================
function MeleeClearExcessUnits takes nothing returns nothing
    local integer index
    local real    locX
    local real    locY
    local player  indexPlayer
    //local group   g

    set index = 0
    loop
        set indexPlayer = Player(index)

        // Remove all units for player, regardless of slot state.
        // Disabled.  We now flag maps with preplaced player units as non-melee.
        //
        //set bj_meleeClearUnitsPlayer = indexPlayer
        //set g = CreateGroup()
        //call GroupEnumUnitsInRect(g, GetEntireMapRect(), null)
        //call ForGroup(g, function MeleeClearExcessUnit)

        // If the player slot is being used, clear any nearby creeps.
        if (GetPlayerSlotState(indexPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set locX = GetStartLocationX(GetPlayerStartLocation(indexPlayer))
            set locY = GetStartLocationY(GetPlayerStartLocation(indexPlayer))

            call MeleeClearNearbyUnits(locX, locY, 1024)
        endif

        set index = index + 1
        exitwhen index == bj_MAX_PLAYERS
    endloop
endfunction



//***************************************************************************
//*
//*  Melee Template Starting Units
//*
//***************************************************************************

//===========================================================================
function MeleeEnumFindNearestMine takes nothing returns nothing
    local unit enumUnit = GetEnumUnit()
    local real dist

    if (GetUnitTypeId(enumUnit) == 'ngol') then
        set dist = DistanceBetweenPoints(GetUnitLoc(enumUnit), bj_meleeNearestMineToLoc)

        // If this is our first mine, or the closest thusfar, use it instead.
        if (bj_meleeNearestMineDist < 0) or (dist < bj_meleeNearestMineDist) then
            set bj_meleeNearestMine = enumUnit
            set bj_meleeNearestMineDist = dist
        endif
    endif
endfunction

//===========================================================================
function MeleeFindNearestMine takes location src, real range returns unit
    local group nearbyMines
    
    set bj_meleeNearestMine = null
    set bj_meleeNearestMineDist = -1
    set bj_meleeNearestMineToLoc = src

    set nearbyMines = CreateGroup()
    call GroupEnumUnitsInRangeOfLoc(nearbyMines, src, range, null)
    call ForGroup(nearbyMines, function MeleeEnumFindNearestMine)

    return bj_meleeNearestMine
endfunction

//===========================================================================
function MeleeRandomHeroLoc takes player p, integer id1, integer id2, integer id3, location loc returns nothing
	local integer roll = GetRandomInt(1,3)
    local integer pick

    if roll == 1 then
        set pick = id1
    elseif roll == 2 then
        set pick = id2
    else
        set pick = id3
    endif

    call CreateUnitAtLoc(p, pick, loc, bj_UNIT_FACING)
endfunction

//===========================================================================
// Returns a location which is (distance) away from (src) in the direction of (targ).
//
function MeleeGetProjectedLoc takes location src, location targ, real distance, real deltaAngle returns location
    local real srcX = GetLocationX(src)
    local real srcY = GetLocationY(src)
    local real direction = Atan2(GetLocationY(targ) - srcY, GetLocationX(targ) - srcX) + deltaAngle
    return Location(srcX + distance * Cos(direction), srcY + distance * Sin(direction))
endfunction

//===========================================================================
function MeleeGetNearestValueWithin takes real val, real minVal, real maxVal returns real
    if (val < minVal) then
        return minVal
    elseif (val > maxVal) then
        return maxVal
    else
        return val
    endif
endfunction

//===========================================================================
function MeleeGetLocWithinRect takes location src, rect r returns location
    local real withinX = MeleeGetNearestValueWithin(GetLocationX(src), GetRectMinX(r), GetRectMaxX(r))
    local real withinY = MeleeGetNearestValueWithin(GetLocationY(src), GetRectMinY(r), GetRectMaxY(r))
    return Location(withinX, withinY)
endfunction

//===========================================================================
function MeleeGetRectFromCircle takes location center, real radius returns rect
    local real centerX = GetLocationX(center)
    local real centerY = GetLocationY(center)
    return Rect(centerX - radius, centerY - radius, centerX + radius, centerY + radius)
endfunction

//===========================================================================
// Starting Units for Human Players
//   - 1 Town Hall, placed at start location
//   - 4 Peasants, placed between start location and nearest gold mine
//
function MeleeStartingUnitsHuman takes player whichPlayer, location startLoc returns nothing
    local boolean  useRandomHero = IsMapFlagSet(MAP_RANDOM_HERO)
    local real     unitSpacing   = 64.00
    local unit     nearestMine
    local location nearMineLoc
    local location heroLoc
    local real     peonX
    local real     peonY

    set nearestMine = MeleeFindNearestMine(startLoc, bj_MELEE_MINE_SEARCH_RADIUS)
    if (nearestMine != null) then
        // Spawn Town Hall at the start location.
        call CreateUnitAtLoc(whichPlayer, 'htow', startLoc, bj_UNIT_FACING)
        
        // Spawn Peasants near the mine.
        set nearMineLoc = MeleeGetProjectedLoc(GetUnitLoc(nearestMine), startLoc, 288, 0)
        set peonX = GetLocationX(nearMineLoc)
        set peonY = GetLocationY(nearMineLoc)
        call CreateUnit(whichPlayer, 'hpea', peonX + 0.50 * unitSpacing, peonY + 0.50 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'hpea', peonX + 0.50 * unitSpacing, peonY - 0.50 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'hpea', peonX - 0.50 * unitSpacing, peonY + 0.50 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'hpea', peonX - 0.50 * unitSpacing, peonY - 0.50 * unitSpacing, bj_UNIT_FACING)

        // Set random hero spawn point to be off to the side of the start location.
        set heroLoc = MeleeGetProjectedLoc(GetUnitLoc(nearestMine), startLoc, 384, 45)
    else
        // Spawn Town Hall at the start location.
        call CreateUnitAtLoc(whichPlayer, 'htow', startLoc, bj_UNIT_FACING)
        
        // Spawn Peasants directly south of the town hall.
        set peonX = GetLocationX(startLoc)
        set peonY = GetLocationY(startLoc) - 224.00
        call CreateUnit(whichPlayer, 'hpea', peonX + 1.50 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'hpea', peonX + 0.50 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'hpea', peonX - 0.50 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'hpea', peonX - 1.50 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)

        // Set random hero spawn point to be just south of the start location.
        set heroLoc = Location(peonX, peonY - 2.00 * unitSpacing)
    endif

    // If the "Random Hero" option is set, start the player with a random hero.
    // Otherwise, give them a "free hero" token.
    if useRandomHero then
        call MeleeRandomHeroLoc(whichPlayer, 'Hamg', 'Hmkg', 'Hpal', heroLoc)
    else
        call SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_HERO_TOKENS, bj_MELEE_STARTING_HERO_TOKENS)
    endif

    // Center the camera on the initial Peasants.
    call SetCameraPositionForPlayer(whichPlayer, peonX, peonY)
    call SetCameraQuickPositionForPlayer(whichPlayer, peonX, peonY)
endfunction

//===========================================================================
// Starting Units for Orc Players
//   - 1 Great Hall, placed at start location
//   - 4 Peons, placed between start location and nearest gold mine
//
function MeleeStartingUnitsOrc takes player whichPlayer, location startLoc returns nothing
    local boolean  useRandomHero = IsMapFlagSet(MAP_RANDOM_HERO)
    local real     unitSpacing   = 64.00
    local unit     nearestMine
    local location nearMineLoc
    local location heroLoc
    local real     peonX
    local real     peonY

    set nearestMine = MeleeFindNearestMine(startLoc, bj_MELEE_MINE_SEARCH_RADIUS)
    if (nearestMine != null) then
        // Spawn Great Hall at the start location.
        call CreateUnitAtLoc(whichPlayer, 'ogre', startLoc, bj_UNIT_FACING)
        
        // Spawn Peons near the mine.
        set nearMineLoc = MeleeGetProjectedLoc(GetUnitLoc(nearestMine), startLoc, 288, 0)
        set peonX = GetLocationX(nearMineLoc)
        set peonY = GetLocationY(nearMineLoc)
        call CreateUnit(whichPlayer, 'opeo', peonX + 0.60 * unitSpacing, peonY + 0.60 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'opeo', peonX + 0.60 * unitSpacing, peonY - 0.60 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'opeo', peonX - 0.60 * unitSpacing, peonY + 0.60 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'opeo', peonX - 0.60 * unitSpacing, peonY - 0.60 * unitSpacing, bj_UNIT_FACING)

        // Set random hero spawn point to be off to the side of the start location.
        set heroLoc = MeleeGetProjectedLoc(GetUnitLoc(nearestMine), startLoc, 384, 45)
    else
        // Spawn Great Hall at the start location.
        call CreateUnitAtLoc(whichPlayer, 'ogre', startLoc, bj_UNIT_FACING)
        
        // Spawn Peons directly south of the town hall.
        set peonX = GetLocationX(startLoc)
        set peonY = GetLocationY(startLoc) - 224.00
        call CreateUnit(whichPlayer, 'opeo', peonX - 1.50 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'opeo', peonX - 0.50 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'opeo', peonX + 0.50 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'opeo', peonX + 1.50 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)

        // Set random hero spawn point to be just south of the start location.
        set heroLoc = Location(peonX, peonY - 2.00 * unitSpacing)
    endif

    // If the "Random Hero" option is set, start the player with a random hero.
    // Otherwise, give them a "free hero" token.
    if useRandomHero then
        call MeleeRandomHeroLoc(whichPlayer, 'Obla', 'Ofar', 'Otch', heroLoc)
    else
        call SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_HERO_TOKENS, bj_MELEE_STARTING_HERO_TOKENS)
    endif

    // Center the camera on the initial Peons.
    call SetCameraPositionForPlayer(whichPlayer, peonX, peonY)
    call SetCameraQuickPositionForPlayer(whichPlayer, peonX, peonY)
endfunction

//===========================================================================
// Starting Units for Undead Players
//   - 1 Necropolis, placed at start location
//   - 1 Blighted Gold Mine, placed on nearest gold mine %%% TBD
//   - 4 Acolytes, placed between start location and nearest gold mine
//   - 1 Ghoul, placed below start location
//   - Blight, centered on nearest gold mine, spread across a "large area" %%% TBD
//
function MeleeStartingUnitsUndead takes player whichPlayer, location startLoc returns nothing
    local boolean  useRandomHero = IsMapFlagSet(MAP_RANDOM_HERO)
    local real     unitSpacing   = 64.00
    local unit     nearestMine
    local location nearMineLoc
    local location nearTownLoc
    local location heroLoc
    local real     peonX
    local real     peonY
    local real     ghoulX
    local real     ghoulY

    set nearestMine = MeleeFindNearestMine(startLoc, bj_MELEE_MINE_SEARCH_RADIUS)
    if (nearestMine != null) then
        // Spawn Necropolis at the start location.
        call CreateUnitAtLoc(whichPlayer, 'unpl', startLoc, bj_UNIT_FACING)
        
        // Replace the nearest gold mine with a blighted version.
        set nearestMine = BlightGoldMineForPlayer(nearestMine, whichPlayer)

        // Spawn Ghoul near the Necropolis.
        set nearTownLoc = MeleeGetProjectedLoc(startLoc, GetUnitLoc(nearestMine), 288, 0)
        set ghoulX = GetLocationX(nearTownLoc)
        set ghoulY = GetLocationY(nearTownLoc)
        call CreateUnit(whichPlayer, 'ugho', ghoulX + 0.00 * unitSpacing, ghoulY + 0.00 * unitSpacing, bj_UNIT_FACING)

        // Spawn Acolytes near the mine.
        set nearMineLoc = MeleeGetProjectedLoc(GetUnitLoc(nearestMine), startLoc, 288, 0)
        set peonX = GetLocationX(nearMineLoc)
        set peonY = GetLocationY(nearMineLoc)
        call CreateUnit(whichPlayer, 'uaco', peonX + 0.60 * unitSpacing, peonY + 0.60 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'uaco', peonX + 0.60 * unitSpacing, peonY - 0.60 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'uaco', peonX - 0.60 * unitSpacing, peonY + 0.60 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'uaco', peonX - 0.60 * unitSpacing, peonY - 0.60 * unitSpacing, bj_UNIT_FACING)

        // Create a patch of blight around the gold mine.
        call SetBlightLoc(whichPlayer,nearMineLoc, 768, true)

        // Set random hero spawn point to be off to the side of the start location.
        set heroLoc = MeleeGetProjectedLoc(GetUnitLoc(nearestMine), startLoc, 384, 45)
    else
        // Spawn Necropolis at the start location.
        call CreateUnitAtLoc(whichPlayer, 'unpl', startLoc, bj_UNIT_FACING)
        
        // Spawn Acolytes and Ghoul directly south of the Necropolis.
        set peonX = GetLocationX(startLoc)
        set peonY = GetLocationY(startLoc) - 224.00
        call CreateUnit(whichPlayer, 'uaco', peonX - 2.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'uaco', peonX - 1.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'uaco', peonX + 0.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'uaco', peonX + 1.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'ugho', peonX + 2.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)

        // Create a patch of blight around the start location.
        call SetBlightLoc(whichPlayer,startLoc, 768, true)

        // Set random hero spawn point to be just south of the start location.
        set heroLoc = Location(peonX, peonY - 2.00 * unitSpacing)
    endif

    // If the "Random Hero" option is set, start the player with a random hero.
    // Otherwise, give them a "free hero" token.
    if useRandomHero then
        call MeleeRandomHeroLoc(whichPlayer, 'Udea', 'Udre', 'Ulic', heroLoc)
    else
        call SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_HERO_TOKENS, bj_MELEE_STARTING_HERO_TOKENS)
    endif

    // Center the camera on the initial Acolytes.
    call SetCameraPositionForPlayer(whichPlayer, peonX, peonY)
    call SetCameraQuickPositionForPlayer(whichPlayer, peonX, peonY)
endfunction

//===========================================================================
// Starting Units for Night Elf Players
//   - 1 Tree of Life, placed by nearest gold mine, already entangled
//   - 5 Wisps, placed at start location
//
function MeleeStartingUnitsNightElf takes player whichPlayer, location startLoc returns nothing
    local boolean  useRandomHero = IsMapFlagSet(MAP_RANDOM_HERO)
    local real     unitSpacing   = 64.00
    local real     minTreeDist   = 3.5 * bj_CELLWIDTH
    local unit     nearestMine
    local location nearMineLoc
    local location wispLoc
    local location heroLoc
    local real     peonX
    local real     peonY
    local unit     tree

    set nearestMine = MeleeFindNearestMine(startLoc, bj_MELEE_MINE_SEARCH_RADIUS)
    if (nearestMine != null) then
        // Spawn Tree of Life near the mine and have it entangle the mine.
        // Project the Tree's coordinates from the gold mine, and then snap
        // the X and Y values to within minTreeDist of the Gold Mine.
        set nearMineLoc = MeleeGetProjectedLoc(GetUnitLoc(nearestMine), startLoc, 650, 0)
        set nearMineLoc = MeleeGetLocWithinRect(nearMineLoc, MeleeGetRectFromCircle(GetUnitLoc(nearestMine), minTreeDist))
        set tree = CreateUnitAtLoc(whichPlayer, 'etol', nearMineLoc, bj_UNIT_FACING)
        call IssueTargetOrder(tree, "entangleinstant", nearestMine)

        // Spawn Wisps at the start location.
        set wispLoc = MeleeGetProjectedLoc(GetUnitLoc(nearestMine), startLoc, 850, 0)
        set peonX = GetLocationX(wispLoc)
        set peonY = GetLocationY(wispLoc)
        call CreateUnit(whichPlayer, 'ewsp', peonX + 1.00 * unitSpacing, peonY + 1.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'ewsp', peonX + 1.00 * unitSpacing, peonY - 1.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'ewsp', peonX + 0.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'ewsp', peonX - 1.00 * unitSpacing, peonY + 1.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'ewsp', peonX - 1.00 * unitSpacing, peonY - 1.00 * unitSpacing, bj_UNIT_FACING)
        set peonX = GetLocationX(nearMineLoc)
        set peonY = GetLocationY(nearMineLoc)

        // Set random hero spawn point to be off to the side of the start location.
        set heroLoc = MeleeGetProjectedLoc(GetUnitLoc(nearestMine), startLoc, 384, 45)
    else
        // Spawn Tree of Life at the start location.
        call CreateUnitAtLoc(whichPlayer, 'etol', startLoc, bj_UNIT_FACING)

        // Spawn Wisps directly south of the town hall.
        set peonX = GetLocationX(startLoc)
        set peonY = GetLocationY(startLoc) - 224.00
        call CreateUnit(whichPlayer, 'ewsp', peonX - 2.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'ewsp', peonX - 1.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'ewsp', peonX + 0.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'ewsp', peonX + 1.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call CreateUnit(whichPlayer, 'ewsp', peonX + 2.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)

        // Set random hero spawn point to be just south of the start location.
        set heroLoc = Location(peonX, peonY - 2.00 * unitSpacing)
    endif

    // If the "Random Hero" option is set, start the player with a random hero.
    // Otherwise, give them a "free hero" token.
    if useRandomHero then
        call MeleeRandomHeroLoc(whichPlayer, 'Edem', 'Ekee', 'Emoo', heroLoc)
    else
        call SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_HERO_TOKENS, bj_MELEE_STARTING_HERO_TOKENS)
    endif

    // Center the camera on the initial Wisps.
    call SetCameraPositionForPlayer(whichPlayer, peonX, peonY)
    call SetCameraQuickPositionForPlayer(whichPlayer, peonX, peonY)
endfunction

//===========================================================================
// Starting Units for Players Whose Race is Unknown
//   - 13 Sheep, placed randomly around the start location
//
function MeleeStartingUnitsUnknownRace takes player whichPlayer, location startLoc returns nothing
    local integer index
    loop
        call CreateUnit(whichPlayer, 'nshe', GetLocationX(startLoc) + GetRandomReal(-256, 256), GetLocationY(startLoc) + GetRandomReal(-256, 256), GetRandomReal(0, 360))
        set index = index + 1
        exitwhen index == 13
    endloop

    // Give them a "free hero" token, out of pity.
    call SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_HERO_TOKENS, bj_MELEE_STARTING_HERO_TOKENS)

    // Center the camera on the initial sheep.
    call SetCameraPositionLocForPlayer(whichPlayer, startLoc)
    call SetCameraQuickPositionLocForPlayer(whichPlayer, startLoc)
endfunction

//===========================================================================
function MeleeStartingUnits takes nothing returns nothing
    local integer  index
    local player   indexPlayer
    local location indexStartLoc
    local race     indexRace

    set index = 0
    loop
        set indexPlayer = Player(index)
        if (GetPlayerSlotState(indexPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set indexStartLoc = GetStartLocationLoc(GetPlayerStartLocation(indexPlayer))
            set indexRace = GetPlayerRace(indexPlayer)

            // Create initial race-specific starting units
            if (indexRace == RACE_HUMAN) then
                call MeleeStartingUnitsHuman(indexPlayer, indexStartLoc)
            elseif (indexRace == RACE_ORC) then
                call MeleeStartingUnitsOrc(indexPlayer, indexStartLoc)
            elseif (indexRace == RACE_UNDEAD) then
                call MeleeStartingUnitsUndead(indexPlayer, indexStartLoc)
            elseif (indexRace == RACE_NIGHTELF) then
                call MeleeStartingUnitsNightElf(indexPlayer, indexStartLoc)
            else
                call MeleeStartingUnitsUnknownRace(indexPlayer, indexStartLoc)
            endif
        endif

        set index = index + 1
        exitwhen index == bj_MAX_PLAYERS
    endloop
endfunction



//***************************************************************************
//*
//*  Melee Template Hero Limit
//*
//***************************************************************************

//===========================================================================
function MeleeStartingHeroLimit takes nothing returns nothing
    local integer index

    set index = 0
    loop
        // max heroes per player
        call SetPlayerTechMaxAllowed(Player(index), 'HERO', bj_MELEE_HERO_LIMIT)

        // each player is restricted to a limit per hero type as well
        call SetPlayerTechMaxAllowed(Player(index), 'Hamg', bj_MELEE_HERO_TYPE_LIMIT)
        call SetPlayerTechMaxAllowed(Player(index), 'Hmkg', bj_MELEE_HERO_TYPE_LIMIT)
        call SetPlayerTechMaxAllowed(Player(index), 'Hpal', bj_MELEE_HERO_TYPE_LIMIT)

        call SetPlayerTechMaxAllowed(Player(index), 'Obla', bj_MELEE_HERO_TYPE_LIMIT)
        call SetPlayerTechMaxAllowed(Player(index), 'Ofar', bj_MELEE_HERO_TYPE_LIMIT)
        call SetPlayerTechMaxAllowed(Player(index), 'Otch', bj_MELEE_HERO_TYPE_LIMIT)

        call SetPlayerTechMaxAllowed(Player(index), 'Edem', bj_MELEE_HERO_TYPE_LIMIT)
        call SetPlayerTechMaxAllowed(Player(index), 'Ekee', bj_MELEE_HERO_TYPE_LIMIT)
        call SetPlayerTechMaxAllowed(Player(index), 'Emoo', bj_MELEE_HERO_TYPE_LIMIT)

        call SetPlayerTechMaxAllowed(Player(index), 'Udea', bj_MELEE_HERO_TYPE_LIMIT)
        call SetPlayerTechMaxAllowed(Player(index), 'Udre', bj_MELEE_HERO_TYPE_LIMIT)
        call SetPlayerTechMaxAllowed(Player(index), 'Ulic', bj_MELEE_HERO_TYPE_LIMIT)


        set index = index + 1
        exitwhen index == bj_MAX_PLAYERS
    endloop
endfunction



//***************************************************************************
//*
//*  Melee Template Granted Hero Items
//*
//***************************************************************************

//===========================================================================
function MeleeTrainedUnitIsHero takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

//===========================================================================
function MeleeGrantItemsToTrainedUnit takes nothing returns nothing
    call UnitAddItemById(GetTrainedUnit(), 'stwp')
endfunction

//===========================================================================
function MeleeGrantHeroItems takes nothing returns nothing
    local integer index
    local trigger trig

    set index = 0
    loop
        set trig = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(trig, Player(index), EVENT_PLAYER_UNIT_TRAIN_FINISH, Filter(function MeleeTrainedUnitIsHero))
        call TriggerAddAction(trig, function MeleeGrantItemsToTrainedUnit)

        set index = index + 1
        exitwhen index == bj_MAX_PLAYERS
    endloop
endfunction



//***************************************************************************
//*
//*  Melee Template Starting AI Scripts
//*
//***************************************************************************

//===========================================================================
function MeleeStartingAI takes nothing returns nothing
    local integer index
    local player  indexPlayer
    local race    indexRace

    set index = 0
    loop
        set indexPlayer = Player(index)
        if (GetPlayerSlotState(indexPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set indexRace = GetPlayerRace(indexPlayer)
            if (GetPlayerController(indexPlayer) == MAP_CONTROL_COMPUTER) then
                // Run a race-specific melee AI script.
                if (indexRace == RACE_HUMAN) then
                    call StartMeleeAI(indexPlayer, "human.ai")
                elseif (indexRace == RACE_ORC) then
                    call StartMeleeAI(indexPlayer, "orc.ai")
                elseif (indexRace == RACE_UNDEAD) then
                    call StartMeleeAI(indexPlayer, "undead.ai")
                elseif (indexRace == RACE_NIGHTELF) then
                    call StartMeleeAI(indexPlayer, "elf.ai")
                else
                    // Unrecognized race.
                endif
            endif
        endif

        set index = index + 1
        exitwhen index == bj_MAX_PLAYERS
    endloop
endfunction



//***************************************************************************
//*
//*  Melee Template Victory / Defeat Conditions
//*
//***************************************************************************

//===========================================================================
function MeleePlayerIsOpponent takes integer playerIndex, integer opponentIndex returns boolean
    local player thePlayer = Player(playerIndex)
    local player theOpponent = Player(opponentIndex)
// %%% Temp Debug Code
//local string s

    // The player himself is not an opponent.
    if (playerIndex == opponentIndex) then
        return false
    endif

    // Unused player slots are not opponents.
    if (GetPlayerSlotState(theOpponent) != PLAYER_SLOT_STATE_PLAYING) then
        return false
    endif

    // Players who are already defeated are not opponents.
    if (bj_meleeDefeated[opponentIndex]) then
        return false
    endif

    // Allied players with allied victory set are not opponents.
    if GetPlayerAlliance(thePlayer, theOpponent, ALLIANCE_PASSIVE) then
        if GetPlayerAlliance(theOpponent, thePlayer, ALLIANCE_PASSIVE) then
            if (GetPlayerState(thePlayer, PLAYER_STATE_ALLIED_VICTORY) == 1) then
                if (GetPlayerState(theOpponent, PLAYER_STATE_ALLIED_VICTORY) == 1) then
                    return false
                endif
            endif
        endif
    endif

// %%% Temp Debug Code
//set s = "( " + I2S(playerIndex) + " , " + I2S(opponentIndex) + " )  "
//set s = s + TertiaryStringOp(GetPlayerAlliance(thePlayer, theOpponent, ALLIANCE_PASSIVE), "<", "_")
//set s = s + TertiaryStringOp(GetPlayerAlliance(theOpponent, thePlayer, ALLIANCE_PASSIVE), ">", "_")
//set s = s + ", "
//set s = s + R2SW(GetPlayerState(thePlayer, PLAYER_STATE_ALLIED_VICTORY),1,4)
//set s = s + R2SW(GetPlayerState(theOpponent, PLAYER_STATE_ALLIED_VICTORY),1,4)
//call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15, s)
    return true
endfunction

//===========================================================================
// Count buildings currently owned by all allies, including the player themself.
//
function MeleeGetAllyStructureCount takes player whichPlayer returns integer
    local integer    playerIndex
    local integer    buildingCount
    local player     indexPlayer

    // Count the number of buildings controlled by all not-yet-defeated co-allies.
    set buildingCount = 0
    set playerIndex = 0
    loop
        set indexPlayer = Player(playerIndex)
        if (PlayersAreCoAllied(whichPlayer, indexPlayer) and not bj_meleeDefeated[playerIndex]) then
            set buildingCount = buildingCount + GetPlayerStructureCount(indexPlayer, true)
        endif
            
        set playerIndex = playerIndex + 1
        exitwhen playerIndex == bj_MAX_PLAYERS
    endloop

    return buildingCount
endfunction

//===========================================================================
// Count allies, excluding dead players and the player themself.
//
function MeleeGetAllyCount takes player whichPlayer returns integer
    local integer playerIndex
    local integer playerCount
    local player  indexPlayer

    // Count the number of not-yet-defeated co-allies.
    set playerCount = 0
    set playerIndex = 0
    loop
        set indexPlayer = Player(playerIndex)
        if PlayersAreCoAllied(whichPlayer, indexPlayer) and not bj_meleeDefeated[playerIndex] and (whichPlayer != indexPlayer) then
            set playerCount = playerCount + 1
        endif

        set playerIndex = playerIndex + 1
        exitwhen playerIndex == bj_MAX_PLAYERS
    endloop

    return playerCount
endfunction

//===========================================================================
// Enum: Victory out a specific player.
//
function MeleeDoVictoryEnum takes nothing returns nothing
    local player thePlayer = GetEnumPlayer()
    local integer playerIndex = GetPlayerId(thePlayer)

    if (not bj_meleeVictoried[playerIndex]) then
        set bj_meleeVictoried[playerIndex] = true
		call CachePlayerHeroData(thePlayer)
        call RemovePlayerBJ(thePlayer, PLAYER_GAME_RESULT_VICTORY, "Victory!")
    endif
endfunction

//===========================================================================
// Defeat out a specific player.
//
function MeleeDoDefeat takes player whichPlayer returns nothing
    set bj_meleeDefeated[GetPlayerId(whichPlayer)] = true
    call RemovePlayerBJ(whichPlayer, PLAYER_GAME_RESULT_DEFEAT, "Defeat!")
endfunction

//===========================================================================
// Test all players to determine if a team has won.  For a team to win, all
// remaining (read: undefeated) players need to be co-allied with all other
// remaining players.  If even one player is not allied towards another,
// everyone must be denied victory.
//
function MeleeCheckForVictors takes nothing returns nothing
    local integer    playerIndex
    local integer    opponentIndex
    local force      opponentlessPlayers = CreateForce()

    // Check to see if any players have opponents remaining.
    set playerIndex = 0
    loop
        if (not bj_meleeDefeated[playerIndex]) then
            // Determine whether or not this player has any remaining opponents.
            set opponentIndex = 0
            loop
                // If anyone has an opponent, noone can be victorious yet.
                if MeleePlayerIsOpponent(playerIndex, opponentIndex) then
                    return
                endif

                set opponentIndex = opponentIndex + 1
                exitwhen opponentIndex == bj_MAX_PLAYERS
            endloop

            // Keep track of each opponentless player so that we can give
            // them a victory later.
            call ForceAddPlayer(opponentlessPlayers, Player(playerIndex))
        endif

        set playerIndex = playerIndex + 1
        exitwhen playerIndex == bj_MAX_PLAYERS
    endloop

    // No players have opponents left, so give them all a victory.
    call ForForce(opponentlessPlayers, function MeleeDoVictoryEnum)
endfunction

//===========================================================================
// Test each player to determine if anyone has been defeated.
//
function MeleeCheckForLosers takes nothing returns nothing
    local integer    playerIndex
    local player     indexPlayer

    // Check each player to see if he or she has been defeated yet.
    set playerIndex = 0
    loop
        set indexPlayer = Player(playerIndex)

        if (not bj_meleeDefeated[playerIndex] and not bj_meleeVictoried[playerIndex]) then
            //call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 60, "Player"+I2S(playerIndex)+" has "+I2S(MeleeGetAllyStructureCount(indexPlayer))+" ally buildings.")
            if (MeleeGetAllyStructureCount(indexPlayer) <= 0) then
				// needs to happen before ownership change
				call CachePlayerHeroData(indexPlayer)
                call MakeUnitsPassiveForTeam(indexPlayer)
                call MeleeDoDefeat(indexPlayer)
            endif
        endif
            
        set playerIndex = playerIndex + 1
        exitwhen playerIndex == bj_MAX_PLAYERS
    endloop
endfunction

//===========================================================================
// Determine if the lost unit should result in any defeats or victories.
//
function MeleeCheckLostUnit takes unit lostUnit returns nothing
    if (IsUnitType(lostUnit, UNIT_TYPE_STRUCTURE)) then
        // We only need to check for mortality if this was the last building.
        if (GetPlayerStructureCount(GetOwningPlayer(lostUnit), true) <= 0) then
            call MeleeCheckForLosers()
            call MeleeCheckForVictors()
        endif
    endif
endfunction

//===========================================================================
function MeleeTriggerActionConstructCancel takes nothing returns nothing
    call MeleeCheckLostUnit(GetCancelledStructure())
endfunction

//===========================================================================
function MeleeTriggerActionUnitDeath takes nothing returns nothing
    call MeleeCheckLostUnit(GetDyingUnit())
endfunction

//===========================================================================
function MeleeTriggerActionPlayerDefeated takes nothing returns nothing
    local player thePlayer = GetTriggerPlayer()
	call CachePlayerHeroData(thePlayer)

    if (MeleeGetAllyCount(thePlayer) > 0) then
        // If at least one ally is still alive and kicking, share units with
        // them and proceed with death.
        call ShareEverythingWithTeam(thePlayer)
        call MeleeDoDefeat(thePlayer)
    else
        // If no living allies remain, swap all units and buildings over to
        // neutral_passive and proceed with death.
        call MakeUnitsPassiveForTeam(thePlayer)
        call MeleeDoDefeat(thePlayer)
    endif
    call MeleeCheckForLosers()
    call MeleeCheckForVictors()
endfunction

//===========================================================================
function MeleeTriggerActionAllianceChange takes nothing returns nothing
    call MeleeCheckForLosers()
    call MeleeCheckForVictors()
endfunction

//===========================================================================
function MeleeInitVictoryDefeat takes nothing returns nothing
    local trigger    trig
    local integer    index
    local player     indexPlayer
    local integer    totalPlayers

    // Set up each player's mortality code.
    set index = 0
    loop
        set indexPlayer = Player(index)

        // Make sure this player slot is playing.
        if (GetPlayerSlotState(indexPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set bj_meleeDefeated[index] = false
            set bj_meleeVictoried[index] = false

            // Set a trigger to fire whenever a building is cancelled for this player.
            set trig = CreateTrigger()
            call TriggerRegisterPlayerUnitEvent(trig, indexPlayer, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL, null)
            call TriggerAddAction(trig, function MeleeTriggerActionConstructCancel)

            // Set a trigger to fire whenever a unit dies for this player.
            set trig = CreateTrigger()
            call TriggerRegisterPlayerUnitEvent(trig, indexPlayer, EVENT_PLAYER_UNIT_DEATH, null)
            call TriggerAddAction(trig, function MeleeTriggerActionUnitDeath)

            // Set a trigger to fire whenever this player defeats-out
            set trig = CreateTrigger()
            call TriggerRegisterPlayerEvent(trig, indexPlayer, EVENT_PLAYER_DEFEAT)
            call TriggerAddAction(trig, function MeleeTriggerActionPlayerDefeated)

            // Set a trigger to fire whenever this player changes his/her alliances.
            set trig = CreateTrigger()
            call TriggerRegisterPlayerAllianceChange(trig, indexPlayer, ALLIANCE_PASSIVE)
            call TriggerRegisterPlayerStateEvent(trig, indexPlayer, PLAYER_STATE_ALLIED_VICTORY, EQUAL, 1)
            call TriggerAddAction(trig, function MeleeTriggerActionAllianceChange)
        else
            set bj_meleeDefeated[index] = true
            set bj_meleeVictoried[index] = false
        endif

        set index = index + 1
        exitwhen index == bj_MAX_PLAYERS
    endloop

    // Test for victory / defeat at startup, in case the user has already won / lost.
    // Allow for a short time to pass first, so that the map can finish loading.
    call TimerStart(CreateTimer(), 2.0, false, function MeleeTriggerActionAllianceChange)
endfunction



//***************************************************************************
//*
//*  Player Slot Availability
//*
//***************************************************************************

//===========================================================================
function CheckInitPlayerSlotAvailability takes nothing returns nothing
    local integer index

    if (not bj_slotControlReady) then
        set index = 0
        loop
            set bj_slotControlUsed[index] = false
            set bj_slotControl[index] = MAP_CONTROL_USER
            set index = index + 1
            exitwhen index == bj_MAX_PLAYERS
        endloop
        set bj_slotControlReady = true
    endif
endfunction

//===========================================================================
function SetPlayerSlotAvailable takes player whichPlayer, mapcontrol control returns nothing
    local integer playerIndex = GetPlayerId(whichPlayer)

    call CheckInitPlayerSlotAvailability()
    set bj_slotControlUsed[playerIndex] = true
    set bj_slotControl[playerIndex] = control
endfunction



//***************************************************************************
//*
//*  Generic Template Player-slot Initialization
//*
//***************************************************************************

//===========================================================================
function TeamInitPlayerSlots takes integer teamCount returns nothing
    local integer index
    local player  indexPlayer
    local integer team

    call CheckInitPlayerSlotAvailability()
    set index = 0
    set team = 0
    loop
        if (bj_slotControlUsed[index]) then
            set indexPlayer = Player(index)
            call SetPlayerTeam( indexPlayer, team )
            set team = team + 1
            if (team >= teamCount) then
                set team = 0
            endif
        endif

        set index = index + 1
        exitwhen index == bj_MAX_PLAYERS
    endloop
endfunction

//===========================================================================
function MeleeInitPlayerSlots takes nothing returns nothing
    call TeamInitPlayerSlots(bj_MAX_PLAYERS)
endfunction

//===========================================================================
function FFAInitPlayerSlots takes nothing returns nothing
    call TeamInitPlayerSlots(bj_MAX_PLAYERS)
endfunction

//===========================================================================
function OneOnOneInitPlayerSlots takes nothing returns nothing
    // Limit the game to 2 players.
    call SetTeams(2)
    call SetPlayers(2)
    call TeamInitPlayerSlots(2)
endfunction

//===========================================================================
function InitGenericPlayerSlots takes nothing returns nothing
    local gametype gType = GetGameTypeSelected()

    if (gType == GAME_TYPE_MELEE) then
        call MeleeInitPlayerSlots()
    elseif (gType == GAME_TYPE_FFA) then
        call FFAInitPlayerSlots()
    elseif (gType == GAME_TYPE_USE_MAP_SETTINGS) then
        // Do nothing; the map-specific script handles this.
    elseif (gType == GAME_TYPE_ONE_ON_ONE) then
        call OneOnOneInitPlayerSlots()
    elseif (gType == GAME_TYPE_TWO_TEAM_PLAY) then
        call TeamInitPlayerSlots(2)
    elseif (gType == GAME_TYPE_THREE_TEAM_PLAY) then
        call TeamInitPlayerSlots(3)
    elseif (gType == GAME_TYPE_FOUR_TEAM_PLAY) then
        call TeamInitPlayerSlots(4)
    else
        // Unrecognized Game Type
    endif
endfunction



//***************************************************************************
//*
//*  Blizzard.j Initialization
//*
//***************************************************************************

//===========================================================================
function TriggerActionUnitRescuedBJ takes nothing returns nothing
    call RescueUnitBJ(GetTriggerUnit(), GetOwningPlayer(GetRescuer()), bj_CHANGE_COLOR_ON_RESCUE)
endfunction

//===========================================================================
// Default rescue functionality
//
function InitRescuableBehavior takes nothing returns nothing
    local trigger trig
    local integer index

    set trig = CreateTrigger()
    set index = 0
    loop
        call TriggerRegisterPlayerUnitEvent(trig, Player(index), EVENT_PLAYER_UNIT_RESCUED, null)
        set index = index + 1
        exitwhen index == bj_MAX_PLAYER_SLOTS
    endloop
    call TriggerAddAction(trig, function TriggerActionUnitRescuedBJ)
endfunction



//***************************************************************************
//*
//*  Blizzard.j Initialization
//*
//***************************************************************************

//===========================================================================
function InitBlizzardGlobals takes nothing returns nothing
    local integer index

    set index = 0
    loop
        set bj_FORCE_PLAYER[index] = CreateForce()
        call ForceAddPlayer(bj_FORCE_PLAYER[index], Player(index))

        set index = index + 1
        exitwhen index == bj_MAX_PLAYER_SLOTS
    endloop

    set bj_FORCE_ALL_PLAYERS = CreateForce()
    call ForceEnumPlayers(bj_FORCE_ALL_PLAYERS, null)

    set bj_cineModePriorSpeed = GetGameSpeed()
    set bj_cineModePriorFogSetting = IsFogEnabled()
    set bj_cineModePriorMaskSetting = IsFogMaskEnabled()
    set bj_cineModePriorSpeedLocked = IsMapFlagSet(MAP_LOCK_SPEED)
endfunction

//===========================================================================
function InitBlizzard takes nothing returns nothing
    // Set up the Neutral Victim player slot, to torture the abandoned units
    // of defeated players.  Since some triggers expect this player slot to
    // exist, this is performed for all maps.
    call ConfigureNeutralVictim()

    call InitBlizzardGlobals()
    call InitRescuableBehavior()
endfunction



//***************************************************************************
//*
//*  Random distribution
//*
//*  Used to select a random object from a given distribution of chances
//*
//*  - RandomDistReset clears the distribution list
//*
//*  - RandomDistAddItem adds a new object to the distribution list
//*    with a given identifier and an integer chance to be chosen
//*
//*  - RandomDistChoose will use the current distribution list to choose
//*    one of the objects randomly based on the chance distribution
//*  
//*  Note that the chances are effectively normalized by their sum,
//*  so only the relative values of each chance are important
//*
//***************************************************************************

//===========================================================================
function RandomDistReset takes nothing returns nothing
    set bj_randDistCount = 0
endfunction

//===========================================================================
function RandomDistAddItem takes integer inID, integer inChance returns nothing
    set bj_randDistID[bj_randDistCount] = inID
    set bj_randDistChance[bj_randDistCount] = inChance
    set bj_randDistCount = bj_randDistCount + 1
endfunction

//===========================================================================
function RandomDistChoose takes nothing returns integer
    local integer sum = 0
	local integer chance = 0
	local integer index
	local integer foundID = -1
	local boolean done

	// No items?
	if (bj_randDistCount == 0) then
        return -1
    endif

	// Find sum of all chances
	set index = 0
	loop
        set sum = sum + bj_randDistChance[index]

		set index = index + 1
        exitwhen index == bj_randDistCount
    endloop

	// Choose random number within the total range
	set chance = GetRandomInt(1, sum)

	// Find ID which corresponds to this chance
	set index = 0
	set sum = 0
	set done = false
	loop
        set sum = sum + bj_randDistChance[index]

		if (chance <= sum) then
            set foundID = bj_randDistID[index]
			set done = true
		endif

		set index = index + 1
		if (index == bj_randDistCount) then
            set done = true
		endif

        exitwhen done == true
    endloop

	return foundID
endfunction

//***************************************************************************
//*
//*  Drop item
//*
//*  Makes the given unit drop the given item
//*
//*  Note: This could potentially cause problems if the unit is standing
//*        right on the edge of an unpathable area and happens to drop the
//*        item into the unpathable area where nobody can get it...
//*
//***************************************************************************

function UnitDropItem takes unit inUnit, integer inItemID returns nothing
    local real x
	local real y
	local real radius = 32
	local real unitX
	local real unitY

	if (inItemID == -1) then
        return
    endif

    set unitX = GetUnitX(inUnit)
	set unitY = GetUnitY(inUnit)

	set x = GetRandomReal(unitX - radius, unitX + radius)
	set y = GetRandomReal(unitY - radius, unitY + radius)

    call CreateItem(inItemID, x, y)
endfunction
