#42:controls   this none this rxd

"$perm_utils:controls(who, what)";
"Is WHO allowed to hack on WHAT?";
{who, what} = args;
return valid(who) && valid(what) && (who.wizard || who == what.owner);
