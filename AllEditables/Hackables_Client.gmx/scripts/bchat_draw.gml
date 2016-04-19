///bchat_draw()
if(bchat_text!="")
{
    var _width = string_width(bchat_text);
    var _height = string_height(bchat_text);
    draw_set_color(c_white);
    draw_roundrect(x-max(_width/2+4,24) ,y-56-_height, x+max(_width/2+4,24), y-56, 0);
    draw_set_color(0);
    draw_roundrect(x-max(_width/2+4,24) ,y-56-_height, x+max(_width/2+4,24), y-56, 1);
    draw_set_color(c_white);
    draw_triangle(x-6,y-56,x+14,y-56,x,y-38,0);
    draw_set_color(0);
    draw_line(x-6,y-56,x,y-38);
    draw_line(x+14,y-56,x,y-38);
    draw_set_halign(1);
    draw_text(x,y-56-_height,bchat_text);
    draw_set_halign(0);
}
