#136:@remove   any (out of/from inside/from) this rxd

if (!isa(player, #58))
  return player:tell("You cannot modify this.");
endif
element = toint(dobjstr);
try
  this.elements = listdelete(this.elements, element);
except e (ANY)
  return player:tell(e[2]);
endtry
$you:say_action("%N %<erases> something on %T.", player, this);
