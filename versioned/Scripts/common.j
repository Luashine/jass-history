//============================================================================
// Native types. All native functions take extended handle types when
// possible to help prevent passing bad values to native functions
//
type event              extends     handle  // a reference to an event registration
type player             extends     handle  // a single player reference
type unit               extends     handle  // a single unit reference
type destructable       extends     handle
type item               extends     handle
type force              extends     handle
type group              extends     handle
type trigger            extends     handle
type triggercondition   extends     handle
type triggeraction      extends     handle
type timer              extends     handle
type location           extends     handle
type region             extends     handle
type rect               extends     handle
type boolexpr           extends     handle
type sound              extends     handle
type conditionfunc      extends     boolexpr
type filterfunc         extends     boolexpr
type unitpool           extends     handle
type itempool           extends     handle
type race               extends     handle
type alliancetype       extends     handle
type racepreference     extends     handle
type gamestate          extends     handle
type igamestate         extends     gamestate
type fgamestate         extends     gamestate
type playerstate        extends     handle
type playergameresult   extends     handle
type unitstate          extends     handle

type eventid            extends     handle
type gameevent          extends     eventid
type playerevent        extends     eventid
type playerunitevent    extends     eventid
type unitevent          extends     eventid
type limitop            extends     eventid

type unittype           extends     handle

type gamespeed          extends     handle
type gamedifficulty     extends     handle
type gametype           extends     handle
type mapflag            extends     handle
type mapvisibility      extends     handle
type mapsetting         extends     handle
type mapdensity         extends     handle
type mapcontrol         extends     handle
type playerslotstate    extends     handle
type camerafield        extends     handle
type camerasetup        extends     handle
type playercolor        extends     handle
type placement          extends     handle
type startlocprio       extends     handle
type raritycontrol      extends     handle
type blendmode          extends     handle
type materialid         extends     handle
type texmapflags        extends     handle
type weathereffect      extends     handle
type fogstate           extends     handle
type fogmodifier        extends     handle

constant native ConvertRace                 takes integer i returns race
constant native ConvertAllianceType         takes integer i returns alliancetype
constant native ConvertRacePref             takes integer i returns racepreference
constant native ConvertIGameState           takes integer i returns igamestate
constant native ConvertFGameState           takes integer i returns fgamestate
constant native ConvertPlayerState          takes integer i returns playerstate
constant native ConvertPlayerGameResult     takes integer i returns playergameresult
constant native ConvertUnitState            takes integer i returns unitstate
constant native ConvertGameEvent            takes integer i returns gameevent
constant native ConvertPlayerEvent          takes integer i returns playerevent
constant native ConvertPlayerUnitEvent      takes integer i returns playerunitevent
constant native ConvertUnitEvent            takes integer i returns unitevent
constant native ConvertLimitOp              takes integer i returns limitop
constant native ConvertUnitType             takes integer i returns unittype
constant native ConvertGameSpeed            takes integer i returns gamespeed
constant native ConvertPlacement            takes integer i returns placement
constant native ConvertStartLocPrio         takes integer i returns startlocprio
constant native ConvertGameDifficulty       takes integer i returns gamedifficulty
constant native ConvertGameType             takes integer i returns gametype
constant native ConvertMapFlag              takes integer i returns mapflag
constant native ConvertMapVisibility        takes integer i returns mapvisibility
constant native ConvertMapSetting           takes integer i returns mapsetting
constant native ConvertMapDensity           takes integer i returns mapdensity
constant native ConvertMapControl           takes integer i returns mapcontrol
constant native ConvertPlayerColor          takes integer i returns playercolor
constant native ConvertPlayerSlotState      takes integer i returns playerslotstate
constant native OrderId                     takes string orderIdString returns integer
constant native ConvertCameraField          takes integer i returns camerafield
constant native ConvertMaterialId           takes integer i returns materialid
constant native ConvertBlendMode            takes integer i returns blendmode
constant native ConvertRarityControl        takes integer i returns raritycontrol
constant native ConvertTexMapFlags          takes integer i returns texmapflags
constant native ConvertFogState             takes integer i returns fogstate

globals

//===================================================
// Game Constants    
//===================================================

    // pfff
    constant boolean            FALSE                           = false
    constant boolean            TRUE                            = true

    constant integer            PLAYER_NEUTRAL_PASSIVE          = 15
    constant integer            PLAYER_NEUTRAL_AGGRESSIVE       = 12

    constant playercolor        PLAYER_COLOR_RED                = ConvertPlayerColor(0)
    constant playercolor        PLAYER_COLOR_BLUE               = ConvertPlayerColor(1)
    constant playercolor        PLAYER_COLOR_CYAN               = ConvertPlayerColor(2)
    constant playercolor        PLAYER_COLOR_PURPLE             = ConvertPlayerColor(3)
    constant playercolor        PLAYER_COLOR_YELLOW             = ConvertPlayerColor(4)
    constant playercolor        PLAYER_COLOR_ORANGE             = ConvertPlayerColor(5)
    constant playercolor        PLAYER_COLOR_GREEN              = ConvertPlayerColor(6)
    constant playercolor        PLAYER_COLOR_PINK               = ConvertPlayerColor(7)
    constant playercolor        PLAYER_COLOR_LIGHT_GRAY         = ConvertPlayerColor(8)
    constant playercolor        PLAYER_COLOR_LIGHT_BLUE         = ConvertPlayerColor(9)
    constant playercolor        PLAYER_COLOR_AQUA               = ConvertPlayerColor(10)
    constant playercolor        PLAYER_COLOR_BROWN              = ConvertPlayerColor(11)

    constant race               RACE_HUMAN                      = ConvertRace(1)
    constant race               RACE_ORC                        = ConvertRace(2)
    constant race               RACE_UNDEAD                     = ConvertRace(3)
    constant race               RACE_NIGHTELF                   = ConvertRace(4)
    constant race               RACE_DEMON                      = ConvertRace(5)

    constant playergameresult   PLAYER_GAME_RESULT_VICTORY      = ConvertPlayerGameResult(0)
    constant playergameresult   PLAYER_GAME_RESULT_DEFEAT       = ConvertPlayerGameResult(1)
    constant playergameresult   PLAYER_GAME_RESULT_TIE          = ConvertPlayerGameResult(2)

    constant alliancetype       ALLIANCE_PASSIVE                = ConvertAllianceType(0)
    constant alliancetype       ALLIANCE_HELP_REQUEST           = ConvertAllianceType(1)
    constant alliancetype       ALLIANCE_HELP_RESPONSE          = ConvertAllianceType(2)
    constant alliancetype       ALLIANCE_SHARED_XP              = ConvertAllianceType(3)
    constant alliancetype       ALLIANCE_SHARED_SPELLS          = ConvertAllianceType(4)
    constant alliancetype       ALLIANCE_SHARED_VISION          = ConvertAllianceType(5)
    constant alliancetype       ALLIANCE_SHARED_CONTROL         = ConvertAllianceType(6)
    constant alliancetype       ALLIANCE_SHARED_ADVANCED_CONTROL= ConvertAllianceType(7)
    constant alliancetype       ALLIANCE_SHARED_INFO            = ConvertAllianceType(8)
    constant alliancetype       ALLIANCE_RESCUABLE              = ConvertAllianceType(9)

