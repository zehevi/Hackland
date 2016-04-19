///battle_readInfo(sock);
//sock is the player socket that this info belongs to
//the script will create a oBattle_player instance and read all info to it for further use
var tbuff = async_load[? "buffer"]

var i=1;
with(instance_create(0,0,oBattle_player))
{
    sock = argument0;
    monster = ds_map_create();
    repeat(4){
        monster[? "monster"+string(i)+" file"] = buffer_read(tbuff,buffer_string);
        monster[? "monster"+string(i)+" skill file"] = buffer_read(tbuff,buffer_string);
        monster[? "monster"+string(i)+" level"] = buffer_read(tbuff,buffer_u8);
        monster[? "monster"+string(i)+" health"] = buffer_read(tbuff,buffer_u16);
        monster[? "monster"+string(i)+" offence"] = buffer_read(tbuff,buffer_u8);
        monster[? "monster"+string(i)+" defence"] = buffer_read(tbuff,buffer_u8);
        monster[? "monster"+string(i)+" speed"] = buffer_read(tbuff,buffer_u8);
        i++;
    }
}
