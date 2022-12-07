#185:initialize   this none this rxd

pass(@args);
debug = #2;
while (length(this.contents) < this.slots)
  egg = create($egg);
  egg.name = "egg";
  move(egg, this);
endwhile
debug:tell(" -> Created " + tostr(length(this.contents)) + " " + $s("egg", this.slots) + " and moved it inside.");
"Last modified Wed Dec  7 13:35:15 2022 UTC by caranov (#133).";