//===================================================
// Map Setup Constants    
//===================================================

    constant racepreference     RACE_PREF_HUMAN                     = ConvertRacePref(1)
    constant racepreference     RACE_PREF_ORC                       = ConvertRacePref(2)
    constant racepreference     RACE_PREF_NIGHTELF                  = ConvertRacePref(4)
    constant racepreference     RACE_PREF_UNDEAD                    = ConvertRacePref(8)
    constant racepreference     RACE_PREF_DEMON                     = ConvertRacePref(16)
    constant racepreference     RACE_PREF_RANDOM                    = ConvertRacePref(32)
    constant racepreference     RACE_PREF_USER_SELECTABLE           = ConvertRacePref(64)

    constant mapcontrol         MAP_CONTROL_USER                    = ConvertMapControl(0)
    constant mapcontrol         MAP_CONTROL_COMPUTER                = ConvertMapControl(1)
    constant mapcontrol         MAP_CONTROL_RESCUABLE               = ConvertMapControl(2)
    constant mapcontrol         MAP_CONTROL_NEUTRAL                 = ConvertMapControl(3)
    constant mapcontrol         MAP_CONTROL_CREEP                   = ConvertMapControl(4)
    constant mapcontrol         MAP_CONTROL_NONE                    = ConvertMapControl(5)

    constant gametype           GAME_TYPE_MELEE                     = ConvertGameType(1)
    constant gametype           GAME_TYPE_FFA                       = ConvertGameType(2)
    constant gametype           GAME_TYPE_USE_MAP_SETTINGS          = ConvertGameType(4)
    constant gametype           GAME_TYPE_BLIZ                      = ConvertGameType(8)
    constant gametype           GAME_TYPE_ONE_ON_ONE                = ConvertGameType(16)
    constant gametype           GAME_TYPE_TWO_TEAM_PLAY             = ConvertGameType(32)
    constant gametype           GAME_TYPE_THREE_TEAM_PLAY           = ConvertGameType(64)
    constant gametype           GAME_TYPE_FOUR_TEAM_PLAY            = ConvertGameType(128)

    constant mapflag            MAP_SHOW_FOW                        = ConvertMapFlag(1)
    constant mapflag            MAP_SHOW_MASK                       = ConvertMapFlag(2)
    constant mapflag            MAP_SHOW_TERRAIN                    = ConvertMapFlag(4)

    constant mapflag            MAP_USE_HANDICAPS                   = ConvertMapFlag(8)
    constant mapflag            MAP_OBSERVERS                       = ConvertMapFlag(16)
    constant mapflag            MAP_OBSERVERS_CHAT                  = ConvertMapFlag(32)

    //constant mapflag            MAP_FIXED_START_LOC                 = ConvertMapFlag(64)
    constant mapflag            MAP_FIXED_COLORS                    = ConvertMapFlag(128)

    constant mapflag            MAP_LOCK_RESOURCE_TRADING           = ConvertMapFlag(256)
    constant mapflag            MAP_RESOURCE_TRADING_ALLIES_ONLY    = ConvertMapFlag(512)

    constant mapflag            MAP_LOCK_ALLIANCE_CHANGES           = ConvertMapFlag(1024)
    constant mapflag            MAP_ALLIANCE_CHANGES_HIDDEN         = ConvertMapFlag(2048)

    constant mapflag            MAP_CHEATS                          = ConvertMapFlag(4096)
    constant mapflag            MAP_CHEATS_HIDDEN                   = ConvertMapFlag(8192)

    constant mapflag            MAP_LOCK_SPEED                      = ConvertMapFlag(8192*2)
    constant mapflag            MAP_LOCK_RANDOM_SEED                = ConvertMapFlag(8192*4)

    constant placement          MAP_PLACEMENT_RANDOM                = ConvertPlacement(0)   // random among all slots
    constant placement          MAP_PLACEMENT_FIXED                 = ConvertPlacement(1)   // player 0 in start loc 0...
    constant placement          MAP_PLACEMENT_USE_MAP_SETTINGS      = ConvertPlacement(2)   // whatever was specified by the script
    constant placement          MAP_PLACEMENT_TEAMS_TOGETHER        = ConvertPlacement(3)   // random with allies next to each other    

    constant startlocprio       MAP_LOC_PRIO_LOW                    = ConvertStartLocPrio(0)
    constant startlocprio       MAP_LOC_PRIO_HIGH                   = ConvertStartLocPrio(1)
    constant startlocprio       MAP_LOC_PRIO_NOT                    = ConvertStartLocPrio(2)

    constant mapdensity         MAP_DENSITY_NONE                    = ConvertMapDensity(0)
    constant mapdensity         MAP_DENSITY_LIGHT                   = ConvertMapDensity(1)
    constant mapdensity         MAP_DENSITY_MEDIUM                  = ConvertMapDensity(2)
    constant mapdensity         MAP_DENSITY_HEAVY                   = ConvertMapDensity(3)

    constant gamedifficulty     MAP_DIFFICULTY_EASY                 = ConvertGameDifficulty(0)
    constant gamedifficulty     MAP_DIFFICULTY_NORMAL               = ConvertGameDifficulty(1)
    constant gamedifficulty     MAP_DIFFICULTY_HARD                 = ConvertGameDifficulty(2)
    constant gamedifficulty     MAP_DIFFICULTY_INSANE               = ConvertGameDifficulty(3)

    constant gamespeed          MAP_SPEED_SLOWEST                   = ConvertGameSpeed(0)
    constant gamespeed          MAP_SPEED_SLOW                      = ConvertGameSpeed(1)
    constant gamespeed          MAP_SPEED_NORMAL                    = ConvertGameSpeed(2)
    constant gamespeed          MAP_SPEED_FAST                      = ConvertGameSpeed(3)
    constant gamespeed          MAP_SPEED_FASTEST                   = ConvertGameSpeed(4)

    constant playerslotstate    PLAYER_SLOT_STATE_EMPTY             = ConvertPlayerSlotState(0)
    constant playerslotstate    PLAYER_SLOT_STATE_PLAYING           = ConvertPlayerSlotState(1)
    constant playerslotstate    PLAYER_SLOT_STATE_LEFT              = ConvertPlayerSlotState(2)

//===================================================
// Game, Player, and Unit States
//
// For use with TriggerRegister<X>StateEvent
//
//===================================================

    constant igamestate GAME_STATE_DIVINE_INTERVENTION          = ConvertIGameState(0)
    constant igamestate GAME_STATE_PLAYERS                      = ConvertIGameState(1)

    constant fgamestate GAME_STATE_TIME_OF_DAY                  = ConvertFGameState(2)

    constant playerstate PLAYER_STATE_GAME_RESULT               = ConvertPlayerState(0)

    // current resource levels
    //
    constant playerstate PLAYER_STATE_RESOURCE_GOLD             = ConvertPlayerState(1)
    constant playerstate PLAYER_STATE_RESOURCE_LUMBER           = ConvertPlayerState(2)
    constant playerstate PLAYER_STATE_RESOURCE_MANASTONES       = ConvertPlayerState(3)
    constant playerstate PLAYER_STATE_RESOURCE_HERO_TOKENS      = ConvertPlayerState(4)
    constant playerstate PLAYER_STATE_RESOURCE_FOOD_CAP         = ConvertPlayerState(5)
    constant playerstate PLAYER_STATE_RESOURCE_FOOD_USED        = ConvertPlayerState(6)
    constant playerstate PLAYER_STATE_FOOD_CAP_CEILING          = ConvertPlayerState(7)

    constant playerstate PLAYER_STATE_GIVES_BOUNTY              = ConvertPlayerState(8)
    constant playerstate PLAYER_STATE_EXPANDED_VIEW             = ConvertPlayerState(9)
    constant playerstate PLAYER_STATE_ALLIED_VICTORY            = ConvertPlayerState(10)
    constant playerstate PLAYER_STATE_PLACED                    = ConvertPlayerState(11)

    // taxation rate for each resource
    //
    constant playerstate PLAYER_STATE_GOLD_UPKEEP_RATE          = ConvertPlayerState(12)
    constant playerstate PLAYER_STATE_LUMBER_UPKEEP_RATE        = ConvertPlayerState(13)
    constant playerstate PLAYER_STATE_MANASTONES_UPKEEP_RATE    = ConvertPlayerState(14)

    // cumulative resources collected by the player during the mission
    //
    constant playerstate PLAYER_STATE_GOLD_GATHERED             = ConvertPlayerState(15)
    constant playerstate PLAYER_STATE_LUMBER_GATHERED           = ConvertPlayerState(16)
    constant playerstate PLAYER_STATE_MANASTONES_GATHERED       = ConvertPlayerState(17)

    constant unitstate UNIT_STATE_LIFE                          = ConvertUnitState(0)
    constant unitstate UNIT_STATE_MAX_LIFE                      = ConvertUnitState(1)
    constant unitstate UNIT_STATE_MANA                          = ConvertUnitState(2)
    constant unitstate UNIT_STATE_MAX_MANA                      = ConvertUnitState(3)
    

