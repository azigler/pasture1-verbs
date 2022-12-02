#88:tell_ways   this none this rxd

":tell_ways (<list of exits>)' - Tell yourself a list of exits, for @ways. You can override it to print the exits in any format.";
exits = args[1];
answer = {};
for e in (exits)
  answer = {@answer, e.name + " (" + $string_utils:english_list(e.aliases) + ")"};
endfor
player:tell("Obvious exits: ", $string_utils:english_list(answer), ".");
