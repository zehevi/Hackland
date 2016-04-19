///net_connect()
var tsock = async_load[? "socket"];
var tIP = async_load[? "ip"];
var tPORT = async_load[? "port"];

var err = noone;
with(oClient)
{
    if(tsock==sock && tIP==ip && tPORT==port) err = sock;
}

if(err)
{
    logAdd("Multiple login attempt from socket: "+string(err));
}
else
{
    with(instance_create(0,0,oClient))
    {
        sock = tsock;
        ip = tIP;
        port = tPORT;
        Clients[? sock] = id;
        logAdd("New connection established. ID:"+string(sock)+"; IP:"+string(ip)+"; PORT: "+string(port));
    }
}