//===================================================
// Game, Player and Unit Events
//
//  When an event causes a trigger to fire these
//  values allow the action code to determine which
//  event was dispatched and therefore which set of
//  native functions should be used to get information
//  about the event.
//
// Do NOT change the order or value of these constants
// without insuring that the JASS_GAME_EVENTS_WAR3 enum
// is changed to match.
//
//===================================================

    //===================================================
    // For use with TriggerRegisterGameEvent    
    //===================================================    

    constant gameevent EVENT_GAME_VICTORY                       = ConvertGameEvent(0)
    constant gameevent EVENT_GAME_END_LEVEL                     = ConvertGameEvent(1)

    constant gameevent EVENT_GAME_VARIABLE_LIMIT                = ConvertGameEvent(2)
    constant gameevent EVENT_GAME_STATE_LIMIT                   = ConvertGameEvent(3)   

    constant gameevent EVENT_GAME_TIMER_EXPIRED                 = ConvertGameEvent(4)

    constant gameevent EVENT_GAME_ENTER_REGION                  = ConvertGameEvent(5)
    constant gameevent EVENT_GAME_LEAVE_REGION                  = ConvertGameEvent(6)

    //===================================================
    // For use with TriggerRegisterPlayerEvent
    //===================================================
    constant playerevent EVENT_PLAYER_STATE_LIMIT               = ConvertPlayerEvent(7)
    constant playerevent EVENT_PLAYER_ALLIANCE_CHANGED          = ConvertPlayerEvent(8)

    constant playerevent EVENT_PLAYER_DEFEAT                    = ConvertPlayerEvent(9)
    constant playerevent EVENT_PLAYER_VICTORY                   = ConvertPlayerEvent(10)
    constant playerevent EVENT_PLAYER_CHAT                      = ConvertPlayerEvent(11)
    constant playerevent EVENT_PLAYER_END_CINEMATIC             = ConvertPlayerEvent(12)

    //===================================================
    // For use with TriggerRegisterPlayerUnitEvent
    //===================================================

    constant playerunitevent EVENT_PLAYER_UNIT_ATTACKED                 = ConvertPlayerUnitEvent(13)
    constant playerunitevent EVENT_PLAYER_UNIT_RESCUED                  = ConvertPlayerUnitEvent(14)

    constant playerunitevent EVENT_PLAYER_UNIT_DEATH                    = ConvertPlayerUnitEvent(15)
    constant playerunitevent EVENT_PLAYER_UNIT_DECAY                    = ConvertPlayerUnitEvent(16)

    constant playerunitevent EVENT_PLAYER_UNIT_DETECTED                 = ConvertPlayerUnitEvent(17)
    constant playerunitevent EVENT_PLAYER_UNIT_HIDDEN                   = ConvertPlayerUnitEvent(18)

    constant playerunitevent EVENT_PLAYER_UNIT_SELECTED                 = ConvertPlayerUnitEvent(19)
    constant playerunitevent EVENT_PLAYER_UNIT_DESELECTED               = ConvertPlayerUnitEvent(20)

    constant playerunitevent EVENT_PLAYER_UNIT_CONSTRUCT_START          = ConvertPlayerUnitEvent(21)
    constant playerunitevent EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL         = ConvertPlayerUnitEvent(22)
    constant playerunitevent EVENT_PLAYER_UNIT_CONSTRUCT_FINISH         = ConvertPlayerUnitEvent(23)

    constant playerunitevent EVENT_PLAYER_UNIT_UPGRADE_START            = ConvertPlayerUnitEvent(24)
    constant playerunitevent EVENT_PLAYER_UNIT_UPGRADE_CANCEL           = ConvertPlayerUnitEvent(25)
    constant playerunitevent EVENT_PLAYER_UNIT_UPGRADE_FINISH           = ConvertPlayerUnitEvent(26)

    constant playerunitevent EVENT_PLAYER_UNIT_TRAIN_START              = ConvertPlayerUnitEvent(27)
    constant playerunitevent EVENT_PLAYER_UNIT_TRAIN_CANCEL             = ConvertPlayerUnitEvent(28)
    constant playerunitevent EVENT_PLAYER_UNIT_TRAIN_FINISH             = ConvertPlayerUnitEvent(29)

    constant playerunitevent EVENT_PLAYER_UNIT_RESEARCH_START           = ConvertPlayerUnitEvent(30)
    constant playerunitevent EVENT_PLAYER_UNIT_RESEARCH_CANCEL          = ConvertPlayerUnitEvent(31)
    constant playerunitevent EVENT_PLAYER_UNIT_RESEARCH_FINISH          = ConvertPlayerUnitEvent(32)

    constant playerunitevent EVENT_PLAYER_UNIT_ISSUED_ORDER             = ConvertPlayerUnitEvent(33)
    constant playerunitevent EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER       = ConvertPlayerUnitEvent(34)
    constant playerunitevent EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER        = ConvertPlayerUnitEvent(35)

    constant playerunitevent EVENT_PLAYER_HERO_LEVEL                    = ConvertPlayerUnitEvent(36)
    constant playerunitevent EVENT_PLAYER_HERO_REVIVABLE                = ConvertPlayerUnitEvent(37)

    constant playerunitevent EVENT_PLAYER_HERO_REVIVE_START             = ConvertPlayerUnitEvent(38)
    constant playerunitevent EVENT_PLAYER_HERO_REVIVE_CANCEL            = ConvertPlayerUnitEvent(39)
    constant playerunitevent EVENT_PLAYER_HERO_REVIVE_FINISH            = ConvertPlayerUnitEvent(40)

    //===================================================
    // For use with TriggerRegisterUnitEvent
    //===================================================

    constant unitevent EVENT_UNIT_DAMAGED                         = ConvertUnitEvent(41)
    constant unitevent EVENT_UNIT_DEATH                           = ConvertUnitEvent(42)
    constant unitevent EVENT_UNIT_DECAY                           = ConvertUnitEvent(43)

    constant unitevent EVENT_UNIT_DETECTED                        = ConvertUnitEvent(44)
    constant unitevent EVENT_UNIT_HIDDEN                          = ConvertUnitEvent(45)

    constant unitevent EVENT_UNIT_SELECTED                        = ConvertUnitEvent(46)
    constant unitevent EVENT_UNIT_DESELECTED                      = ConvertUnitEvent(47)

    constant unitevent EVENT_UNIT_STATE_LIMIT                     = ConvertUnitEvent(48)
    
    // Events which may have a filter for the "other unit"
    //
    constant unitevent EVENT_UNIT_ACQUIRED_TARGET                 = ConvertUnitEvent(49)
    constant unitevent EVENT_UNIT_TARGET_IN_RANGE                 = ConvertUnitEvent(50)
    constant unitevent EVENT_UNIT_ATTACKED                        = ConvertUnitEvent(51)
    constant unitevent EVENT_UNIT_RESCUED                         = ConvertUnitEvent(52)

    constant unitevent EVENT_UNIT_CONSTRUCT_CANCEL                = ConvertUnitEvent(53)
    constant unitevent EVENT_UNIT_CONSTRUCT_FINISH                = ConvertUnitEvent(54)

    constant unitevent EVENT_UNIT_UPGRADE_START                   = ConvertUnitEvent(55)
    constant unitevent EVENT_UNIT_UPGRADE_CANCEL                  = ConvertUnitEvent(56)
    constant unitevent EVENT_UNIT_UPGRADE_FINISH                  = ConvertUnitEvent(57)

    // Events which involve the specified unit performing
    // training of other units
    //
    constant unitevent EVENT_UNIT_TRAIN_START                     = ConvertUnitEvent(58)
    constant unitevent EVENT_UNIT_TRAIN_CANCEL                    = ConvertUnitEvent(59)
    constant unitevent EVENT_UNIT_TRAIN_FINISH                    = ConvertUnitEvent(60)

    constant unitevent EVENT_UNIT_RESEARCH_START                  = ConvertUnitEvent(61)
    constant unitevent EVENT_UNIT_RESEARCH_CANCEL                 = ConvertUnitEvent(62)
    constant unitevent EVENT_UNIT_RESEARCH_FINISH                 = ConvertUnitEvent(63)

    constant unitevent EVENT_UNIT_ISSUED_ORDER                    = ConvertUnitEvent(64)
    constant unitevent EVENT_UNIT_ISSUED_POINT_ORDER              = ConvertUnitEvent(65)
    constant unitevent EVENT_UNIT_ISSUED_UNIT_ORDER               = ConvertUnitEvent(66)

    constant unitevent EVENT_UNIT_HERO_LEVEL                      = ConvertUnitEvent(67)
    constant unitevent EVENT_UNIT_HERO_REVIVABLE                  = ConvertUnitEvent(68)

    constant unitevent EVENT_UNIT_HERO_REVIVE_START               = ConvertUnitEvent(69)
    constant unitevent EVENT_UNIT_HERO_REVIVE_CANCEL              = ConvertUnitEvent(70)
    constant unitevent EVENT_UNIT_HERO_REVIVE_FINISH              = ConvertUnitEvent(71)

    //===================================================
    // Limit Event API constants    
    // variable, player state, game state, and unit state events
    // ( do NOT change the order of these... )
    //===================================================
    constant limitop LESS_THAN                              = ConvertLimitOp(0)
    constant limitop LESS_THAN_OR_EQUAL                     = ConvertLimitOp(1)
    constant limitop EQUAL                                  = ConvertLimitOp(2)
    constant limitop GREATER_THAN_OR_EQUAL                  = ConvertLimitOp(3)
    constant limitop GREATER_THAN                           = ConvertLimitOp(4)
    constant limitop NOT_EQUAL                              = ConvertLimitOp(5)

//===================================================
// Unit Type Constants for use with IsUnitType()
//===================================================

    constant unittype UNIT_TYPE_HERO                        = ConvertUnitType(0)
    constant unittype UNIT_TYPE_DEAD                        = ConvertUnitType(1)
    constant unittype UNIT_TYPE_STRUCTURE                   = ConvertUnitType(2)

    constant unittype UNIT_TYPE_FLYING                      = ConvertUnitType(3)
    constant unittype UNIT_TYPE_GROUND                      = ConvertUnitType(4)

    constant unittype UNIT_TYPE_ATTACKS_FLYING              = ConvertUnitType(5)
    constant unittype UNIT_TYPE_ATTACKS_GROUND              = ConvertUnitType(6)

    constant unittype UNIT_TYPE_MELEE_ATTACKER              = ConvertUnitType(7)
    constant unittype UNIT_TYPE_RANGED_ATTACKER             = ConvertUnitType(8)

    constant unittype UNIT_TYPE_GIANT                       = ConvertUnitType(9)
    constant unittype UNIT_TYPE_SUMMONED                    = ConvertUnitType(10)
    constant unittype UNIT_TYPE_STUNNED                     = ConvertUnitType(11)
    constant unittype UNIT_TYPE_PLAGUED                     = ConvertUnitType(12)
    constant unittype UNIT_TYPE_SNARED                      = ConvertUnitType(13)

