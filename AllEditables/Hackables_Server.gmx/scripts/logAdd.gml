///logAdd(str)
//log[| ds_list_size(log)] = argument0;
ds_list_insert(log,1,argument0);
if(ds_list_size(log)>127) ds_list_delete(log,128);
