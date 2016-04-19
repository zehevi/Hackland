///updater_init()

//check directories
if(!directory_exists(APPDATA+"\content")) directory_create(APPDATA+"\content");
if(!directory_exists(APPDATA+"\content\characters")) directory_create(APPDATA+"\content\characters");
if(!directory_exists(APPDATA+"\content\maps")) directory_create(APPDATA+"\content\maps");
//read character sprites and create hashes
var i=0; f = file_find_first(APPDATA+"\content\characters\*.png",0);
if(f==""){
    logAdd("Error! No character was found; Please restart the server");
    exit;
}
ini_open("CharCodes.ini");
do{
    _updater_charSprite[i] = f;
    //_updater_charSpriteHash[i] = sha1_file(APPDATA+"\content\characters\"+f);
    _updater_charSpriteHash[i] = ""; //NO HASHING
    //_updater_charSpriteCode[i] = ini_read_string("Characters",string(f),"");
    //if(_updater_charSpriteCode[i]=="") ini_write_string("Characters",string(f),"");
    _updater_charSpriteCode[i] = string_copy(f,0,string_length(f)-4); //set the charCode to the filename without the extention
    f = file_find_next();
    i++;
}
until(f=="");
ini_close();
_updater_charSpriteNum = i;

//Fix sprites num
with(oClient){
    logAdd(string(spr_file)+" != "+string(other._updater_charSprite[spr]));
    if(other._updater_charSprite[spr]!=spr_file){
        for(var i=0; i<other._updater_charSpriteNum; i++) {
            if(spr_file==other._updater_charSprite[i]){
                spr = i;
                //show_debug_message("New file = "+string(other._updater_charSprite[spr]));
                logAdd("New file = "+string(other._updater_charSprite[spr])+"; spr="+string(i));
                break;
            }
        }
    }
}

//read map sprites and create hashes
ds_grid_clear(global.maps,"nomap");
ds_grid_clear(global.maps_mask,0);
ds_grid_clear(global.maps_name,0);
var i=0; f = file_find_first(APPDATA+"\content\Maps\*.png",0);
if(f==""){
    logAdd("Error! No map was found; Please restart the server");
    exit;
}
ini_open("Mapping.ini");
if(!file_exists(APPDATA+"\Mapping.ini")){
    ini_write_string("Default","tempkey","tempvalue");
}
do{
    _updater_mapSprite[i] = f;
    //_updater_mapSpriteHash[i] = sha1_file(APPDATA+"\content\Maps\"+f);
    _updater_mapSpriteHash[i] = "";
    
    if(ini_section_exists(string(f)))
    {
        var xx,yy,mask,name;
        name = ini_read_string(string(f),"name",string(f));
        mask = ini_read_string(string(f),"mask","");
        xx = ini_read_real(string(f),"xpos",0);
        yy = ini_read_real(string(f),"ypos",0);
        ds_grid_set(global.maps, xx,yy, string(f));
        ds_grid_set(global.maps_mask, xx,yy, string(mask));
        ds_grid_set(global.maps_name, xx,yy, string(f));
    }else{
        logAdd("Unmapped area: "+string(f)+"; Please refer to 'Mapping.ini' immediatly");
        ini_write_string(string(f),"name",string(f));
        ini_write_string(string(f),"mask",string(f));
        ini_write_real(string(f),"xpos",0);
        ini_write_real(string(f),"ypos",0);
    }
    f = file_find_next();
    i++;
}
until(f=="");
ini_close();
_updater_mapSpriteNum = i;

logAdd("Updater initiated");