//===================================================
// Animatable Camera Fields
//===================================================

    constant camerafield CAMERA_FIELD_TARGET_DISTANCE       = ConvertCameraField(0)
    constant camerafield CAMERA_FIELD_FARZ                  = ConvertCameraField(1)
    constant camerafield CAMERA_FIELD_ANGLE_OF_ATTACK       = ConvertCameraField(2)
    constant camerafield CAMERA_FIELD_FIELD_OF_VIEW         = ConvertCameraField(3)
    constant camerafield CAMERA_FIELD_ROLL                  = ConvertCameraField(4)
    constant camerafield CAMERA_FIELD_ROTATION              = ConvertCameraField(5)
    constant camerafield CAMERA_FIELD_ZOFFSET               = ConvertCameraField(6)

    constant materialid  MATERIAL_ID_UNIT_COLOR             = ConvertMaterialId(0)
    constant materialid  MATERIAL_ID_TEAM_COLOR             = ConvertMaterialId(1)
    constant materialid  MATERIAL_ID_TEAM_GLOW              = ConvertMaterialId(2)

    constant blendmode   BLEND_MODE_NONE                    = ConvertBlendMode(0)
    constant blendmode   BLEND_MODE_DONT_CARE               = ConvertBlendMode(0)
    constant blendmode   BLEND_MODE_KEYALPHA                = ConvertBlendMode(1)
    constant blendmode   BLEND_MODE_BLEND                   = ConvertBlendMode(2)
    constant blendmode   BLEND_MODE_ADDITIVE                = ConvertBlendMode(3)
    constant blendmode   BLEND_MODE_MODULATE                = ConvertBlendMode(4)
    constant blendmode   BLEND_MODE_MODULATE_2X             = ConvertBlendMode(5)
    
    constant raritycontrol  RARITY_FREQUENT                 = ConvertRarityControl(0)
    constant raritycontrol  RARITY_RARE                     = ConvertRarityControl(1)

    constant texmapflags    TEXMAP_FLAG_NONE                = ConvertTexMapFlags(0)
    constant texmapflags    TEXMAP_FLAG_WRAP_U              = ConvertTexMapFlags(1)
    constant texmapflags    TEXMAP_FLAG_WRAP_V              = ConvertTexMapFlags(2)
    constant texmapflags    TEXMAP_FLAG_WRAP_UV             = ConvertTexMapFlags(3)

    constant fogstate       FOG_OF_WAR_MASKED               = ConvertFogState(1)
    constant fogstate       FOG_OF_WAR_FOGGED               = ConvertFogState(2)
    constant fogstate       FOG_OF_WAR_VISIBLE              = ConvertFogState(4)

endglobals

//============================================================================
// MathAPI
native Deg2Rad  takes real degrees returns real
native Rad2Deg  takes real radians returns real

native Sin      takes real radians returns real
native Cos      takes real radians returns real
native Tan      takes real radians returns real

// Expect values between -1 and 1...returns 0 for invalid input
native Asin     takes real y returns real
native Acos     takes real x returns real

native Atan     takes real x returns real

// Returns 0 if x and y are both 0
native Atan2    takes real y, real x returns real

// Returns 0 if x <= 0
native SquareRoot takes real x returns real

// computes x to the y power
// y == 0.0             => 1
// x ==0.0 and y < 0    => 0
//
native Pow      takes real x, real power returns real

//============================================================================
// String Utility API
native I2R  takes integer i returns real
native R2I  takes real r returns integer
native I2S  takes integer i returns string
native R2S  takes real r returns string
native R2SW takes real r, integer width, integer precision returns string
native S2I  takes string s returns integer
native S2R  takes string s returns real
native SubString takes string source, integer start, integer end returns string

//============================================================================
// Map Setup API
//
//  These are native functions for describing the map configuration
//  these funcs should only be used in the "config" function of
//  a map script. The functions should also be called in this order
//  ( i.e. call SetPlayers before SetPlayerColor...
//

native SetMapName           takes string name returns nothing
native SetMapDescription    takes string description returns nothing

native SetTeams             takes integer teamcount returns nothing
native SetPlayers           takes integer playercount returns nothing

native DefineStartLocation      takes integer whichStartLoc, real x, real y returns nothing
native DefineStartLocationLoc   takes integer whichStartLoc, location whichLocation returns nothing
native SetStartLocPrioCount     takes integer whichStartLoc, integer prioSlotCount returns nothing
native SetStartLocPrio          takes integer whichStartLoc, integer prioSlotIndex, integer otherStartLocIndex, startlocprio priority returns nothing
native GetStartLocPrioSlot      takes integer whichStartLoc, integer prioSlotIndex returns integer
native GetStartLocPrio          takes integer whichStartLoc, integer prioSlotIndex returns startlocprio

native SetGameTypeSupported takes gametype whichGameType, boolean value returns nothing
native SetMapFlag           takes mapflag whichMapFlag, boolean value returns nothing
native SetGamePlacement     takes placement whichPlacementType returns nothing
native SetGameSpeed         takes gamespeed whichspeed returns nothing
native SetGameDifficulty    takes gamedifficulty whichdifficulty returns nothing
native SetResourceDensity   takes mapdensity whichdensity returns nothing
native SetCreatureDensity   takes mapdensity whichdensity returns nothing

native GetTeams             takes nothing returns integer
native GetPlayers           takes nothing returns integer

native IsGameTypeSupported  takes gametype whichGameType returns boolean
native GetGameTypeSelected  takes nothing returns gametype
native IsMapFlagSet         takes mapflag whichMapFlag returns boolean

constant native GetGamePlacement     takes nothing returns placement
constant native GetGameSpeed         takes nothing returns gamespeed
constant native GetGameDifficulty    takes nothing returns gamedifficulty
constant native GetResourceDensity   takes nothing returns mapdensity
constant native GetCreatureDensity   takes nothing returns mapdensity
constant native GetStartLocationX    takes integer whichStartLocation returns real
constant native GetStartLocationY    takes integer whichStartLocation returns real
constant native GetStartLocationLoc  takes integer whichStartLocation returns location


native SetPlayerTeam            takes player whichPlayer, integer whichTeam returns nothing
native SetPlayerStartLocation   takes player whichPlayer, integer startLocIndex returns nothing
// forces player to have the specified start loc and marks the start loc as occupied
// which removes it from consideration for subsequently placed players
// ( i.e. you can use this to put people in a fixed loc and then
//   use random placement for any unplaced players etc )
native ForcePlayerStartLocation takes player whichPlayer, integer startLocIndex returns nothing 
native SetPlayerColor           takes player whichPlayer, playercolor color returns nothing
native SetPlayerAlliance        takes player sourcePlayer, player otherPlayer, alliancetype whichAllianceSetting, boolean value returns nothing
native SetPlayerTaxRate         takes player sourcePlayer, player otherPlayer, playerstate whichResource, integer rate returns nothing
native SetPlayerRacePreference  takes player whichPlayer, racepreference whichRacePreference returns nothing
native SetPlayerRaceSelectable  takes player whichPlayer, boolean value returns nothing
native SetPlayerController      takes player whichPlayer, mapcontrol controlType returns nothing

native GetPlayerTeam            takes player whichPlayer returns integer
native GetPlayerStartLocation   takes player whichPlayer returns integer
native GetPlayerColor           takes player whichPlayer returns playercolor
native GetPlayerSelectable      takes player whichPlayer returns boolean
native GetPlayerController      takes player whichPlayer returns mapcontrol
native GetPlayerSlotState       takes player whichPlayer returns playerslotstate
native GetPlayerTaxRate         takes player sourcePlayer, player otherPlayer, playerstate whichResource returns integer
native IsPlayerRacePrefSet      takes player whichPlayer, racepreference pref returns boolean

//============================================================================
// Timer API
//
native CreateTimer          takes nothing returns timer
native DestroyTimer         takes timer whichTimer returns nothing
native TimerStart           takes timer whichTimer, real timeout, boolean periodic, code handlerFunc returns nothing
native TimerGetElapsed      takes timer whichTimer returns real
native TimerGetRemaining    takes timer whichTimer returns real
native TimerGetTimeout      takes timer whichTimer returns real

//============================================================================
// Group API
//
native CreateGroup                          takes nothing returns group
native GroupAddUnit                         takes group whichGroup, unit whichUnit returns nothing
native GroupRemoveUnit                      takes group whichGroup, unit whichUnit returns nothing
native GroupClear                           takes group whichGroup returns nothing
native GroupEnumUnitsOfType                 takes group whichGroup, string unitname, boolexpr filter returns nothing
native GroupEnumUnitsOfPlayer               takes group whichGroup, player whichPlayer, boolexpr filter returns nothing
native GroupEnumUnitsOfTypeCounted          takes group whichGroup, string unitname, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsInRect                 takes group whichGroup, rect r, boolexpr filter returns nothing
native GroupEnumUnitsInRectCounted          takes group whichGroup, rect r, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsInRange                takes group whichGroup, real x, real y, real radius, boolexpr filter returns nothing
native GroupEnumUnitsInRangeOfLoc           takes group whichGroup, location whichLocation, real radius, boolexpr filter returns nothing
native GroupEnumUnitsInRangeCounted         takes group whichGroup, real x, real y, real radius, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsInRangeOfLocCounted    takes group whichGroup, location whichLocation, real radius, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsSelected               takes group whichGroup, player whichPlayer, boolexpr filter returns nothing

