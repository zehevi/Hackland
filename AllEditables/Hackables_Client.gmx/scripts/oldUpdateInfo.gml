/*
case Sock.UPDATEINFO:
    var e,f,fhash,flock;
    global.lockedChars = ds_map_create();
    var n = buffer_read(tbuff, buffer_u16);
    repeat(n)
    {
        f = buffer_read(tbuff,buffer_string);
        fhash = buffer_read(tbuff, buffer_string);
        flock = buffer_read(tbuff,buffer_bool);
        
        global.lockedChars[? string(f)] = flock;
        
        e = file_exists(APPDATA+"\"+string(f));
        if( !e || e&&sha1_file(APPDATA+"\"+string(f))!=fhash )
        {
            ds_list_add(global.fileUpdateList, f);
            upstate = 1;
        }
    }//////////////Need to delete all sprite files not included in the info//////////////////
    n = buffer_read(tbuff,buffer_u16);
    repeat(n)
    {
        f = buffer_read(tbuff,buffer_string);
        fhash = buffer_read(tbuff,buffer_string);
        e = file_exists(APPDATA+"\"+string(f));
        if( !e || (e&&sha1_file(APPDATA+"\"+string(f)))!=fhash )
        {
            ds_list_add(global.fileUpdateList, f);
            upstate = 1;
        }
    }
    /////////////////////////////////////////////////////////////////////////////////////////
    if(ds_list_size(global.fileUpdateList))
    {
        updater_requestFile(global.fileUpdateList[| 0]);
        global.fileUpdateListMax = ds_list_size(global.fileUpdateList);
        if(room!=rUpdate){
            disconnect();
            game_restart();
        }
    }else{
        upstate = -1;
        room_goto(rMenu);
    }
    break;
*/
