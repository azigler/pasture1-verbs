#166:"cross*off complete check tick"   any (on top of/on/onto/upon) this rxd

crossed_index = toint(dobjstr);
if (length(this.text) < crossed_index)
  return player:tell("That item doesn't exist on the checklist.");
endif
$you:say_action("%N %<crosses> \"" + this.text[crossed_index] + "\" off %i.");
this.completed = listappend(this.completed, {this.text[crossed_index], player.name});
this.text = listdelete(this.text, crossed_index);
