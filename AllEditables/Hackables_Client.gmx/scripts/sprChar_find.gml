///sprChar_find(filename)
for(var i=0; i<array_height_2d(global.sprChar); i++)
{
    if(global.sprChar[i,Sprites.file] == argument0)
    {
        return i;
    }
}
return sPlayer; //if not found, return the loading sprite
