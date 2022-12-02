#124:cmd_reload   this none this rxd

text = args[$].text;
args = args[1..$ - 1];
player:tell("Reloading...");
"Maintain text through reloads.";
if (length(args) >= 1)
  args[1] = text;
endif
return this:editor(@args);
