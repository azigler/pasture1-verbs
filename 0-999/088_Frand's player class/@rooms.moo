#88:@rooms   none none none rxd

"'@rooms' - List the rooms which are known by name.";
line = "";
for item in (this.rooms)
  line = line + item[1] + "(" + tostr(item[2]) + ")   ";
endfor
player:tell(line);
