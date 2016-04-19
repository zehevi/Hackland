var e,f,fhash,flock;

var n = buffer_read(tbuff, buffer_u16);
repeat(n)
{
    f = buffer_read(tbuff,buffer_string);
    fhash = buffer_read(tbuff, buffer_string);
    flock = buffer_read(tbuff,buffer_bool); //useless for now
    //list all characters\\
    //global.lockedChars[? string(f)] = flock; //not needed anymore?
    ds_list_add(global.charsSprites, f);
    ds_list_add(global.charsSprites_hash, fhash);
}

n = buffer_read(tbuff,buffer_u16);
repeat(n)
{
    f = buffer_read(tbuff,buffer_string);
    fhash = buffer_read(tbuff,buffer_string);
    //list all maps\\
    ds_list_add(global.mapsSprites, f);
    ds_list_add(global.mapsSprites_hash, fhash);
}
upstate = -1;
room_goto(rMenu);
