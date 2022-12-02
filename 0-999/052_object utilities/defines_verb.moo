#52:defines_verb   this none this rxd

"Returns 1 if the verb is actually *defined* on this object, 0 else.";
"Use this instead of :has_verb if your aim is to manipulate that verb code or whatever.";
return `verb_info(@args) ! ANY => 0' && 1;
"Old code below...Ho_Yan 10/22/96";
info = verb_info(@args);
return typeof(info) != ERR;
