#59:"find_verbs_containing find_verbs_matching find_verb_lines_containing find_verb_lines_matching"   this none this rxd

"$code_utils:find_verbs_containing(pattern[,object|object-list[,casematters]])";
"$code_utils:find_verbs_matching(pattern[,object|object-list[,casematters]])";
"$code_utils:find_verb_lines_containing(pattern[,object|object-list[,casematters]])";
"$code_utils:find_verb_lines_matching(pattern[,object|object-list[,casematters]])";
"";
"Print (to player) the name and owner of every verb in the database whose code";
"  (find_verbs_containing) contains PATTERN as a substring ";
"  (find_verbs_matching)   has a substring matches the regular expression PATTERN .";
"Optional second argument limits the search to the specified object or objects.";
"Optional third argument if true specifies case-sensitive matching.";
":find_verbs_*() prints the first matching line in a verb while";
":find_verb_lines_*() prints all matching lines";
"";
"Because it searches the entire database, this function may suspend the task several times before returning.";
"";
set_task_perms(caller_perms());
"... puts the task in a player's own job queue and prevents someone from learning about verbs that are otherwise unreadable to him/her.";
{pattern, ?where = 0, ?casematters = 0} = args;
count = 0;
_find_verbs = "_" + verb;
if (typeof(where) == INT)
  for o in [toobj(where)..max_object()]
    count = count + this:(_find_verbs)(pattern, o, casematters);
  endfor
elseif (typeof(where) == LIST)
  for o in (where)
    count = count + this:(_find_verbs)(pattern, o, casematters);
  endfor
else
  "...typeof(where) == OBJ...";
  count = this:(_find_verbs)(pattern, where, casematters);
endif
player:notify("");
player:notify(tostr("Total: ", count, " verb", count != 1 ? "s." | "."));
