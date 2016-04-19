///updater_requestFile(filename)
show_debug_message("Requesting file: "+string(argument0));
buffer_seek(wbuff,0,0);
buffer_write(wbuff,buffer_u8,Sock.UPDATEFILE);
buffer_write(wbuff,buffer_string,argument0);
network_send_packet(server,wbuff,buffer_tell(wbuff));
