///user_write(username,password,warnings,kicks,ban,mon1 arr,mon2 arr,mon3 arr,mon4 arr)
//return a string to write to file
var i=1;
return ( string(argument0) //username
    +";"+string(argument1) //password (hash)
    +";"+string(argument2) //warnings
    +";"+string(argument3) //kicks
    +";"+string(argument4) //ban
    +";"+string(argument5[@ 0]) //monster 1 file
    +";"+string(argument5[@ 1]) //monster 1 skill file
    +";"+string(argument5[@ 2]) //monster 1 level
    +";"+string(argument5[@ 3]) //monster 1 health
    +";"+string(argument5[@ 4]) //monster 1 offence
    +";"+string(argument5[@ 5]) //monster 1 defence
    +";"+string(argument5[@ 6]) //monster 1 speed
    +";"+string(argument6[@ 0]) //monster 2 file
    +";"+string(argument6[@ 1]) //monster 2 skill file
    +";"+string(argument6[@ 2]) //monster 2 level
    +";"+string(argument6[@ 3]) //monster 2 health
    +";"+string(argument6[@ 4]) //monster 2 offence
    +";"+string(argument6[@ 5]) //monster 2 defence
    +";"+string(argument6[@ 6]) //monster 2 speed
    +";"+string(argument7[@ 0]) //monster 3 file
    +";"+string(argument7[@ 1]) //monster 3 skill file
    +";"+string(argument7[@ 2]) //monster 3 level
    +";"+string(argument7[@ 3]) //monster 3 health
    +";"+string(argument7[@ 4]) //monster 3 offence
    +";"+string(argument7[@ 5]) //monster 3 defence
    +";"+string(argument7[@ 6]) //monster 3 speed
    +";"+string(argument8[@ 0]) //monster 4 file
    +";"+string(argument8[@ 1]) //monster 4 skill file
    +";"+string(argument8[@ 2]) //monster 4 level
    +";"+string(argument8[@ 3]) //monster 4 health
    +";"+string(argument8[@ 4]) //monster 4 offence
    +";"+string(argument8[@ 5]) //monster 4 defence
    +";"+string(argument8[@ 6]) //monster 4 speed
    )
