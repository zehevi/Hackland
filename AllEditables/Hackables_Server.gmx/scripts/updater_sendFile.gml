///updater_sendFile(sock, file);

//var _spr = sprite_add(APPDATA+"\content\characters\"+argument1, 1, 0, 0, 0,0);
var _spr = sprite_add(APPDATA+"\content\"+argument1, 1, 0, 0, 0,0);
if(_spr<0){
    logAdd("Cannot find file: "+argument1);
    exit;
}
var w=sprite_get_width(_spr),h=sprite_get_height(_spr);
var _surf = surface_create(w,h);

surface_set_target(_surf);
draw_clear_alpha(0,0);
draw_sprite(_spr,0,0,0);
surface_reset_target();
sprite_delete(_spr);

buffer_seek(wbuff,0,0);
buffer_write(wbuff,buffer_u8,Sock.UPDATEFILE);
buffer_write(wbuff, buffer_string, argument1); //filename
buffer_write(wbuff,buffer_u16,w);
buffer_write(wbuff,buffer_u16,h);

var buf = buffer_create(w*h*4,buffer_fixed,4);
buffer_get_surface(buf,_surf,0,0,0);
buffer_copy(buf,0,w*h*4, wbuff,buffer_tell(wbuff));
buffer_delete(buf);
surface_free(_surf);

network_send_packet(argument0, wbuff, buffer_get_size(wbuff)-16); //header size is 16
