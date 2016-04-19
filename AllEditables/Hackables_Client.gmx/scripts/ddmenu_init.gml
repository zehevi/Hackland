///ddmenu_init(text1,text2,...)
var n;
n = argument_count;

for(var i=0; i<n; i++)
{
    ddmenu[i] = argument[i];
}

ddmenu_active = 0;
ddmenu_x = 0;
ddmenu_y = 0;
