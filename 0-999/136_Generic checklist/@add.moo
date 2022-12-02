#136:@add   any (at/to) this rxd

if (!isa(player, #58))
  return player:tell("You cannot modify this.");
endif
if (!dobjstr)
  return player:tell("What would you like to write on " + $string_utils:nn(this) + "?");
endif
this.elements = setadd(this.elements, dobjstr);
$you:say_action("%N %<adds> something to %T.", player, this);
