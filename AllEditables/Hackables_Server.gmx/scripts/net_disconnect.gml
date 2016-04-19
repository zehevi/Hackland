///net_disconnect()
var tsock = async_load[? "socket"];

with(Clients[? tsock])
{
    logAdd("Client: "+string(tsock)+" have disconnected");
    ds_map_delete(Clients,tsock);
    var usrmap = ds_grid_get(global.maps_users,map_x,map_y);
    ds_list_delete(usrmap,ds_list_find_index(usrmap,id));
    instance_destroy();
}

if(instance_number(oClient)==1)
{
    buffer_seek(wbuff,0,0);
    buffer_write(wbuff,buffer_u8,Sock.MOVE);
    var i=0; with(oClient) if(name!="spectate" && map!="battle") i++;
    buffer_write(wbuff,buffer_u8,i);
    with(oClient) if(name!="spectate" && map!="battle")
    {
        buffer_write(wbuff,buffer_u8,sock);
        buffer_write(wbuff,buffer_string,name);
        buffer_write(wbuff,buffer_s32,col);
        buffer_write(wbuff,buffer_s16,xpos);
        buffer_write(wbuff,buffer_s16,ypos);
        buffer_write(wbuff,buffer_s16,bdir);
    }
    with(oClient) if(name!="spectate" && map!="battle") network_send_packet(sock,wbuff,buffer_tell(wbuff));
}
