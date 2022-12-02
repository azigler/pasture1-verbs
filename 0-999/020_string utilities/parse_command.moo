#20:parse_command   this none this rxd

":parse_command(cmd_line[,player])";
" => {verb, {dobj, dobjstr}, {prep, prepstr}, {iobj, iobjstr}, {args, argstr},";
"     {dobjset, prepset, iobjset}}";
"This mimics the action of the builtin parser, returning what the values of the builtin variables `verb', `dobj', `dobjstr', `prepstr', `iobj', `iobjstr', `args', and `argstr' would be if `player' had typed `cmd_line'.  ";
"`prep' is the shortened version of the preposition found.";
"";
"`dobjset' and `iobjset' are subsets of {\"any\",\"none\"} and are used to determine possible matching verbs, i.e., the matching verb must either be on `dobj' and have verb_args[1]==\"this\" or else it has verb_args[1] in `dobjset'; likewise for `iobjset' and verb_args[3]; similarly we must have verb_args[2] in `prepset'.";
{c, ?who = player} = args;
y = $string_utils:words(c);
if (y == {})
  return {};
endif
vrb = y[1];
y = y[2..$];
as = y == {} ? "" | c[length(vrb) + 2..$];
n = 1;
while (!(gp = $code_utils:get_prep(@y[n..$]))[1] && n < length(y))
  n = n + 1;
endwhile
"....";
really = player;
player = who;
loc = who.location;
if (ps = gp[1])
  ds = $string_utils:from_list(y[1..n - 1], " ");
  is = $string_utils:from_list(listdelete(gp, 1), " ");
  io = valid(loc) ? loc:match_object(is) | $string_utils:match_object(is, loc);
else
  ds = $string_utils:from_list(y, " ");
  is = "";
  io = $nothing;
endif
do = valid(loc) ? loc:match_object(ds) | $string_utils:match_object(ds, loc);
player = really;
"....";
dset = {"any", @ds == "" ? {"none"} | {}};
"\"this\" must be handled manually.";
pset = {"any", @ps ? {$code_utils:full_prep(ps)} | {"none"}};
iset = {"any", @is == "" ? {"none"} | {}};
return {vrb, {do, ds}, {$code_utils:short_prep(ps), ps}, {io, is}, {y, as}, {dset, pset, iset}};
