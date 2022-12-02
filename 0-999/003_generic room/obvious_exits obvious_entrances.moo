#3:"obvious_exits obvious_entrances"   this none this rxd

exits = {};
for exit in (`verb == "obvious_exits" ? this.exits | this.entrances ! ANY => {}')
  if (`$code_utils:verb_or_property(exit, "obvious") ! ANY')
    exits = setadd(exits, exit);
  endif
endfor
return exits;
