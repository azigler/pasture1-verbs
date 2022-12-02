#4:_messagify   this none this rxd

"Given any of several formats people are likely to use for a @message";
"property, return the canonical form (\"foobar_msg\").";
name = args[1];
if (name[1] == "@")
  name = name[2..$];
endif
if (length(name) < 4 || name[$ - 3..$] != "_msg")
  name = name + "_msg";
endif
return name;
