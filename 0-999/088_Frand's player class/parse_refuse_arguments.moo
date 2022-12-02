#88:parse_refuse_arguments   this none this rxd

"'parse_refuse_arguments (<string>)' -> {<who>, <actions>, <duration>} - Parse the arguments of a @refuse or @unrefuse command. <who> is the player requested, or $nothing if none was. <actions> is a list of the actions asked for. <duration> is how long the refusal should last, or 0 if no expiration is given. <errors> is a list of actions (or other words) which are wrong. If there are any errors, this prints an error message and returns 0.";
words = $string_utils:explode(args[1]);
possible_actions = this:refusable_actions();
who = $nothing;
actions = {};
until = this.default_refusal_time;
errors = {};
skip_to = 0;
for i in [1..length(words)]
  word = words[i];
  if (i <= skip_to)
  elseif (which = $string_utils:find_prefix(word, possible_actions))
    actions = setadd(actions, possible_actions[which]);
  elseif (word[$] == "s" && (which = $string_utils:find_prefix(word[1..$ - 1], possible_actions)))
    "The word seems to be the plural of an action.";
    actions = setadd(actions, possible_actions[which]);
  elseif (results = this:translate_refusal_synonym(word))
    actions = $set_utils:union(actions, results);
  elseif (word == "from" && i < length(words))
    "Modified to allow refusals from all guests at once. 5-27-94, Gelfin";
    if (words[i + 1] == "guests")
      who = "all guests";
    elseif (!(typeof(who = $code_utils:toobj(words[i + 1])) == OBJ))
      who = $string_utils:match_player(words[i + 1]);
      if ($command_utils:player_match_failed(who, words[i + 1]))
        return 0;
      endif
    endif
    skip_to = i + 1;
  elseif (word == "for" && i < length(words))
    n_words = this:parse_time_length(words[i + 1..$]);
    until = this:parse_time(words[i + 1..i + n_words]);
    if (!until)
      return 0;
    endif
    skip_to = i + n_words;
  else
    errors = {@errors, word};
  endif
endfor
if (errors)
  player:tell(length(errors) > 1 ? "These parts of the command were not understood: " | "This part of the command was not understood: ", $string_utils:english_list(errors, 0, " ", " ", " "));
  return 0;
endif
return {this:player_to_refusal_origin(who), actions, until};
