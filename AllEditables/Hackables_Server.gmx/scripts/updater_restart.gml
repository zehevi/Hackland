///updater_retart()
logAdd("Restarting updater...");
updater_init();

//send update info to all connected players
var inst,j;
for(var i=0; i<instance_number(oClient);i++)
{
    inst = instance_find(oClient,i);
    j=0;
    repeat(_updater_charSpriteNum){
        if(inst.spr_file == _updater_charSprite){
            inst.spr = j;
            break;
        }
    }
    updater_sendInfo(inst.sock);
}

//_updater_charSprite
