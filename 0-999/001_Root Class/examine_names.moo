#1:examine_names   this none this rxd

"examine_names(examiner)";
"Return a list of strings to be told to the player, indicating the name and aliases (and, by default, the object number) of this.";
return {tostr(this.name, " (aka ", $string_utils:english_list({tostr(this), @this.aliases}), ")")};
