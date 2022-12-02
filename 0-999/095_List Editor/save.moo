#95:save   any any any rd

if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
  return;
endif
if (dobjstr)
  if (objprop = this:property_match_result(dobjstr))
    this.objects[who] = objprop[1];
    this.properties[who] = objprop[2];
  else
    return;
  endif
else
  objprop = {this.objects[who], this.properties[who]};
endif
value_list = this:to_value(@this:text(who));
if (value_list[1])
  player:tell("Error on line ", value_list[1], ":  ", value_list[2]);
  player:tell("Value not saved to ", this:working_on(who));
elseif (result = this:set_property(@objprop, value_list[2]))
  player:tell("Value written to ", this:working_on(who), ".");
  this:set_changed(who, 0);
else
  player:tell(result);
  player:tell("Value not saved to ", this:working_on(who));
endif