// This will be difficult to support with potentially disjoint, cell-based regions
// as it would involve enumerating all the cells that are covered by a particularregion
// a better imlementation would be a trigger that adds relevant units as they enter
// and removes them if they leave...
//native GroupEnumUnitsInRegion takes group whichGroup, region whichRegion, boolexpr filter returns nothing
//native GroupEnumUnitsInRegionCounted takes group whichGroup, region whichRegion, boolexpr filter, integer countLimit returns nothing
native ForGroup                 takes group whichGroup, code callback returns nothing
native FirstOfGroup             takes group whichGroup returns unit

//============================================================================
// Force API
//
native CreateForce              takes nothing returns force
native ForceAddPlayer           takes force whichForce, player whichPlayer returns nothing
native ForceRemovePlayer        takes force whichForce, player whichPlayer returns nothing
native ForceClear               takes force whichForce returns nothing
native ForceEnumPlayers         takes force whichForce, boolexpr filter returns nothing
native ForceEnumPlayersCounted  takes force whichForce, boolexpr filter, integer countLimit returns nothing
native ForceEnumAllies          takes force whichForce, player whichPlayer, boolexpr filter returns nothing
native ForceEnumEnemies         takes force whichForce, player whichPlayer, boolexpr filter returns nothing
native ForForce                 takes force whichForce, code callback returns nothing

//============================================================================
// Region and Location API
//
native Rect                     takes real minx, real miny, real maxx, real maxy returns rect
native RectFromLoc              takes location min, location max returns rect
native RemoveRect               takes rect whichRect returns nothing
native SetRect                  takes rect whichRect, real minx, real miny, real maxx, real maxy returns nothing
native SetRectFromLoc           takes rect whichRect, location min, location max returns nothing
native MoveRectTo               takes rect whichRect, real newCenterX, real newCenterY returns nothing
native MoveRectToLoc            takes rect whichRect, location newCenterLoc returns nothing

native GetRectCenterX           takes rect whichRect returns real
native GetRectCenterY           takes rect whichRect returns real
native GetRectMinX              takes rect whichRect returns real
native GetRectMinY              takes rect whichRect returns real
native GetRectMaxX              takes rect whichRect returns real
native GetRectMaxY              takes rect whichRect returns real

native CreateRegion             takes nothing returns region
native RemoveRegion             takes region whichRegion returns nothing

native RegionAddRect            takes region whichRegion, rect r returns nothing
native RegionClearRect          takes region whichRegion, rect r returns nothing

native RegionAddCell           takes region whichRegion, real x, real y returns nothing
native RegionAddCellAtLoc      takes region whichRegion, location whichLocation returns nothing
native RegionClearCell         takes region whichRegion, real x, real y returns nothing
native RegionClearCellAtLoc    takes region whichRegion, location whichLocation returns nothing

native Location                 takes real x, real y returns location
native RemoveLocation           takes location whichLocation returns nothing
native MoveLocation             takes location whichLocation, real newX, real newY returns nothing
native GetLocationX             takes location whichLocation returns real
native GetLocationY             takes location whichLocation returns real   

native IsUnitInRegion               takes region whichRegion, unit whichUnit returns boolean
native IsPointInRegion              takes region whichRegion, real x, real y returns boolean
native IsLocationInRegion           takes region whichRegion, location whichLocation returns boolean

//============================================================================
// Native trigger interface
//
native CreateTrigger    takes nothing returns trigger
native DestroyTrigger   takes trigger whichTrigger returns nothing
native ResetTrigger     takes trigger whichTrigger returns nothing
native EnableTrigger    takes trigger whichTrigger returns nothing
native DisableTrigger   takes trigger whichTrigger returns nothing
native IsTriggerEnabled takes trigger whichTrigger returns boolean

constant native GetFilterUnit       takes nothing returns unit
constant native GetEnumUnit         takes nothing returns unit

constant native GetFilterDestructable   takes nothing returns destructable
constant native GetEnumDestructable     takes nothing returns destructable

constant native GetFilterPlayer     takes nothing returns player
constant native GetEnumPlayer       takes nothing returns player

constant native GetTriggeringTrigger    takes nothing returns trigger
constant native GetTriggerEventId       takes nothing returns eventid
constant native GetTriggerEvalCount     takes trigger whichTrigger returns integer
constant native GetTriggerExecCount     takes trigger whichTrigger returns integer

//============================================================================
// Boolean Expr API ( for compositing trigger conditions and unit filter funcs...)
//============================================================================
native And          takes boolexpr operandA, boolexpr operandB returns boolexpr
native Or           takes boolexpr operandA, boolexpr operandB returns boolexpr
native Not          takes boolexpr operand returns boolexpr
native Condition    takes code func returns conditionfunc
native Filter       takes code func returns filterfunc

//============================================================================
// Trigger Game Event API
//============================================================================

native TriggerRegisterVariableEvent takes trigger whichTrigger, string varName, limitop opcode, real limitval returns event

    // EVENT_GAME_VARIABLE_LIMIT
    //constant native string GetTriggeringVariableName takes nothing returns string

native TriggerRegisterTimerEvent takes trigger whichTrigger, real timeout, boolean periodic returns event

    // EVENT_GAME_TIMER_EXPIRED
    // Does this mean we need a IsSameTimer( timer, timer ) ?
    // constant native GetTimerEvent takes nothing returns event

native TriggerRegisterGameStateEvent takes trigger whichTrigger, gamestate whichState, limitop opcode, real limitval returns event

//  EVENT_GAME_STATE_LIMIT
constant native GetEventGameState takes nothing returns gamestate

native TriggerRegisterGameEvent takes trigger whichTrigger, gameevent whichGameEvent returns event
  
// EVENT_GAME_VICTORY
constant native GetWinningPlayer takes nothing returns player


native TriggerRegisterEnterRegion takes trigger whichTrigger, region whichRegion, boolexpr filter returns event

// EVENT_GAME_ENTER_REGION
constant native GetTriggeringRegion takes nothing returns region
constant native GetEnteringUnit takes nothing returns unit

// EVENT_GAME_LEAVE_REGION

native TriggerRegisterLeaveRegion takes trigger whichTrigger, region whichRegion, boolexpr filter returns event
constant native GetLeavingUnit takes nothing returns unit


//============================================================================
// Trigger Player Based Event API
//============================================================================

native TriggerRegisterPlayerEvent takes trigger whichTrigger, player  whichPlayer, playerevent whichPlayerEvent returns event

// EVENT_PLAYER_DEFEAT
// EVENT_PLAYER_VICTORY
constant native GetTriggerPlayer takes nothing returns player

native TriggerRegisterPlayerUnitEvent takes trigger whichTrigger, player whichPlayer, playerunitevent whichPlayerUnitEvent, boolexpr filter returns event

// EVENT_PLAYER_HERO_LEVEL
// EVENT_UNIT_HERO_LEVEL
constant native GetLevelingUnit takes nothing returns unit

// EVENT_PLAYER_HERO_REVIVABLE
constant native GetRevivableUnit takes nothing returns unit

// EVENT_PLAYER_HERO_REVIVE_START
// EVENT_PLAYER_HERO_REVIVE_CANCEL
// EVENT_PLAYER_HERO_REVIVE_FINISH
// EVENT_UNIT_HERO_REVIVE_START
// EVENT_UNIT_HERO_REVIVE_CANCEL
// EVENT_UNIT_HERO_REVIVE_FINISH
constant native GetRevivingUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_ATTACKED
constant native GetAttacker takes nothing returns unit

// EVENT_PLAYER_UNIT_RESCUED
constant native GetRescuer  takes nothing returns unit

// EVENT_PLAYER_UNIT_DEATH
constant native GetDyingUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_DECAY
constant native GetDecayingUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_SELECTED
//constant native GetSelectedUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_CONSTRUCT_START
constant native GetConstructingStructure takes nothing returns unit

// EVENT_PLAYER_UNIT_CONSTRUCT_FINISH
// EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL
constant native GetCancelledStructure takes nothing returns unit
constant native GetConstructedStructure takes nothing returns unit

// EVENT_PLAYER_UNIT_RESEARCH_START
// EVENT_PLAYER_UNIT_RESEARCH_CANCEL
// EVENT_PLAYER_UNIT_RESEARCH_FINISH
constant native GetResearchingUnit takes nothing returns unit
constant native GetResearched takes nothing returns integer

// EVENT_PLAYER_UNIT_TRAIN_START
// EVENT_PLAYER_UNIT_TRAIN_CANCEL
constant native GetTrainedUnitType takes nothing returns integer

// EVENT_PLAYER_UNIT_TRAIN_FINISH
constant native GetTrainedUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_DETECTED
constant native GetDetectedUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_ISSUED_ORDER
constant native GetOrderedUnit takes nothing returns unit
constant native GetIssuedOrderId takes nothing returns integer

// EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER
constant native GetOrderPointX takes nothing returns real
constant native GetOrderPointY takes nothing returns real
constant native GetOrderPointLoc takes nothing returns location

// EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER
constant native GetOrderTargetUnit takes nothing returns unit

native TriggerRegisterPlayerAllianceChange takes trigger whichTrigger, player whichPlayer, alliancetype whichAlliance returns event
native TriggerRegisterPlayerStateEvent takes trigger whichTrigger, player whichPlayer, playerstate whichState, limitop opcode, real limitval returns event

// EVENT_PLAYER_STATE_LIMIT
constant native GetEventPlayerState takes nothing returns playerstate

native TriggerRegisterPlayerChatEvent takes trigger whichTrigger, player whichPlayer, string chatMessageToDetect, boolean exactMatchOnly returns event

// EVENT_PLAYER_CHAT

// returns the actual string they typed in ( same as what you registered for
// if you required exact match )
constant native GetEventPlayerChatString takes nothing returns string

// returns the string that you registered for
constant native GetEventPlayerChatStringMatched takes nothing returns string

//============================================================================
// Trigger Unit Based Event API
//============================================================================

// returns handle to unit which triggered the most recent event when called from
// within a trigger action function...returns null handle when used incorrectly

constant native GetTriggerUnit takes nothing returns unit

native TriggerRegisterUnitStateEvent takes trigger whichTrigger, unit whichUnit, unitstate whichState, limitop opcode, real limitval returns event

// EVENT_UNIT_STATE_LIMIT
constant native GetEventUnitState takes nothing returns unitstate

native TriggerRegisterUnitEvent takes trigger whichTrigger, unit whichUnit, unitevent whichEvent returns event

// EVENT_UNIT_DAMAGED
constant native GetEventDamage takes nothing returns real

// EVENT_UNIT_DEATH
// EVENT_UNIT_DECAY
// Use the GetDyingUnit and GetDecayingUnit funcs above

// EVENT_UNIT_DETECTED 
constant native GetEventDetectingPlayer takes nothing returns player

native TriggerRegisterFilterUnitEvent takes trigger whichTrigger, unit whichUnit, unitevent whichEvent, boolexpr filter returns event

// EVENT_UNIT_ACQUIRED_TARGET
// EVENT_UNIT_TARGET_IN_RANGE
constant native GetEventTargetUnit takes nothing returns unit

// EVENT_UNIT_ATTACKED
// Use GetAttacker from the Player Unit Event API Below...

// EVENT_UNIT_RESCUEDED
// Use GetRescuer from the Player Unit Event API Below...

// EVENT_UNIT_CONSTRUCT_CANCEL
// EVENT_UNIT_CONSTRUCT_FINISH

// See the Player Unit Construction Event API above for event info funcs

// EVENT_UNIT_TRAIN_START
// EVENT_UNIT_TRAIN_CANCELLED
// EVENT_UNIT_TRAIN_FINISH

// See the Player Unit Training Event API above for event info funcs

// EVENT_UNIT_ISSUED_ORDER
// EVENT_UNIT_ISSUED_POINT_ORDER
// EVENT_UNIT_ISSUED_UNIT_ORDER

// See the Player Unit Order Event API above for event info funcs

native TriggerRegisterUnitInRange takes trigger whichTrigger, unit whichUnit, real range, boolexpr filter returns event

native TriggerAddCondition    takes trigger whichTrigger, boolexpr condition returns triggercondition
native TriggerRemoveCondition takes trigger whichTrigger, triggercondition whichCondition returns nothing
native TriggerClearConditions takes trigger whichTrigger returns nothing

native TriggerAddAction    takes trigger whichTrigger, code actionFunc returns triggeraction
native TriggerRemoveAction takes trigger whichTrigger, triggeraction whichAction returns nothing
native TriggerClearActions takes trigger whichTrigger returns nothing
native TriggerSleepAction  takes real timeout returns nothing
native TriggerEvaluate takes trigger whichTrigger returns boolean
native TriggerExecute  takes trigger whichTrigger returns nothing

//============================================================================
// Destructable Object API
// Facing arguments are specified in degrees
native          CreateDestructable          takes integer objectid, real x, real y, real face, real scale, integer variation returns destructable
native          RemoveDestructable          takes destructable d returns nothing
native          KillDestructable            takes destructable d returns nothing
native          SetDestructableInvulnerable takes destructable d, boolean flag returns nothing
native          IsDestructableInvulnerable  takes destructable d returns boolean
native          EnumDestructablesInRect     takes rect r, boolexpr filter, code actionFunc returns nothing
native          GetDestructableTypeId       takes destructable d returns integer
native          GetDestructableX            takes destructable d returns real
native          GetDestructableY            takes destructable d returns real
native          SetDestructableLife         takes destructable d, real life returns nothing
native          GetDestructableLife         takes destructable d returns real

//============================================================================
// Item API
native          CreateItem      takes integer itemid, real x, real y returns item
native          RemoveItem      takes item whichItem returns nothing
native          GetItemTypeId   takes item i returns integer
native          GetItemX        takes item i returns real
native          GetItemY        takes item i returns real
native          SetItemPosition takes item i, real x, real y returns nothing
native          SetItemDroppable takes item i, boolean flag returns nothing

//============================================================================
// Unit API
// Facing arguments are specified in degrees
native          CreateUnit              takes player id, integer unitid, real x, real y, real face returns unit
native          CreateUnitByName        takes player whichPlayer, string unitname, real x, real y, real face returns unit
native          CreateUnitAtLoc         takes player id, integer unitid, location whichLocation, real face returns unit
native          CreateUnitAtLocByName   takes player id, string unitname, location whichLocation, real face returns unit

native          KillUnit            takes unit whichUnit returns nothing
native          RemoveUnit          takes unit whichUnit returns nothing
native          SetUnitState        takes unit whichUnit, unitstate whichUnitState, real newVal returns nothing
native          SetUnitX            takes unit whichUnit, real newX returns nothing
native          SetUnitY            takes unit whichUnit, real newY returns nothing
native          SetUnitPosition     takes unit whichUnit, real newX, real newY returns nothing
native          SetUnitPositionLoc  takes unit whichUnit, location whichLocation returns nothing
native          SetUnitFacing       takes unit whichUnit, real facingAngle returns nothing
native          SetUnitMoveSpeed    takes unit whichUnit, real newSpeed returns nothing

native          GetUnitAcquireRange takes unit whichUnit returns real
native          GetUnitDefaultAcquireRange takes unit whichUnit returns real
native          SetUnitAcquireRange takes unit whichUnit, real newAcquireRange returns nothing

native          SetUnitOwner        takes unit whichUnit, player whichPlayer, boolean changeColor returns nothing
native          SetUnitColor        takes unit whichUnit, playercolor whichColor returns nothing

native          SetUnitScale        takes unit whichUnit, real scaleX, real scaleY, real scaleZ returns nothing
native          SetUnitTimeScale    takes unit whichUnit, real timeScale returns nothing
native          SetUnitVertexColor  takes unit whichUnit, integer red, integer green, integer blue, integer alpha returns nothing

native          SetUnitAnimation            takes unit whichUnit, string whichAnimation returns nothing
native          SetUnitAnimationByIndex     takes unit whichUnit, integer whichAnimation returns nothing
native          SetUnitAnimationWithRarity  takes unit whichUnit, string whichAnimation, raritycontrol rarity returns nothing

native          SetUnitLookAt       takes unit whichUnit, string whichBone, unit lookAtTarget, real offsetX, real offsetY, real offsetZ returns nothing
native          ResetUnitLookAt     takes unit whichUnit returns nothing

native          SetUnitRescuable    takes unit whichUnit, player byWhichPlayer, boolean flag returns nothing
native          SetUnitRescueRange  takes unit whichUnit, real range returns nothing

native          SetHeroXP           takes unit whichHero, integer newXpVal,  boolean showEyeCandy returns nothing
native          AddHeroXP           takes unit whichHero, integer xpToAdd,   boolean showEyeCandy returns nothing
native          SetHeroLevel        takes unit whichHero, integer level,  boolean showEyeCandy returns nothing
constant native GetHeroLevel        takes unit whichHero returns integer
native          SuspendHeroXP       takes unit whichHero, boolean flag returns nothing
native          IsSuspendedXP       takes unit whichHero returns boolean
native          SelectHeroSkill     takes unit whichHero, integer abilcode returns nothing
native          ReviveHero          takes unit whichHero, real x, real y, boolean doEyecandy returns boolean
native          ReviveHeroLoc       takes unit whichHero, location loc, boolean doEyecandy returns boolean
native          SetUnitInvulnerable takes unit whichUnit, boolean flag returns nothing
native          SetUnitPathing      takes unit whichUnit, boolean flag returns nothing

native          ClearSelection      takes nothing returns nothing
native          SelectUnit          takes unit whichUnit, boolean flag returns nothing

native          GetUnitPointValue       takes unit whichUnit returns integer
native          GetUnitPointValueByType takes integer unitType returns integer
//native        SetUnitPointValueByType takes integer unitType, integer newPointValue returns nothing

