#107:next_datakey   this none this rxd

datakey = tostr(random(), this.next_datakey);
this.next_datakey = this.next_datakey + 1;
return datakey;
