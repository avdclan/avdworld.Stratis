
class uniforms
{
	idd = -1;
	movingEnable = false;
	onLoad = "dialogOpen = 1;[]execVM ""x_avd\player\dialogs\uniforms\uniformsFillList.sqf""";
	onUnload = "dialogOpen = 0";	
	name = "uniforms";
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
			idc = 2200;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 14 * GUI_GRID_H;
		};
		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			text = "Uniforms"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 14 * GUI_GRID_H;
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 11 * GUI_GRID_W;
			h = 12 * GUI_GRID_H;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "X"; //--- ToDo: Localize;
			action = "closeDialog 0";
			x = 21.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Change"; //--- ToDo: Localize;
			action = "execVM ""x_avd\player\dialogs\uniforms\changeUniform.sqf""";
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 7 * GUI_GRID_H;
			style = ST_MULTI;
			lineSpacing = 1;
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 7 * GUI_GRID_H;
		};
	};
};