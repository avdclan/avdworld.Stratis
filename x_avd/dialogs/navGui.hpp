
class navGui
{
	idd = 1337;
	movingEnable = 0;
	enableSimulation = 1;
	enableDisplay = 1;
	duration =  999999999999999999999999*100;
    fadein =  0;
    fadeout =  0;
	name = "navGui";
	onLoad = "navGuiOpen = 1; with uiNameSpace do { navGui = _this select 0 };";
	onUnload = "navGuiOpen = 0";
	
#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

	
	
	class controls 
	{

		class IGUIBack_2200: IGUIBack
		{
			idc = 22022;
			x = 38.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 19 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
			colorBackground[] = {-1,-1,0.5,0.3};
		};
		class RscFrame_1800: RscFrame
		{
			idc = 18022;
			text = "Positionscheckapparat"; //--- ToDo: Localize;
			x = 38.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 19 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
		};
		class RscText_1100: RscText
		{
			idc = 11020;
			x = 46.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscText_1101: RscText
		{
			idc = 11021;
			x = 46.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscText_1102: RscText
		{
			idc = 11022;
			x = 46.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscText_1103: RscText
		{
			idc = 11023;
			x = 46.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscText_1000: RscText
		{
			idc = 10020;
			text = "Cur. Position"; //--- ToDo: Localize;
			x = 39 * GUI_GRID_W + GUI_GRID_X;
			y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {-1,1,-1,1};
		};
		class RscText_1001: RscText
		{
			idc = 10021;
			text = "Cur. Direction"; //--- ToDo: Localize;
			x = 39 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {-1,1,-1,1};
		};
		class RscText_1002: RscText
		{
			idc = 10022;
			text = "Target Dir."; //--- ToDo: Localize;
			x = 39 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {-1,1,-1,1};
		};
		class RscText_1003: RscText
		{
			idc = 10023;
			text = "Target Dist."; //--- ToDo: Localize;
			x = 39 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {-1,1,-1,1};
		};
	};
};