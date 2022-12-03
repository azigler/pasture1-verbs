#20:newmatch   this none this rxd

{subject, ?olist = player.location, ?listform = 0} = args;
typeof(olist) == OBJ && (olist = olist:contents());
if (subject == "")
  return $nothing;
endif
found = {};
for i in (olist)
  if (is_player(i))
    olist = setremove(olist, i);
    olist = listinsert(olist, i, 1);
  endif
endfor
for i in (olist)
  str_list = {};
  if (valid(i) && subject in i:title())
    subject in i:title() != 0 && (str_list = {@i.aliases, @i:title():explode()});
    if (subject in i:title())
      found = found:add(i);
    endif
  else
    for string in (str_list)
      #133:tell("ind");
      if (index(string, subject) != 0)
        found = found:add(i);
        "break;";
      endif
    endfor
  endif
endfor
if (!found)
  found = {$failed_match};
endif
return listform == 1 ? found == {#-3} ? found[1] | found | found[1];
"Last modified Sat Dec  3 14:50:08 2022 UTC by caranov (#133).";
