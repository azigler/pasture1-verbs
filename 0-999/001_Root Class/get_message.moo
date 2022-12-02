#1:get_message   this none this rxd

":get_message(msg_name)";
"Use this to obtain a given user-customizable message's raw value, i.e., the value prior to any pronoun-substitution or incorporation of any variant elements --- the value one needs to supply to :set_message().";
"=> error (use E_PROPNF if msg_name isn't recognized)";
"=> string or list-of-strings raw value";
"=> {2, @(list of {msg_name_n,rawvalue_n} pairs to give to :set_message)}";
"=> {1, other kind of raw value}";
"=> {E_NONE, error message} ";
if (!(caller == this || $perm_utils:controls(caller_perms(), this)))
  return E_PERM;
elseif ((t = typeof(msg = `this.(args[1] + "_msg") ! ANY')) in {ERR, STR} || (t == LIST && msg && typeof(msg[1]) == STR))
  return msg;
else
  return {1, msg};
endif
