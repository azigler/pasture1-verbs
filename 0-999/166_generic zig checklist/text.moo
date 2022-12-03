#166:text   this none this rxd

cp = caller_perms();
numbered = {};
for item, index in (this.text)
  numbered = listappend(numbered, tostr(index) + ". " + item);
endfor
if ($perm_utils:controls(cp, this) || this:is_readable_by(cp))
  return numbered;
else
  return E_PERM;
endif
