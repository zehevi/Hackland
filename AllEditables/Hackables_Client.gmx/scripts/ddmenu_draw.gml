///ddmenu_draw(mouse_x, mouse_y, cell w, cell h)
if(ddmenu_active==0) return(-1);

var n,xx,yy,ww,hh,yyy,c;
n = array_length_1d(ddmenu);
mx = argument0;
my = argument1;
ww = argument2;
hh = argument3;

//draw menu item
draw_set_alpha(0.7);
draw_set_valign(1);
c = -1;
for(var i=0; i<n; i++)
{
    yyy = ddmenu_y+hh*i;//*(i+1);
    draw_set_colour(c_dkgray);
    draw_rectangle(ddmenu_x,yyy,ddmenu_x+ww,yyy+hh,0);
    if( point_in_rectangle(mx,my, ddmenu_x,yyy,ddmenu_x+ww,yyy+hh ))
    {
        draw_rectangle(ddmenu_x,yyy,ddmenu_x+ww,yyy+hh,0);
        if(mouse_check_button_pressed(mb_left)) c = i;
    }
    draw_set_colour(c_white);
    draw_text(ddmenu_x,yyy+hh/2,ddmenu[i]);
}
draw_set_colour(0);
draw_set_alpha(1);
draw_set_valign(0);

if(mouse_check_button_pressed(mb_left)/*||mouse_check_button_pressed(mb_right)*/)
    ddmenu_active = 0;

//return item index and then use a switch to execute actions
return c;
