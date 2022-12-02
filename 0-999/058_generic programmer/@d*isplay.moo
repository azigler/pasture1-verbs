#58:@d*isplay   any none none rd

"@display <object>[.[property]]*[,[inherited_property]]*[:[verb]]*[;[inherited_verb]]*";
if (player != this)
  player:notify(tostr("Sorry, you can't use ", this:title(), "'s `", verb, "' command."));
  return E_PERM;
endif
"null names for properties and verbs are interpreted as meaning all of them.";
opivu = {{}, {}, {}, {}, {}};
string = "";
punc = 1;
literal = 0;
set_task_perms(player);
for jj in [1..length(argstr)]
  j = argstr[jj];
  if (literal)
    string = string + j;
    literal = 0;
  elseif (j == "\\")
    literal = 1;
  elseif (y = index(".,:;", j))
    opivu[punc] = {@opivu[punc], string};
    punc = 1 + y;
    string = "";
  else
    string = string + j;
  endif
endfor
opivu[punc] = {@opivu[punc], string};
objname = opivu[1][1];
it = this:my_match_object(objname);
if ($command_utils:object_match_failed(it, objname))
  return;
endif
readable = it.owner == this || (it.r || this.wizard);
cant = {};
if ("" in opivu[2])
  if (readable)
    prop = properties(it);
  else
    prop = {};
    cant = setadd(cant, it);
  endif
  if (!this:display_option("thisonly"))
    what = it;
    while (!prop && valid(what = parent(what)))
      if (what.owner == this || (what.r || this.wizard))
        prop = properties(what);
      else
        cant = setadd(cant, what);
      endif
    endwhile
  endif
else
  prop = opivu[2];
endif
if ("" in opivu[3])
  inh = {};
  for what in ({it, @$object_utils:ancestors(it)})
    if (what.owner == this || what.r || this.wizard)
      inh = {@inh, @properties(what)};
    else
      cant = setadd(cant, what);
    endif
  endfor
else
  inh = opivu[3];
