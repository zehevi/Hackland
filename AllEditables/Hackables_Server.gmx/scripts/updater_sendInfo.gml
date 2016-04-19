///updater_sendInfo(sock)
buffer_seek(wbuff,0,0);
buffer_write(wbuff,buffer_u8,Sock.UPDATEINFO);
buffer_write(wbuff,buffer_u16,_updater_charSpriteNum);
var i=0;
repeat(_updater_charSpriteNum)
{
    buffer_write(wbuff,buffer_string,"Characters\"+string(_updater_charSprite[i]));
    buffer_write(wbuff,buffer_string,string(_updater_charSpriteHash[i]));
    if(_updater_charSpriteCode[i]=="") buffer_write(wbuff,buffer_bool,0)
    else buffer_write(wbuff,buffer_bool,1);//Locked with pass = 1; free for all = 0;
    i++;
}
buffer_write(wbuff,buffer_u16,_updater_mapSpriteNum);
var i=0;
repeat(_updater_mapSpriteNum)
{
    buffer_write(wbuff,buffer_string,"Maps\"+string(_updater_mapSprite[i]));
    buffer_write(wbuff,buffer_string,string(_updater_mapSpriteHash[i]));
    i++;
}
network_send_packet(argument0, wbuff, buffer_tell(wbuff));