native          StoreUnit               takes unit whichUnit, real x, real y, real facing returns nothing
native          UnitAddItem             takes unit whichUnit, item whichItem returns boolean
native          UnitAddItemById         takes unit whichUnit, integer itemId returns item
native          UnitRemoveItem          takes unit whichUnit, item whichItem returns nothing
native          UnitRemoveItemFromSlot  takes unit whichUnit, integer itemSlot returns item
native          UnitHasItem             takes unit whichUnit, item whichItem returns boolean
native          UnitItemInSlot          takes unit whichUnit, integer itemSlot returns item

// This is a truly horrible API for adding texture layers to one or more materials
//
//  the first blendmode parameter specifies how you want the added layer to be blended
//  the texmapflags determines if/how the texture will use wrap modes ( all added texture
//  layers are assumed to use bilinear filtering )
//  the materialid specifies which materials should have the texture layer added to them
//      and works in conjunction with the second blendmode parameter to narrow the
//      search ( i.e. if you only want to add the texture layer to 

native          UnitAddMaterial     takes unit whichUnit, string textureFile, texmapflags tflags, blendmode mode, materialid mat, blendmode modeToAddTo returns nothing
native          UnitRemoveMaterial  takes unit whichUnit, materialid mat, blendmode mode returns nothing
native          UnitShowMaterial    takes unit whichUnit, materialid mat, blendmode mode, boolean show returns nothing

constant native GetUnitX            takes unit whichUnit returns real
constant native GetUnitY            takes unit whichUnit returns real
constant native GetUnitLoc          takes unit whichUnit returns location
constant native GetUnitFacing       takes unit whichUnit returns real
constant native GetUnitMoveSpeed    takes unit whichUnit returns real
constant native GetUnitDefaultMoveSpeed takes unit whichUnit returns real
constant native GetUnitState        takes unit whichUnit, unitstate whichUnitState returns real
constant native GetOwningPlayer     takes unit whichUnit returns player
constant native GetUnitTypeId       takes unit whichUnit returns integer
constant native GetUnitRace         takes unit whichUnit returns race
constant native GetUnitName         takes unit whichUnit returns string

constant native IsUnitInGroup       takes unit whichUnit, group whichGroup returns boolean
constant native IsUnitInForce       takes unit whichUnit, force whichForce returns boolean
constant native IsUnitOwnedByPlayer takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitAlly          takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitEnemy         takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitVisible       takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitDetected      takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitInvisible     takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitFogged        takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitMasked        takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitSelected      takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitRace          takes unit whichUnit, race whichRace returns boolean
constant native IsUnitType          takes unit whichUnit, unittype whichUnitType returns boolean
constant native IsUnit              takes unit whichUnit, unit whichSpecifiedUnit returns boolean
constant native IsUnitInRange       takes unit whichUnit, unit otherUnit, real distance returns boolean
constant native IsUnitInRangeXY     takes unit whichUnit, real x, real y, real distance returns boolean
constant native IsUnitInRangeLoc    takes unit whichUnit, location whichLocation, real distance returns boolean
constant native IsUnitHidden        takes unit whichUnit returns boolean

constant native IsHeroUnitId        takes integer unitId returns boolean

native IssueImmediateOrder          takes unit whichUnit, string order returns boolean
native IssueImmediateOrderById      takes unit whichUnit, integer order returns boolean
native IssuePointOrder              takes unit whichUnit, string order, real x, real y returns boolean
native IssuePointOrderLoc           takes unit whichUnit, string order, location whichLocation returns boolean
native IssuePointOrderById          takes unit whichUnit, integer order, real x, real y returns boolean
native IssuePointOrderByIdLoc       takes unit whichUnit, integer order, location whichLocation returns boolean
native IssueTargetOrder             takes unit whichUnit, string order, unit targetUnit returns boolean
native IssueTargetOrderById         takes unit whichUnit, integer order, unit targetUnit returns boolean
native IssueTargetDestructableOrder takes unit whichUnit, string order, destructable targetDestructable returns boolean
native IssueTargetDestructableOrderById takes unit whichUnit, integer order, destructable targetDestructable returns boolean

native SetResourceAmount            takes unit whichUnit, integer amount returns nothing
native AddResourceAmount            takes unit whichUnit, integer amount returns nothing
native GetResourceAmount            takes unit whichUnit returns integer

//============================================================================
// Player API
constant native Player              takes integer number returns player
constant native GetLocalPlayer      takes nothing returns player
constant native IsPlayerAlly        takes player whichPlayer, player otherPlayer returns boolean
constant native IsPlayerEnemy       takes player whichPlayer, player otherPlayer returns boolean
constant native IsPlayerInForce     takes player whichPlayer, force whichForce returns boolean
constant native IsVisibleToPlayer           takes real x, real y, player whichPlayer returns boolean
constant native IsLocationVisibleToPlayer   takes location whichLocation, player whichPlayer returns boolean
constant native IsFoggedToPlayer            takes real x, real y, player whichPlayer returns boolean
constant native IsLocationFoggedToPlayer    takes location whichLocation, player whichPlayer returns boolean
constant native IsMaskedToPlayer            takes real x, real y, player whichPlayer returns boolean
constant native IsLocationMaskedToPlayer    takes location whichLocation, player whichPlayer returns boolean

constant native GetPlayerRace           takes player whichPlayer returns race
constant native GetPlayerId             takes player whichPlayer returns integer
constant native GetPlayerUnitCount      takes player whichPlayer, boolean includeIncomplete returns integer
constant native GetPlayerTypedUnitCount takes player whichPlayer, string unitName, boolean includeIncomplete, boolean includeUpgrades returns integer
constant native GetPlayerStructureCount takes player whichPlayer, boolean includeIncomplete returns integer
constant native GetPlayerState          takes player whichPlayer, playerstate whichPlayerState returns integer
constant native GetPlayerAlliance       takes player sourcePlayer, player otherPlayer, alliancetype whichAllianceSetting returns boolean

constant native SetPlayerTechMaxAllowed takes player whichPlayer, integer techid, integer maximum returns nothing
constant native GetPlayerTechMaxAllowed takes player whichPlayer, integer techid returns integer
constant native SetPlayerTechResearched takes player whichPlayer, integer techid, integer levels returns nothing
constant native GetPlayerTechResearched takes player whichPlayer, integer techid, boolean specificonly returns boolean
constant native GetPlayerTechCount      takes player whichPlayer, integer techid, boolean specificonly returns integer

native SetPlayerState   takes player whichPlayer, playerstate whichPlayerState, integer value returns nothing
native RemovePlayer     takes player whichPlayer, playergameresult gameResult, string message returns nothing

// There aren't any float player states yet, but when they come...
//native          SetFloatPlayerState     takes player whichPlayer, integer whichPlayerState, real value returns nothing
//constant native GetFloatPlayerState     takes player whichPlayer, integer whichPlayerState return real
// constant native IsRegionVisibleToPlayer    takes player whichPlayer, region whichRegion returns boolean
// constant native IsRegionFoggedToPlayer     takes player whichPlayer, region whichRegion returns boolean
// constant native IsRegionMaskedToPlayer     takes player whichPlayer, region whichRegion returns boolean

//============================================================================
// Fog of War API
native  SetFogStateRect      takes player forWhichPlayer, fogstate whichState, rect where, boolean useSharedVision returns nothing
native  SetFogStateRadius    takes player forWhichPlayer, fogstate whichState, real centerx, real centerY, real radius, boolean useSharedVision returns nothing
native  SetFogStateRadiusLoc takes player forWhichPlayer, fogstate whichState, location center, real radius, boolean useSharedVision returns nothing
native  FogMaskEnable        takes boolean enable returns nothing
native  IsFogMaskEnabled     takes nothing returns boolean
native  FogEnable            takes boolean enable returns nothing
native  IsFogEnabled         takes nothing returns boolean

native CreateFogModifierRect        takes player forWhichPlayer, fogstate whichState, rect where, boolean useSharedVision, boolean afterUnits returns fogmodifier
native CreateFogModifierRadius      takes player forWhichPlayer, fogstate whichState, real centerx, real centerY, real radius, boolean useSharedVision, boolean afterUnits returns fogmodifier
native CreateFogModifierRadiusLoc   takes player forWhichPlayer, fogstate whichState, location center, real radius, boolean useSharedVision, boolean afterUnits returns fogmodifier
native DestroyFogModifier           takes fogmodifier whichFogModifier returns nothing
native FogModifierStart             takes fogmodifier whichFogModifier returns nothing
native FogModifierStop              takes fogmodifier whichFogModifier returns nothing

//============================================================================
// Game API
native          SetFloatGameState   takes fgamestate whichFloatGameState, real value returns nothing
constant native GetFloatGameState   takes fgamestate whichFloatGameState returns real

native          SetIntegerGameState takes igamestate whichIntegerGameState, integer value returns nothing
constant native GetIntegerGameState takes igamestate whichIntegerGameState returns integer

native          EndGame     takes nothing returns nothing
native          ChangeLevel takes string nextLevelScript, playergameresult gameResult, string message returns nothing
native          SyncSelections  takes nothing returns nothing

