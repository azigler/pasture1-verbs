#32:get_input   this none this rxd

set_task_perms(caller_perms());
source = args[1];
data = {};
ref = $code_utils:parse_propref(source);
if (ref)
  "User entered a prop. Deal with it.";
  {thing, prop} = ref;
  thing = $string_utils:match_object(thing, player.location);
  if (!valid(thing))
    player:tell("No such object: ", ref[1]);
    data = $failed_match;
  elseif (!prop || `thing.(tostr(prop)) ! ANY' == E_PROPNF)
    player:tell("There is no such property `", prop, "' on object ", thing, ".");
    data = $failed_match;
  else
    data = `thing.(tostr(prop)) ! ANY';
    if (typeof(data) == STR)
      data = {data};
    endif
    $command_utils:suspend_if_needed(3);
    if (typeof(data) == ERR)
      player:tell("Error: ", tostr(data));
      data = $failed_match;
    elseif (typeof(data) != LIST)
      player:tell("Spellchecker needs a string or list as input.");
      data = $failed_match;
    endif
  endif
else
  ref = $code_utils:parse_verbref(source);
  if (ref)
    "User entered a verb. Deal with it.";
    {thing, verb} = ref;
    thing = $string_utils:match_object(thing, player.location);
    if (!valid(thing))
      player:tell("No such object: ", ref[1]);
      data = $failed_match;
    elseif (`verb_info(thing, verb) ! ANY' == E_VERBNF)
      player:tell("There is no such verb `", verb, "' on object ", thing, ".");
      data = $failed_match;
    else
      data = `verb_code(thing, verb) ! ANY => {}';
      for i in [1..length(data)]
        if (!index(data[i], "\""))
          data[i] = "";
        else
          data[i] = data[i][index(data[i], "\"") + 1..$];
          data[i] = data[i][1..rindex(data[i], "\"") - 1];
          foo = "";
          while (index(data[i], "\""))
            foo = foo + data[i][1..index(data[i], "\"") - 1];
            foo = foo + " ";
            data[i] = data[i][index(data[i], "\"") + 1..$];
            data[i] = data[i][index(data[i], "\"") + 1..$];
          endwhile
          if (foo == "")
            foo = data[i];
          else
            foo = foo + data[i];
          endif
          data[i] = $string_utils:trim(foo);
        endif
      endfor
    endif
  else
    "User entered word/phrase on command line.";
    data = {argstr};
  endif
endif
for i in [1..length(data)]
  $command_utils:suspend_if_needed(1);
  if (typeof(data[i]) != STR)
    data[i] = "";
  endif
  data[i] = $string_utils:strip_chars(data[i], "!@#$%^&*()_+1234567890={}[]`<>?:;,./|\"~'");
endfor
return data;
