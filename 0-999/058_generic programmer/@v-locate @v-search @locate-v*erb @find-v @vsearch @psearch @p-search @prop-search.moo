#58:"@v-locate @v-search @locate-v*erb @find-v @vsearch @psearch @p-search @prop-search"   any any any rxd

if (player != this || !player.programmer)
  player:tell("Naw.");
  return E_PERM;
elseif (!args)
  return player:tell("Syntax: ", verb, " <search-term> [by <verb author>]");
endif
if (ind = $string_utils:index_d(argstr, "by"))
  match = {};
  author = argstr[ind + 3..$];
  argstr = argstr[1..ind - 2];
  for x in (players())
    if (x.programmer && (x.name == author || author in x.aliases || index(x.name, author)))
      match = setadd(match, x);
    endif
    yin();
  endfor
  if (match == {})
    return player:tell("No verb authors by that name could be found.");
  elseif (length(match) > 1)
    player:tell("Which verb author did you mean?");
    author = $menu_utils:menu(match);
  else
    author = match[1];
  endif
else
  author = 0;
endif
if (verb in {"@psearch", "@p-search", "@prop-search"})
  type = "prop";
  {result, partresult} = $code_utils:locate_all_properties_by_name(argstr, author);
else
  type = "verb";
  {result, partresult} = $code_utils:locate_all_verbs_by_name(argstr, author);
endif
if (result == {} && partresult == {})
  return player:tell("There are no matches, partial or otherwise, for \"", argstr, "\".");
else
  ret = {{"Object Name", type == "prop" ? "Property Name" | "Verb Name"}};
  if (result)
    for x in (result)
      yin(0, 500);
      ref = $code_utils:corify_object(x[1]);
      ret = {@ret, {x[1] == #0 ? "The System Object (#0)" | tostr($string_utils:nn(x[1]), ref == 0 ? "" | " [" + ref + "]"), x[2]}};
    endfor
    if (partresult)
      ret = {@ret, {"", ""}};
    endif
  endif
  if (partresult)
    for x in (partresult)
      yin(0, 500);
      ref = $code_utils:corify_object(x[1]);
      ret = {@ret, {x[1] == #0 ? "The System Object (#0)" | tostr($string_utils:nn(x[1]), ref == 0 ? "" | " [" + ref + "]"), strsub(x[2], argstr, tostr("", argstr, ""))}};
    endfor
  endif
  player:tell_lines_suspended($string_utils:autofit(ret, 3, 1));
endif
