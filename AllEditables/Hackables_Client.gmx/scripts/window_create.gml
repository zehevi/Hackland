///window_create(winObj,x,y,w,h)
var inst = instance_create(argument1,argument2,argument0);
inst.w = argument3;
inst.h = argument4;
with(inst) event_user(0);
return inst;
