#99:update_all   this none this rx

if (!this:trusts(caller_perms()))
  return E_PERM;
endif
codes = this.extra_codes;
"...we really don't need group regexps anymore, but I'm going to keep them around for a while just in case...";
for x in (this.groups)
  this.(tostr("group_", x, "_regexp")) = tostr("%[%(", $string_utils:from_list(g = this.("group_" + x), "%|"), "%)%]");
  codes = {@codes, @g};
endfor
this.all = codes;
this.all_regexp = tostr("%[%(b:%)?%(", $string_utils:from_list(codes, "%|"), "%|", this.xterm_256_regexp, "%|", this.truecolor_regexp, "%)%]");
this.terminate_regexp = tostr("%[%(b:%)?%(", $string_utils:from_list($set_utils:difference(codes, {@this.default_codes, @this.group_extra}), "%|"), "%|", this.xterm_256_regexp, "%|", this.truecolor_regexp, "%)%]");
this.notify_regexp = tostr("%[%(b:%)?%(", $string_utils:from_list(setremove(codes, "null"), "%|"), "%|", this.xterm_256_regexp, "%|", this.truecolor_regexp, "%)%]");
colors = {};
ccs = {};
for x in (this.group_colors)
  if (!((a = this:get_code(x, "ESC")) in ccs))
    colors = setadd(colors, x);
    ccs = setadd(ccs, a);
  endif
endfor
this.random_colors = colors;
this.replace_code_pointers = {};
index = 0;
leaves = $object_utils:leaves_suspended($ansi_pc);
data = {};
ll = length(leaves);
"...this will probably have to suspend on most large MOOs but you'll have to rewrite it so it can..";
while (index <= ll)
  index = index + 1;
  if (!is_player(leaves[index]))
  elseif (typeof(x = this:update_player_codes(leaves[index])) != LIST)
  elseif (!(i = $list_utils:iassoc(x, data, 2)))
    data = listappend(data, {1, x});
  elseif ((data[i][1] + 1) * length(x) / ll >= 6)
    "Must be at least 25% of people for 25 element long lists...";
    "                 50%               12...";
    "                 12%               50... etc";
    this.replace_code_pointers = listappend(this.replace_code_pointers, x);
    index = 0;
    data = {};
  else
    data[i][1] = data[i][1] + 1;
  endif
endwhile
