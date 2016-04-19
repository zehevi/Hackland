/*case Sock.LOGIN:
    var _u,_p,_cc,_img,file,a;
    _u = buffer_read(tbuff,buffer_string);
    _p = buffer_read(tbuff,buffer_string);
    _cc = buffer_read(tbuff,buffer_string);
    _img = buffer_read(tbuff,buffer_string);
    
    file = file_text_open_read(string(_u)+".user");
    str = file_text_read_string(file);
    file_text_close(file);
    
    a = 1;
    if(file<0) var a = 0;
    else
    {
        with(Clients[? tsock])
        {
            user_read(str);
            if(_p!=password || _u!=username || ban){
                a = 0;
            }else{
                tmpname = username;
                spr = "";
                map_x = 64;
                map_y = 63;
                map = ds_grid_get(global.maps,map_x,map_y);
                map_mask = ds_grid_get(global.maps_mask,map_x,map_y);
                ds_list_add(ds_grid_get(global.maps_users, map_x, map_y), id); //add user's object id to the map list
            }
        }
    }
    var b=0;
    for(var i=0; i<array_length_1d(_updater_charSprite); i++) ///////Find the matching CharCode
    {
        if(_updater_charSprite[i] == _img && _updater_charSpriteCode[i]==_cc)
        {
            (Clients[? tsock]).spr = _updater_charSprite[i];
            b=1;
            break;
        }
    }if(!b) a=2;
    buffer_seek(wbuff,buffer_seek_start,0);
    buffer_write(wbuff,buffer_u8,Sock.LOGIN);
    buffer_write(wbuff,buffer_u8,a); //0=wrong user/pass; 1=success; 2=wrong char-code
    buffer_write(wbuff,buffer_string,(Clients[? tsock]).spr);
    buffer_write(wbuff,buffer_string,string((Clients[? tsock]).map)); //Map filename
    buffer_write(wbuff,buffer_string,string((Clients[? tsock]).map_mask)); //Map mask filename
    network_send_packet(tsock,wbuff,buffer_tell(wbuff));
    break;
    */