//============================================================================
// Randomization API
native GetRandomInt takes integer lowBound, integer highBound returns integer
native GetRandomReal takes real lowBound, real highBound returns real

native CreateUnitPool           takes nothing returns unitpool
native DestroyUnitPool          takes unitpool whichPool returns nothing
native UnitPoolAddUnitType      takes unitpool whichPool, integer unitId, real weight returns nothing
native UnitPoolRemoveUnitType   takes unitpool whichPool, integer unitId returns nothing
native PlaceRandomUnit          takes unitpool whichPool, player forWhichPlayer, real x, real y, real facing returns unit

native CreateItemPool           takes nothing returns itempool
native DestroyItemPool          takes itempool whichItemPool returns nothing
native ItemPoolAddItemType      takes itempool whichItemPool, integer itemId, real weight returns nothing
native ItemPoolRemoveItemType   takes itempool whichItemPool, integer itemId returns nothing
native PlaceRandomItem          takes itempool whichItemPool, real x, real y returns item

//============================================================================
// Visual API
native SetTerrainFog            takes real a, real b, real c, real d, real e returns nothing
native SetUnitFog               takes real a, real b, real c, real d, real e returns nothing
native DisplayTextToPlayer      takes player toPlayer, real x, real y, string message returns nothing
native DisplayTimedTextToPlayer takes player toPlayer, real x, real y, real duration, string message returns nothing
native SetDayNightModels        takes string terrainDNCFile, string unitDNCFile returns nothing
native SetSkyModel              takes string skyModelFile returns nothing
native EnableUserControl        takes boolean b returns nothing
native SuspendTimeOfDay         takes boolean b returns nothing
native StartPortraitTalk        takes real duration, integer sequence returns nothing
native StopPortraitTalk         takes nothing returns nothing
native ShowInterface            takes boolean flag, real fadeDuration returns nothing
native PauseGame                takes boolean flag returns nothing
native UnitAddIndicator         takes unit whichUnit, integer red, integer green, integer blue, integer alpha returns nothing
native PingMinimap              takes real x, real y, real duration returns nothing

//============================================================================
// Camera API
native SetCameraPosition            takes real x, real y returns nothing
native SetCameraQuickPosition       takes real x, real y returns nothing
native SetCameraBounds              takes real x1, real y1, real x2, real y2, real x3, real y3, real x4, real y4 returns nothing
native ResetToGameCamera            takes real duration returns nothing
native PanCameraTo                  takes real x, real y returns nothing
native PanCameraToTimed             takes real x, real y, real duration returns nothing
native PanCameraToWithZ             takes real x, real y, real zOffsetDest returns nothing
native PanCameraToTimedWithZ        takes real x, real y, real zOffsetDest, real duration returns nothing
native SetCinematicCamera           takes string cameraModelFile returns nothing
native SetCameraField               takes camerafield whichField, real value, real duration returns nothing
native AdjustCameraField            takes camerafield whichField, real offset, real duration returns nothing
native SetCameraTargetController    takes unit whichUnit, real xoffset, real yoffset, boolean inheritOrientation returns nothing

native CreateCameraSetup                    takes nothing returns camerasetup
native CameraSetupSetField                  takes camerasetup whichSetup, camerafield whichField, real value, real duration returns nothing
native CameraSetupGetField                  takes camerasetup whichSetup, camerafield whichField returns real
native CameraSetupSetDestPosition           takes camerasetup whichSetup, real x, real y, real duration returns nothing
native CameraSetupGetDestPositionLoc        takes camerasetup whichSetup returns location
native CameraSetupGetDestPositionX          takes camerasetup whichSetup returns real
native CameraSetupGetDestPositionY          takes camerasetup whichSetup returns real
native CameraSetupApply                     takes camerasetup whichSetup, boolean doPan, boolean panTimed returns nothing
native CameraSetupApplyWithZ                takes camerasetup whichSetup, real zDestOffset returns nothing
native CameraSetupApplyForceDuration        takes camerasetup whichSetup, boolean doPan, real forceDuration returns nothing
native CameraSetupApplyForceDurationWithZ   takes camerasetup whichSetup, real zDestOffset, real forceDuration returns nothing

native CameraSetTargetNoise             takes real mag, real velocity returns nothing
native CameraSetSourceNoise             takes real mag, real velocity returns nothing

native SetCineFilterTexture             takes string filename returns nothing
native SetCineFilterBlendMode           takes blendmode whichMode returns nothing
native SetCineFilterTexMapFlags         takes texmapflags whichFlags returns nothing
native SetCineFilterStartUV             takes real minu, real minv, real maxu, real maxv returns nothing
native SetCineFilterEndUV               takes real minu, real minv, real maxu, real maxv returns nothing
native SetCineFilterStartColor          takes integer red, integer green, integer blue, integer alpha returns nothing
native SetCineFilterEndColor            takes integer red, integer green, integer blue, integer alpha returns nothing
native SetCineFilterDuration            takes real duration returns nothing
native DisplayCineFilter                takes boolean flag returns nothing
native IsCineFilterDisplayed            takes nothing returns boolean

// These return values for the local players camera only...
constant native GetCameraBoundMinX          takes nothing returns real
constant native GetCameraBoundMinY          takes nothing returns real
constant native GetCameraBoundMaxX          takes nothing returns real
constant native GetCameraBoundMaxY          takes nothing returns real
constant native GetCameraField              takes camerafield whichField returns real
constant native GetCameraTargetPositionX    takes nothing returns real
constant native GetCameraTargetPositionY    takes nothing returns real
constant native GetCameraTargetPositionZ    takes nothing returns real
constant native GetCameraTargetPositionLoc  takes nothing returns location
constant native GetCameraEyePositionX       takes nothing returns real
constant native GetCameraEyePositionY       takes nothing returns real
constant native GetCameraEyePositionZ       takes nothing returns real
constant native GetCameraEyePositionLoc     takes nothing returns location

//============================================================================
// Sound API
//
native NewSoundEnvironment          takes string environmentName returns nothing

native CreateSound                  takes string fileName, boolean looping, boolean is3D, boolean stopwhenoutofrange, integer fadeInRate, integer fadeOutRate, string eaxSetting returns sound
native CreateSoundFromLabel         takes string soundLabel, boolean looping, boolean is3D, boolean stopwhenoutofrange, integer fadeInRate, integer fadeOutRate returns sound
native CreateMIDISound              takes string soundLabel, integer fadeInRate, integer fadeOutRate returns sound
native SetSoundDistanceCutoff       takes sound soundHandle, real cutoff returns nothing
native SetSoundVolume               takes sound soundHandle, integer volume returns nothing
native SetSoundPitch                takes sound soundHandle, real pitch returns nothing

// these calls are only valid if the sound was created with 3d enabled
native SetSoundDistances            takes sound soundHandle, real minDist, real maxDist returns nothing
native SetSoundConeAngles           takes sound soundHandle, real inside, real outside, integer outsideVolume returns nothing
native SetSoundConeOrientation      takes sound soundHandle, real x, real y, real z returns nothing
native SetSoundPosition             takes sound soundHandle, real x, real y, real z returns nothing
native SetSoundVelocity             takes sound soundHandle, real x, real y, real z returns nothing

native StartSound                   takes sound soundHandle returns nothing
native StopSound                    takes sound soundHandle, boolean killWhenDone, boolean fadeOut returns nothing
native KillSoundWhenDone            takes sound soundHandle returns nothing

// Music Interface. Note that if music is disabled, these calls do nothing
native SetMusicVolume               takes integer volume returns nothing
native PlayMusic                    takes string musicFileName returns nothing
native StopMusic                    takes boolean fadeOut returns nothing
native ResumeMusic                  takes nothing returns nothing

//============================================================================
// Weather Effects API
//
native AddWeatherEffect             takes rect where, integer effectID returns weathereffect
native RemoveWeatherEffect          takes weathereffect effect returns nothing
native EnableWeatherEffect          takes weathereffect effect, boolean enable returns nothing

//============================================================================
// Blight API
//
native SetBlight        takes player whichPlayer, real x, real y, real radius, boolean addBlight returns nothing
native SetBlightRect    takes player whichPlayer, rect r, boolean addBlight returns nothing
native SetBlightPoint   takes player whichPlayer, real x, real y, boolean addBlight returns nothing
native SetBlightLoc takes player whichPlayer, location whichLocation, real radius, boolean addBlight returns nothing
native CreateBlightedGoldmine takes player id, real x, real y, real face returns unit

//============================================================================
// Doodad API
//
native SetDoodadAnimation           takes real x, real y, real z, real radius, integer doodadID, boolean nearestOnly, string animName, boolean animRandom returns nothing

//============================================================================
// Computer AI interface
//
native DebugBreak           takes integer id                                returns nothing
native StartMeleeAI         takes player num, string script                 returns nothing
native StartCampaignAI      takes player num, string script                 returns nothing
native CommandAI            takes player num, integer command, integer data returns nothing
native RemoveGuardPosition  takes unit hUnit                                returns nothing

//============================================================================
// Inhouse interface....remove before ship...
native AddPerfLogLabel takes string label returns nothing
native Cheat takes string cheatStr returns nothing