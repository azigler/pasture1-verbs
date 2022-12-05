#3:opposite_direction   this none this rxd

{?what = ""} = args;
return `what == "" ? $failed_match | (["north" -> "south", "east" -> "west", "south" -> "north", "west" -> "east", "up" -> "down", "down" -> "up", "northwest" -> "southeast", "northeast" -> "southwest", "southwest" -> "northeast", "southeast" -> "northwest", "in" -> "out", "out" -> "in"])[what] ! ANY => 0';
"Last modified Mon Dec  5 18:10:20 2022 UTC by caranov (#133).";
