///surface_read_from_buffer(src buff, dest surf)
//need to seek the buffer to the propper offset (starting of the surface data)
var _buf = argument0;
var _sur = argument1;

var w = surface_get_width(_sur);
var h = surface_get_height(_sur);

surface_set_target(_sur);
draw_clear_alpha(0,0);

//var n = 0;
var col,a,r,g,b,pix;
for(var yy=0; yy<h; yy++){
    for(var xx=0; xx<w; xx++){
        
        col = buffer_read(_buf, buffer_u32);
        a = (col >> 24) & 255;
        r = (col >> 16) & 255;
        g = (col >> 8) & 255;
        b = col & 255;

        draw_set_alpha(a);
        draw_set_color(make_colour_rgb(r, g, b));
        //draw_set_color(col & 16777215);
        draw_point(xx, yy);
        //n++;
        
        /*pix = buffer_peek(_buf, (xx+yy*w)*4, buffer_u32);
        a = (pix >> 24) & 255;
        draw_set_alpha(a);
        draw_set_color(pix & 16777215);
        draw_point(xx, yy);*/
    }
}
draw_set_color(0);
draw_set_alpha(1);
surface_reset_target();
