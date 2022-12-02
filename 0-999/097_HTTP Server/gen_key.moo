#97:gen_key   this none this rxd

if (caller != this)
  return E_PERM;
endif
player = args[1];
object = args[2];
hash = (toint(player) + toint(object) + this.master_key) % 100000000;
if (length(args) > 2)
  salt = args[3];
  key = crypt(tostr(hash), salt);
else
  "Make it only alphanumeric salt, to get through a URL";
  salt = this.alpha[random(length(this.alpha))] + this.alpha[random(length(this.alpha))];
  key = crypt(tostr(hash), salt);
endif
"Clean out the non-alpha to make key work in a URL";
for i in [1..length(key)]
  if (j = index(this.nonalpha, key[i], 1))
    key[i] = this.alpha[j];
  endif
endfor
return key;
