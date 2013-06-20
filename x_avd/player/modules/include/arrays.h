#define CARGO_HOUSES ["Land_Cargo_House_V1_F", "Land_Cargo_House_V2_F"]
#define x_isCargoHouse(obj) (typeOf obj in CARGO_HOUSES)

#define HQ_HOUSES ["Land_Cargo_HQ_V1_F", "Land_Cargo_HQ_V2_F", "Land_MilOffices_V1_F", "Land_i_Barracks_V2_F"]
#define x_isHQHouse(obj) (typeOf obj in HQ_HOUSES)

#define TOWERS ["Land_Cargo_Patrol_V1_F", "Land_Cargo_Patrol_V2_F"]
#define x_isTower(obj) (typeOf obj in TOWERS)

#define FUELS [["Land_dp_bigTank_F", 5000], ["Land_dp_smallTank_F", 3000]]

#define AIRPORT_TOWERS ["Land_Airport_Tower_F"]

#define ITEM_SPAWN_HOUSES ["Land_i_Stone_HouseBig_V1_F", "Land_i_Stone_Shed_V1_F", "Land_Metal_Shed_F", "Land_ToiletBox_F"]

#define CAPTURE_BUILDINGS ["Land_Radar_F"]

#define MARINA_PIERS ["Land_Pier_F"]

#define FLAG_EAST "Land_LampHalogen_F"
#define FLAG_WEST "Land_LampHalogen_F"
#define FLAG_GUER "Land_LampHalogen_F"
#define FLAG_CIV "Land_LampHalogen_F"


#define NORMAL_SPAWN [["FirstAidKit", 0.9], ["Chemlight_green", 0.8], ["Chemlight_red", 0.8], ["Chemlight_blue", 0.8], ["Chemlight_yellow", 0.8], ["SmokeShell", 0.7], ["SmokeShellRed", 0.7], ["SmokeShellGreen", 0.7], ["SmokeShellYellow", 0.7], ["V_BandollierB_cbr", 0.6], ["U_B_CombatUniform_mcam_tshirt", 0.25], ["U_O_CombatUniform_ocamo", 0.25], ["V_PlateCarrierGL_rgr", 0.3],  ["16Rnd_9x21_Mag", 0.5], ["acc_flashlight", 0.4], ["hgun_Rook40_F", 0.3], ["Binocular", 0.3], ["hgun_P07_F", 0.3], ["B_AssaultPack_mcamo", 0.25], ["ItemMap", 0.2], ["B_AssaultPack_blk", 0.2], ["muzzle_snds_L", 0.2], ["arifle_SUD_AK105", 0.1], ["30rnd_545x39_AK107", 0.1], ["B_Kitbag_mcamo", 0.15]]

#define RARE_SPAWN [["ARP_Objects_smartphone_m", 0.1], ["ARP_Objects_Toughbook_M", 0.1], ["G_Diving", 0.5], ["30Rnd_65x39_caseless_mag", 0.4], ["arifle_SUD_AK107_GL", 0.6], ["30rnd_545x39_AK107", 0.65], ["20Rnd_762x51_Mag", 0.3], ["V_HarnessOGL_brn", 0.05], ["U_B_Wetsuit", 0.07], ["ARP_Objects_satbag_m", 0.1], ["1Rnd_HE_Grenade_shell", 0.2], ["ItemGPS", 0.01], ["HandGrenade", 0.3], ["arifle_MX_GL_F", 0.2], ["B_Carryall_oucamo", 0.15], ["srifle_EBR_F", 0.1], ["NVGoggles", 0.01], ["V_RebreatherB", 0.02]]

#define MONEY_SPAWN [["ARP_Objects_moneya_m", 0.75, 5], ["ARP_Objects_moneya_m", 0.5, 10], ["ARP_Objects_moneya_m", 0.3, 50], ["ARP_Objects_moneya_m", 0.1, 100]]

#define LOW_CONSUME_ANIMATIONS [["amovpercmstpsnonwnondnon", "amovpercmwlksnonwnondf"], 0.025]
#define MID_CONSUME_ANIMATIONS [["amovpercmrunsnonwnondf"], 0.1]
#define HIGH_CONSUME_ANIMATIONS [["amovpercmevasnonwnondf"], 0.25]
#define CONSUME_LISTS [LOW_CONSUME_ANIMATIONS, MID_CONSUME_ANIMATIONS, HIGH_CONSUME_ANIMATIONS]

#define DRINK_CLASSES ["ARP_Objects_waterbottle_m", "ARP_Objects_water_m"]

#define DRINK_SPAWN [["ARP_Objects_waterbottle_m", 0.8], ["ARP_Objects_water_m", 0.3, 6]]

#define FOOD_SPAWN [["ARP_Objects_mre_m", 1]]

#define FOOD_CLASSES ["ARP_Objects_mre_m"] 