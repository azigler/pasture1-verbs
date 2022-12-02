#136:@checkoff   any (on top of/on/onto/upon) this rxd

if (!isa(player, #58))
  return player:tell("You cannot modify this.");
endif
element = toint(dobjstr);
try
  this.completed = setadd(this.completed, this.element[element]);
  this.elements = listdelete(this.elements, element);
except e (ANY)
  return player:tell(e[2]);
endtry
$you:say_action("%N %<checks> off something on %T.", player, this);
