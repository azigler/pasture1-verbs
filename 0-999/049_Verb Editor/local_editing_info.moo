#49:local_editing_info   this none this rxd

if (caller == $verb_editor)
  set_task_perms(player);
endif
{object, vname, code} = args;
if (typeof(vname) == LIST)
  vargs = tostr(" ", vname[2], " ", $code_utils:short_prep(vname[3]), " ", vname[4]);
  vname = vname[1];
else
  vargs = "";
endif
name = tostr(object.name, ":", vname);
ref = tostr(object, ":", vname);
"... so the next 2 lines are actually wrong, since verb_info won't";
"... necessarily retrieve the correct verb if we have more than one";
"... matching the given same name; anyway, if parse_invoke understood vname,";
"... so will @program.  I suspect these were put here because in the";
"... old scheme of things, vname was always a number.";
"vname = strsub($string_utils:explode(verb_info(object, vname)[3])[1], \"*\", \"\")";
"vargs = verb_args(object, vname)";
"";
simpleedit = $mcp.registry:match_package("dns-org-mud-moo-simpleedit");
if (simpleedit != $failed_match && simpleedit.v_filter_out)
  code = simpleedit.v_filter_out[1]:(simpleedit.v_filter_out[2])(code);
endif
return {name, code, tostr("@program ", object, ":", vname, vargs), ref, "moo-code"};
