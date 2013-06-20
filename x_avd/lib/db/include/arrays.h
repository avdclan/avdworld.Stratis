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