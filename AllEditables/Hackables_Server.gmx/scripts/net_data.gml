#define net_data
///net_data()
var tbuff = async_load[? "buffer"];
var tbuff_size = async_load[? "size"];
var tsock = async_load[? "id"];
var tIP = async_load[? "ip"];
var tPORT = async_load[? "port"];

var cmd = buffer_read(tbuff, buffer_u8);
switch(cmd)
{
case Sock.PING:
    buffer_seek(wbuff,0,0);
    buffer_write(wbuff,buffer_u8,Sock.PING);
    network_send_packet(tsock,wbuff,buffer_tell(wbuff));
    break;
case Sock.LOGIN:
    var _u,_p,_cc;
    _u = buffer_read(tbuff,buffer_string);
    _p = buffer_read(tbuff,buffer_string);
    _cc = buffer_read(tbuff,buffer_string);
    sock_login(_u, _p, _cc, tsock);
    break;
case Sock.REGISTER:
    var _u = buffer_read(tbuff,buffer_string);
    var _p = buffer_read(tbuff,buffer_string);
    var file = file_text_open_read("Users\"+string(_u)+".user");
    
    if(file<0)
    {
        file = file_text_open_write("Users\"+string(_u)+".user");
        if(file<0) logAdd("Cannot create user file: '"+string(_u)+".user'")
        else{
            //create the monsters in the players file; for more info go to "user_write()"
            m1arr[0] = "Mosh.png";m1arr[1] = "";m1arr[2] = 1;m1arr[3] = 100;m1arr[4] = 5;m1arr[5] = 5;m1arr[6] = 5;
            m2arr[0] = "";m2arr[1] = "";m2arr[2] = 1;m2arr[3] = 100;m2arr[4] = 5;m2arr[5] = 5;m2arr[6] = 5;
            m3arr[0] = "";m3arr[1] = "";m3arr[2] = 1;m3arr[3] = 100;m3arr[4] = 5;m3arr[5] = 5;m3arr[6] = 5;
            m4arr[0] = "";m4arr[1] = "";m4arr[2] = 1;m4arr[3] = 100;m4arr[4] = 5;m4arr[5] = 5;m4arr[6] = 5;
            file_text_write_string(file,user_write(string(_u),string(_p),0,0,0,m1arr,m2arr,m3arr,m4arr));
            buffer_seek(wbuff,buffer_seek_start,0);
            buffer_write(wbuff,buffer_u8,Sock.REGISTER);
            buffer_write(wbuff,buffer_bool,1); //success
            network_send_packet(tsock,wbuff, buffer_tell(wbuff));
            logAdd("["+string(_u)+"] have registered");
        }
        file_text_close(file);
    }
    else
    {
        file_text_close(file);
        buffer_seek(wbuff,buffer_seek_start,0);
        buffer_write(wbuff,buffer_u8,Sock.REGISTER);
        buffer_write(wbuff,buffer_bool,0); //failure
        network_send_packet(tsock,wbuff, buffer_tell(wbuff));
        logAdd("Multiple registration attempt from user: "+string(tsock));
    }
    break;
case Sock.JOIN:
    var _x = buffer_read(tbuff,buffer_s16);
    var _y = buffer_read(tbuff,buffer_s16);
    with(Clients[? tsock])
    {
        name = tmpname;
        col = make_colour_hsv(irandom(255),200,240); //Will change this to chat color or something like that
        xpos = _x;
        ypos = _y;
    }
    buffer_seek(wbuff,0,0);
    buffer_write(wbuff,buffer_u8,Sock.JOIN);
    buffer_write(wbuff,buffer_u8,tsock);
    with(Clients[? tsock])
    {
        buffer_write(wbuff,buffer_string,name);
        buffer_write(wbuff,buffer_s32,col);
        buffer_write(wbuff,buffer_u16,spr); logAdd("Client"+string(tsock)+".spr = "+string(spr));
        buffer_write(wbuff,buffer_s16,xpos);
        buffer_write(wbuff,buffer_s16,ypos);
    }
    network_send_packet(tsock,wbuff,buffer_tell(wbuff));
    break;
case Sock.MOVE:
    var _map_x,_map_y;
    with(Clients[? tsock])
    {
        xpos = buffer_read(tbuff,buffer_s16);
        ypos = buffer_read(tbuff,buffer_s16);
        bdir = buffer_read(tbuff,buffer_s16);
        _spr = buffer_read(tbuff,buffer_u16); //useless?
        _map_x = map_x; //get map position for sending data to users only in the current map
        _map_y = map_y;
    }
    
    buffer_seek(wbuff,0,0);
    buffer_write(wbuff,buffer_u8,Sock.MOVE);
    
    var usrmap = ds_grid_get(global.maps_users, _map_x, _map_y);
    var lst = ds_list_create();
    var n=0; for(var i=0; i<ds_list_size(usrmap); i++) with(usrmap[| i]) if(name!="spectate") ds_list_add(lst,usrmap[| i]);
    buffer_write(wbuff,buffer_u8,ds_list_size(lst));
    for(var i=0; i<ds_list_size(lst); i++)
    {
        with(lst[| i])
        {
            buffer_write(wbuff,buffer_u8,sock);
            buffer_write(wbuff,buffer_string,name);
            buffer_write(wbuff,buffer_s16,col);
            buffer_write(wbuff,buffer_s16,xpos);
            buffer_write(wbuff,buffer_s16,ypos);
            buffer_write(wbuff,buffer_s16,bdir);
            buffer_write(wbuff,buffer_u16,spr);
        }
    }
    for(var i=0; i<ds_list_size(lst); i++) with(lst[| i]) network_send_packet(sock,wbuff,buffer_tell(wbuff));
    with(Clients[? tsock]) bdir = -1;
    break;
case Sock.CHANGEMAP:
    var xx = buffer_read(tbuff,buffer_s8);
    var yy = buffer_read(tbuff,buffer_s8);
    
    buffer_seek(wbuff,0,0);
    buffer_write(wbuff,buffer_u8,Sock.CHANGEMAP);
    
    with(Clients[? tsock]){
        if(ds_grid_get(global.maps,map_x+xx,map_y+yy)!="nomap"){
            var _l = ds_grid_get(global.maps_users, map_x, map_y);
            ds_list_delete(_l, ds_list_find_index(_l,id));
            map_x += xx;
            map_y += yy;
            map = ds_grid_get(global.maps,map_x,map_y);
            map_mask = ds_grid_get(global.maps_mask,map_x,map_y);
            ds_list_add(ds_grid_get(global.maps_users, map_x, map_y), id);
            buffer_write(wbuff,buffer_u8,map_x);
            buffer_write(wbuff,buffer_u8,map_y);
        }else{ //let player move to edit mode
            map = "editable";
            buffer_write(wbuff,buffer_u8,map_x+xx);
            buffer_write(wbuff,buffer_u8,map_y+yy);
        }
        buffer_write(wbuff,buffer_string,map); //Map filename
        buffer_write(wbuff,buffer_string,map_mask); //Map mask filename
        network_send_packet(sock,wbuff,buffer_tell(wbuff));
    }
    break;
case Sock.MESSAGE:
    var _msg = buffer_read(tbuff,buffer_string);
    buffer_seek(wbuff,0,0);
    buffer_write(wbuff,buffer_u8,Sock.MESSAGE);
    buffer_write(wbuff,buffer_u32,tsock);
    buffer_write(wbuff,buffer_string,_msg);
    with(oClient) if(name != "spectate") network_send_packet(sock,wbuff,buffer_tell(wbuff));
    break;
case Sock.UPDATEINFO://received request, send file list
    updater_sendInfo(tsock);
    break;
case Sock.UPDATEFILE:
    var f = buffer_read(tbuff,buffer_string);
    updater_sendFile(tsock, string(f));
    break;
case Sock.BATTLE_REQUEST:
    var tsock_to = buffer_read(tbuff,buffer_u32);
    buffer_seek(wbuff,0,0);
    buffer_write(wbuff,buffer_u8,Sock.BATTLE_REQUEST);
    buffer_write(wbuff,buffer_u32,tsock);
    switch(Clients[? tsock].inBattle)
    {
    case 0://sender is not fighting or waiting reply
        switch(Clients[? tsock_to].inBattle)
        {
        case 0://tsock is requesting battle from tsock_to
            Clients[? tsock].inBattle = 1; //set sender as waiting
            network_send_packet(tsock_to,wbuff,buffer_tell(wbuff));
            break;
        case 1://tsock_to is waiting reply; this is a response packet. Check if accepted/declined
            var _response = buffer_read(tbuff,buffer_bool);
            Clients[? tsock].inBattle = _response*2; //sender is fighting(2) or not (0)
            Clients[? tsock_to].inBattle = _response*2; //target is fighting(2) or not (0)
            buffer_write(wbuff,buffer_bool,_response);
            if(_response){
                buffer_write(wbuff,buffer_u32,tsock_to);
                Clients[? tsock].opponent = tsock_to;
                Clients[? tsock_to].opponent = tsock;
                var _map = "battle";//"& "+string(tsock)+" "+string(tsock_to);
                Clients[? tsock].map = _map; /////////////?!??
                Clients[? tsock_to].map = _map;
                battle_writeInfo(tsock_to); //This is the requester
                battle_writeInfo(tsock); //this is the accepter
            }else{
                Clients[? tsock_to].inBattle = 0;
            }
            network_send_packet(tsock_to,wbuff,buffer_tell(wbuff));
            network_send_packet(tsock,wbuff,buffer_tell(wbuff));
            break;
        case 2://client is already in a battle; reply to tsock as a declined request
            Clients[? tsock].inBattle = 0; //sender is not fighting(0)
            buffer_write(wbuff,buffer_bool,0);
            network_send_packet(tsock,wbuff,buffer_tell(wbuff));
            break;
        }
        break;
    case 1://sender is waiting for reply
        switch(Clients[? tsock_to].inBattle)
        {
        case 0://tsock is waiting but tsock_to is not; spammed request!
            break;
        case 1://both are waiting reply? wtf?
            break;
        case 2://client is already in a battle; reply to tsock as a declined request
            Clients[? tsock].inBattle = 0; //sender is not fighting(0)
            buffer_write(wbuff,buffer_bool,0);
            network_send_packet(tsock,wbuff,buffer_tell(wbuff));
            break;
        }
        break;
    case 2://sender is already fighting! always reply to tsock as declined request
        Clients[? tsock].inBattle = 0; //sender is not fighting(0)
        buffer_write(wbuff,buffer_bool,0);
        network_send_packet(tsock,wbuff,buffer_tell(wbuff));
        break;
    }
    break;
case Sock.UPLOADCHAR:
    var code = buffer_read(tbuff,buffer_string);
    if( file_exists(APPDATA+"\content\Characters\"+string(code)+".png") ){
        buffer_seek(wbuff,0,0);
        buffer_write(wbuff,buffer_u8,Sock.UPLOADCHAR);
        buffer_write(wbuff,buffer_bool,0); //char code is already been used
        network_send_packet(tsock,wbuff,buffer_tell(wbuff));
    }else{
        var buf = buffer_create(16384,buffer_fixed,4);
        buffer_copy(tbuff,buffer_tell(tbuff),buffer_get_size(tbuff),buf,0);
        var tsurf = surface_create(64,64);
        buffer_set_surface(buf,tsurf,0,0,0);
        surface_save(tsurf,APPDATA+"\content\Characters\"+string(code)+".png");
        buffer_delete(buf);
        surface_free(tsurf);
        //add "code" to the charcode list
        ini_open("CharCodes.ini");
            ini_write_string("Characters",string(code)+".png",string(code));
        ini_close();
        updater_restart();
        buffer_seek(wbuff,0,0);
        buffer_write(wbuff,buffer_u8,Sock.UPLOADCHAR);
        buffer_write(wbuff,buffer_bool,1); //success
        network_send_packet(tsock,wbuff,buffer_tell(wbuff));
    }
    break;
case Sock.UPLOAD_MAP:
    var xx = buffer_read(tbuff,buffer_u16);
    var yy = buffer_read(tbuff,buffer_u16);
    if(ds_grid_get(global.maps,xx,yy)!="nomap"){
        buffer_seek(wbuff,0,0);
        buffer_write(wbuff,buffer_u8,Sock.UPLOAD_MAP);
        buffer_write(wbuff,buffer_bool,0); //Map already exists in that location
        network_send_packet(tsock,wbuff,buffer_tell(wbuff));
    }else{
        var fn = string(xx)+"_"+string(yy)+".png";
        var buf = buffer_create(800*600*4,buffer_fixed,4);
        buffer_copy(tbuff,buffer_tell(tbuff),buffer_get_size(tbuff),buf,0);
        var tsurf = surface_create(800,600);
        buffer_set_surface(buf,tsurf,0,0,0);
        surface_save(tsurf,APPDATA+"\content\Maps\"+fn);
        buffer_delete(buf);
        surface_free(tsurf);
        //add the map to the mapping file
        ini_open("Mapping.ini");
            ini_write_string(string(fn),"name",string(fn));
            ini_write_string(string(fn),"mask",string(fn));
            ini_write_real(string(fn),"xpos",xx);
            ini_write_real(string(fn),"ypos",yy);
        ini_close();
        updater_restart();
        buffer_seek(wbuff,0,0);
        buffer_write(wbuff,buffer_u8,Sock.UPLOAD_MAP);
        buffer_write(wbuff,buffer_bool,1); //success
        network_send_packet(tsock,wbuff,buffer_tell(wbuff));
    }
    break;
case Sock.FRIEND_REQUEST:
    var _sock = buffer_read(tbuff,buffer_u32);
    logAdd(string(tsock)+" request friendship with "+string(_sock));
    buffer_seek(wbuff,0,0);
    buffer_write(wbuff,buffer_u8,Sock.FRIEND_REQUEST);
    buffer_write(wbuff,buffer_u32,tsock);
    network_send_packet(_sock,wbuff,buffer_tell(wbuff));
    break;
default:
    logAdd("Unknown packet received from: "+string(tsock));
    if((Clients[? tsock]).name != "spectator") user_warning((Clients[? tsock]).name);
    break;
}

#define sock_login
///sock_login
var _u,_p,_cc,_img,file,a,str,inst;
_u = argument0;
_p = argument1;
_cc = argument2;
tsock = argument3;
inst = Clients[? tsock];
//_img = buffer_read(tbuff,buffer_string);
file = file_text_open_read("Users\"+string(_u)+".user");

a = 1;
if(file<0) var a = 0;
else
{
    str = file_text_read_string(file);
    file_text_close(file);
    with(inst)
    {
        user_read(str);
        if(_p!=password || _u!=username || ban){
            a = 0;
        }else{
            tmpname = username;
            spr = -1;
            map_x = 64;
            map_y = 63;
            map = ds_grid_get(global.maps,map_x,map_y);
            map_mask = ds_grid_get(global.maps_mask,map_x,map_y);
            ds_list_add(ds_grid_get(global.maps_users, map_x, map_y), id); //add user's object id to the map list
        }
    }
}

//find Mosh
var i=0,mosh=-1;
repeat(_updater_charSpriteNum-1){
    if(_updater_charSprite[i] = "Mosh.png"){
        mosh = i;
        break;
    }
    i++;
}

inst.spr = mosh;//_updater_charSprite[0];
if(string_length(_cc)!=0){
    for(var i=0; i<array_length_1d(_updater_charSpriteCode); i++){
        if(_updater_charSpriteCode[i]==_cc){
            inst.spr = i;//_updater_charSprite[i];
            break;
        }
    }
    if(i>=array_length_1d(_updater_charSpriteCode)){
        inst.spr = mosh;
        a = 2;
    }
}
inst.spr_file = _updater_charSprite[inst.spr];

buffer_seek(wbuff,buffer_seek_start,0);
buffer_write(wbuff,buffer_u8,Sock.LOGIN);
buffer_write(wbuff,buffer_u8,a); //0=wrong user/pass; 1=success; 2=wrong char-code
if(a){
    buffer_write(wbuff,buffer_u16,inst.spr);
    buffer_write(wbuff,buffer_string,string(inst.map)); //Map filename
    buffer_write(wbuff,buffer_string,string(inst.map_mask)); //Map mask filename
}
network_send_packet(tsock,wbuff,buffer_tell(wbuff));