// basic defines
//
class RscText
{
	type = 0;
	idc = -1;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0x100; 
	font = "TahomaB";
	SizeEx = 0.03921;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0, 0, 0, 0};
	linespacing = 1;
};
class RscPicture
{
	access=0;
	type=0;
	idc=-1;
	style=48;
	colorBackground[]={0,0,0,0};
	colorText[]={1,1,1,1};
	font="TahomaB";
	sizeEx=0;
	lineSpacing=0;
	text="";
};
class RscLoadingText : RscText
{
	style = 2;
	x = 0.323532;
	y = 0.666672;
	w = 0.352944;
	h = 0.039216;
	sizeEx = 0.03921;
	colorText[] = {0.543,0.5742,0.4102,1.0};
};
class RscProgress
{
	x = 0.344;
	y = 0.619;
	w = 0.313726;
	h = 0.0261438;
	texture = "#(argb,8,8,3)color(0,1,0,1)";
	colorFrame[] = {0,0,0,0};
	colorBar[] = {1,1,1,1};
};
class RscProgressNotFreeze
{
	idc = -1;
	type = 45;
	style = 0;
	x = 0.022059;
	y = 0.911772;
	w = 0.029412;
	h = 0.039216;
	texture = "#(argb,8,8,3)color(0,1,0,1)";
};
//
// the loading screen itself
//
class Escape_loadingScreen
{ 
	idd = -1;
	duration = 10e10;
	fadein = 0;
	fadeout = 0;
	name = "loading screen";
	class controlsBackground
	{
		class blackBG : RscText
		{
			x = safezoneX;
			y = safezoneY;
			w = safezoneW;
			h = safezoneH;
			text = "";
			colorText[] = {0,0,0,0};
			colorBackground[] = {0,0,0,1};
		};
		class nicePic : RscPicture
		{
			style = 48 + 0x800; // ST_PICTURE + ST_KEEP_ASPECT_RATIO
			x = safezoneX + safezoneW/2 - 0.25;
			y = safezoneY + safezoneH/2 - 0.2;
			w = 0.5;
			h = 0.4;
			text = "escape_banner.paa";
		};
	};
	class controls
	{
		class Title1 : RscLoadingText
		{
			idc = 101;
			text = "Loading Escape..."; // "Loading" text in the middle of the screen
		};
		class CA_Progress : RscProgress // progress bar, has to have idc 104
		{
			idc = 104;
			type = 8; // CT_PROGRESS
			style = 0; // ST_SINGLE
		};
		class CA_Progress2 : RscProgressNotFreeze // progress bar that will go reverse
		{
			idc = 103;
		};
		class Name2: RscText // the text on the top-left
		{
			idc = 101;
			x = 0.05;
			y = 0.029412;
			w = 0.9;
			h = 0.04902;
			text = "";
			sizeEx = 0.05;
			colorText[] = {0.543,0.5742,0.4102,1.0};
		};
	};
};