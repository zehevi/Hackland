///updater_init()

//check directories
if(!directory_exists(APPDATA+"\content")) directory_create(APPDATA+"\content");
if(!directory_exists(APPDATA+"\content\characters")) directory_create(APPDATA+"\content\characters");
if(!directory_exists(APPDATA+"\content\maps")) directory_create(APPDATA+"\content\maps");
//read character sprites and create hashes
var i=0; f = file_find_first(APPDATA+"\content\characters\*.png",0);
if(f==""){
    logAdd("Error! No character were found; Please restart the server");
    exit;
}

do{
    _updater_charSprite[i] = f;
    //_updater_charSpriteHash[i] = sha1_file(APPDATA+"\content\characters\"+f);
    _updater_charSpriteHash[i] = ""; //NO HASHING
    _updater_charSpriteCode[i] = string_copy(f,0,string_length(f)-4); //set the charCode to the filename without the extention
    f = file_find_next();
    i++;
}
until(f=="");
_updater_charSpriteNum = i;

//Fix sprites num
with(oClient){
    logAdd(string(spr_file)+" != "+string(other._updater_charSprite[spr]));
    if(other._updater_charSprite[spr]!=spr_file){
        for(var i=0; i<other._updater_charSpriteNum; i++) {
            if(spr_file==other._updater_charSprite[i]){
                spr = i;
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

do{
    _updater_mapSprite[i] = f;
    //_updater_mapSpriteHash[i] = sha1_file(APPDATA+"\content\Maps\"+f);
    _updater_mapSpriteHash[i] = "";
    
    var xx,yy,mask,name;
    name = string_copy(f,1,string_length(f)-4);
    mask = "";
    sep = string_pos("_",f);
    xx = real(string_copy(f,1,sep-1));
    yy = real(string_copy(f,sep+1,string_length(f)-4-sep));
    ds_grid_set(global.maps, xx,yy, string(f));
    ds_grid_set(global.maps_mask, xx,yy, string(mask));
    ds_grid_set(global.maps_name, xx,yy, string(f));
    
    logAdd("Map found at: ("+string(xx)+","+string(yy)+")");
    
    f = file_find_next();
    i++;
}
until(f=="");
_updater_mapSpriteNum = i;

logAdd("Updater initiated");
