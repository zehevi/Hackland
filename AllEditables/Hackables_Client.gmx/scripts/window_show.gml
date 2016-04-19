///window_show(true/false)
window_draw = argument0;

for(var i=0; i<array_length_1d(button);i++)
{
    if(button[i]>=0) button[i].visible = window_draw;
}
