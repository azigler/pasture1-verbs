#64:time   this none this xd

{?local_offset = 0.0} = args;
base_time = time();
global_offset = this.global_offset;
time = base_time + global_offset;
return local_offset == 0.0 ? time | toint(tofloat(time) / local_offset);
