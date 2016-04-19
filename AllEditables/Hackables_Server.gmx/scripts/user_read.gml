///user_read(string)
var _s=argument0;
var _len = string_length(_s);
var _p = 0;

//ds_map_clear(global._user);

_p = string_pos(";",_s);
//global._user[? "username"] = string_copy(_s,1,_p-1);
username = string_copy(_s,1,_p-1);
_s = string_delete(_s,1,_p);

_p = string_pos(";",_s);
//global._user[? "password"] = string_copy(_s,1,_p-1);
password = string_copy(_s,1,_p-1);
_s = string_delete(_s,1,_p);

_p = string_pos(";",_s);
//global._user[? "warnings"] = string_copy(_s,1,_p-1);
warnings = string_copy(_s,1,_p-1);
_s = string_delete(_s,1,_p);

_p = string_pos(";",_s);
//global._user[? "kicks"] = string_copy(_s,1,_p-1);
kicks = string_copy(_s,1,_p-1);
_s = string_delete(_s,1,_p);

_p = string_pos(";",_s);
//global._user[? "ban"] = string_copy(_s,1,_p-1);
ban = string_copy(_s,1,_p-1);
_s = string_delete(_s,1,_p);

var i=1;
repeat(4)
{
    _p = string_pos(";",_s);
    //global._user[? "monster"+string(i)+" file"] = string_copy(_s,1,_p-1);
    monster[? "monster"+string(i)+" file"] = string_copy(_s,1,_p-1);
    _s = string_delete(_s,1,_p);
    
    _p = string_pos(";",_s);
    //global._user[? "monster"+string(i)+" skill file"] = string_copy(_s,1,_p-1);
    monster[? "monster"+string(i)+" skill file"] = string_copy(_s,1,_p-1);
    _s = string_delete(_s,1,_p);
    
    _p = string_pos(";",_s);
    //global._user[? "monster"+string(i)+" level"] = string_copy(_s,1,_p-1);
    monster[? "monster"+string(i)+" level"] = string_copy(_s,1,_p-1);
    _s = string_delete(_s,1,_p);
    
    _p = string_pos(";",_s);
    //global._user[? "monster"+string(i)+" health"] = string_copy(_s,1,_p-1);
    monster[? "monster"+string(i)+" health"] = string_copy(_s,1,_p-1);
    _s = string_delete(_s,1,_p);
    
    _p = string_pos(";",_s);
    //global._user[? "monster"+string(i)+" offence"] = string_copy(_s,1,_p-1);
    monster[? "monster"+string(i)+" offence"] = string_copy(_s,1,_p-1);
    _s = string_delete(_s,1,_p);
    
    _p = string_pos(";",_s);
    //global._user[? "monster"+string(i)+" defence"] = string_copy(_s,1,_p-1);
    monster[? "monster"+string(i)+" defence"] = string_copy(_s,1,_p-1);
    _s = string_delete(_s,1,_p);
    
    _p = string_pos(";",_s);
    //global._user[? "monster"+string(i)+" speed"] = string_copy(_s,1,_p-1);
    monster[? "monster"+string(i)+" speed"] = string_copy(_s,1,_p-1);
    _s = string_delete(_s,1,_p);
    
    i++;
}
