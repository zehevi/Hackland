///battle_writeInfo(sock id)
//writes to wbuff but does not send the packet!

/*file = file_text_open_read(string(Clients[? argument0].name)+".user");
user_read(file_text_read_string(file));
file_text_close(file);

var i=1;
repeat(4)
{
    buffer_write(wbuff,buffer_string,global._user[? "monster"+string(i)+" file"]);
    buffer_write(wbuff,buffer_string,global._user[? "monster"+string(i)+" skill file"]);
    buffer_write(wbuff,buffer_u8,real(global._user[? "monster"+string(i)+" level"]));
    buffer_write(wbuff,buffer_u16,real(global._user[? "monster"+string(i)+" health"]));
    buffer_write(wbuff,buffer_u8,real(global._user[? "monster"+string(i)+" offence"]));
    buffer_write(wbuff,buffer_u8,real(global._user[? "monster"+string(i)+" defence"]));
    buffer_write(wbuff,buffer_u8,real(global._user[? "monster"+string(i)+" speed"]));
    i++;
}*/

with(Clients[? argument0])
{
    var i=1;
    repeat(4)
    {
        buffer_write(wbuff,buffer_string,monster[? "monster"+string(i)+" file"]);
        buffer_write(wbuff,buffer_string,monster[? "monster"+string(i)+" skill file"]);
        buffer_write(wbuff,buffer_u8,real(monster[? "monster"+string(i)+" level"]));
        buffer_write(wbuff,buffer_u16,real(monster[? "monster"+string(i)+" health"]));
        buffer_write(wbuff,buffer_u8,real(monster[? "monster"+string(i)+" offence"]));
        buffer_write(wbuff,buffer_u8,real(monster[? "monster"+string(i)+" defence"]));
        buffer_write(wbuff,buffer_u8,real(monster[? "monster"+string(i)+" speed"]));
        i++;
    }
}