endif
for q in (inh)
  if (q in `properties(it) ! ANY => {}')
    prop = setadd(prop, q);
    inh = setremove(inh, q);
  endif
endfor
vrb = {};
if ("" in opivu[4])
  if (readable)
    vrbs = verbs(it);
  else
    vrbs = $object_utils:accessible_verbs(it);
    cant = setadd(cant, it);
  endif
  what = it;
  if (!this:display_option("thisonly"))
    while (!vrbs && valid(what = parent(what)))
      if (what.owner == this || (what.r || this.wizard))
        vrbs = verbs(what);
      else
        cant = setadd(cant, what);
      endif
    endwhile
  endif
  for n in [1..length(vrbs)]
    vrb = setadd(vrb, {what, n});
  endfor
else
  for w in (opivu[4])
    if (y = $object_utils:has_verb(it, w))
      vrb = setadd(vrb, {y[1], w});
    else
      this:notify(tostr("No such verb, \"", w, "\""));
    endif
  endfor
endif
if ("" in opivu[5])
  for z in ({it, @$object_utils:ancestors(it)})
    if (this == z.owner || z.r || this.wizard)
      for n in [1..length(verbs(z))]
        vrb = setadd(vrb, {z, n});
      endfor
    else
      cant = setadd(cant, z);
    endif
  endfor
else
  for w in (opivu[5])
    if (typeof(y = $object_utils:has_verb(it, w)) == LIST)
      vrb = setadd(vrb, {y[1], w});
    else
      this:notify(tostr("No such verb, \"", w, "\""));
    endif
  endfor
endif
if ({""} in opivu || opivu[2..5] == {{}, {}, {}, {}})
  this:notify(tostr(it.name, " (", it, ") [ ", it.r ? "readable " | "", it.w ? "writeable " | "", it.f ? "fertile " | "", is_player(it) ? "(player) " | "", it.programmer ? "programmer " | "", it.wizard ? "wizard " | "", "]"));
  if (it.owner != (is_player(it) ? it | this))
    this:notify(tostr("  Owned by ", valid(p = it.owner) ? p.name | "** extinct **", " (", p, ")."));
  endif
  this:notify(tostr("  Child of ", valid(p = parent(it)) ? p.name | "** none **", " (", p, ")."));
  if (it.location != $nothing)
    this:notify(tostr("  Location ", valid(p = it.location) ? p.name | "** unplace (tell a wizard, fast!) **", " (", p, ")."));
  endif
  if ($quota_utils.byte_based && $object_utils:has_property(it, "object_size"))
    this:notify(tostr("  Size: ", $string_utils:group_number(it.object_size[1]), " bytes at ", this:ctime(it.object_size[2])));
  endif
endif
blankargs = this:display_option("blank_tnt") ? {"this", "none", "this"} | #-1;
for b in (vrb)
  $command_utils:suspend_if_needed(0);
  where = b[1];
  q = b[2];
  short = typeof(q) == INT ? q | strsub(y = index(q, " ") ? q[1..y - 1] | q, "*", "");
  inf = `verb_info(where, short) ! ANY';
  if (typeof(inf) == LIST || inf == E_PERM)
    name = typeof(inf) == LIST ? index(inf[3], " ") ? "\"" + inf[3] + "\"" | inf[3] | q;
    line = $string_utils:left(tostr($string_utils:right(tostr(where), 6), ":", name, " "), 32);
    if (inf == E_PERM)
      line = line + "   ** unreadable **";
    else
      line = $string_utils:left(tostr(line, inf[1].name, " (", inf[1], ") "), 53) + ((i = inf[2] in {"x", "xd", "d", "rd"}) ? {" x", " xd", "  d", "r d"}[i] | inf[2]);
      vargs = `verb_args(where, short) ! ANY';
      if (vargs != blankargs)
        if (this:display_option("shortprep") && !(vargs[2] in {"any", "none"}))
          vargs[2] = $code_utils:short_prep(vargs[2]);
        endif
        line = $string_utils:left(line + " ", 60) + $string_utils:from_list(vargs, " ");
      endif
    endif
    this:notify(line);
  elseif (inf == E_VERBNF)
    this:notify(tostr(inf));
    this:notify(tostr("  ** no such verb, \"", short, "\" **"));
  else
    this:notify("This shouldn't ever happen. @display is buggy.");
  endif
endfor
all = {@prop, @inh};
max = length(all) < 4 ? 999 | this:linelen() - 56;
depth = length(all) < 4 ? -1 | 1;
truncate_owner_names = length(all) > 1;
for q in (all)
  $command_utils:suspend_if_needed(0);
  inf = `property_info(it, q) ! ANY';
  if (inf == E_PROPNF)
    if (q in $code_utils.builtin_props)
      this:notify(tostr($string_utils:left("," + q, 25), "Built in property            ", $string_utils:abbreviated_value(it.(q), max, depth)));
    else
      this:notify(tostr("  ** property not found, \"", q, "\" **"));
    endif
  else
    pname = $string_utils:left(tostr(q in `properties(it) ! ANY => {}' ? "." | (`is_clear_property(it, q) ! ANY' ? " " | ","), q, " "), 25);
    if (inf == E_PERM)
      this:notify(pname + "   ** unreadable **");
    else
      oname = inf[1].name;
      truncate_owner_names && (length(oname) > 12 && (oname = oname[1..12]));
      `inf[2][1] != "r" ! E_RANGE => 1' && (inf[2][1..0] = " ");
      `inf[2][2] != "w" ! E_RANGE => 1' && (inf[2][2..1] = " ");
      this:notify($string_utils:left(tostr($string_utils:left(tostr(pname, oname, " (", inf[1], ") "), 47), inf[2], " "), 54) + $string_utils:abbreviated_value(it.(q), max, depth));
    endif
  endif
endfor
if (cant)
  failed = {};
  for k in (cant)
    failed = listappend(failed, tostr(k.name, " (", k, ")"));
  endfor
  this:notify($string_utils:centre(tostr(" no permission to read ", $string_utils:english_list(failed, ", ", " or ", " or "), ". "), 75, "-"));
else
  this:notify($string_utils:centre(" finished ", 75, "-"));
endif
