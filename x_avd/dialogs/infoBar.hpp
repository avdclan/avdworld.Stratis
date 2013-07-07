class infoBar
{
	idd = 1338;
	movingEnable = 0;
	enableSimulation = 1;
	enableDisplay = 1;
	duration =  999999999999999999999999*100;
    fadein =  0;
    fadeout =  0;
	name = "infoBar";
	onLoad = "infoBarOpen = 1;with uiNameSpace do { infoBar = _this select 0 };[player]execVM ""x_avd\player\dialogs\infobar\infoBar.sqf"";";
	onUnload = "infoBarOpen = 0";
	
#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

	
	
	controls[] = {RscText_1003, RscText_1001, RscText_1002, RscFrame_1800, RscPicture_1200, RscPicture_1201, RscText_1000};
	controlsBackground[] = {IGUIBack_2200};
		
		class IGUIBack_2200: IGUIBack
		{
			idc = 22030;
			x = 1.45;
			y = 1.1;
			w = 0.1375;
			h = 0.3;
			colorBackground[] = {-1,-1,-1,1};
		};
		class RscFrame_1800: RscFrame
		{
			idc = 18030;
			text = "Stats"; //--- ToDo: Localize;
			x = 1.45;
			y = 1.1;
			w = 0.1375;
			h = 0.3;
		};
		class RscPicture_1200: RscPicture
		{
			idc = 12030;
			text = "x_avd\dialogs\infobar\waterBottle.paa";
			x = 1.5375;
			y = 1.32;
			w = 0.05;
			h = 0.07;
		};
		class RscPicture_1201: RscPicture
		{
			idc = 12031;
			text = "x_avd\dialogs\infobar\mre.paa";
			x = 1.5375;
			y = 1.22;
			w = 0.05;
			h = 0.07;
		};
		class RscText_1003: RscText
		{
			idc = 10033;
			text = "C"; //--- ToDo: Localize;
			x = 1.5375;
			y = 1.12;
			w = 0.05;
			h = 0.06;
			sizeEx = 2 * GUI_GRID_H;
		};
		class RscText_1000: RscText
		{
			idc = 10030;
			text = "Side:"; //--- ToDo: Localize;
			x = 1.4625;
			y = 1.12;
			w = 0.0625;
			h = 0.06;
		};
		class RscText_1001: RscText
		{
			idc = 10031;
			x = 1.4625;
			y = 1.24;
			w = 0.0625;
			h = 0.04;
		};
		class RscText_1002: RscText
		{
			idc = 10032;
			x = 1.4625;
			y = 1.34;
			w = 0.0625;
			h = 0.04;
		};
	
};