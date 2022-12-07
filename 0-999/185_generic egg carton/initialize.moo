#185:initialize   this none this rxd

pass(@args);
debug = #2;
while (length(this.contents) < this.slots)
  egg = create($egg);
  egg.name = "egg";
  move(egg, this);
endwhile
debug:tell("Made " + tostr(length(this.contents)) + " " + $s("egg", this.slots) + ".");
