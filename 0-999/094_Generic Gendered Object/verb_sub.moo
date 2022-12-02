#94:verb_sub   this none this rxd

"Copied from generic player (#6):verb_sub by ur-Rog (#6349) Fri Jan 22 11:20:11 1999 PST";
"This verb was copied by TheCat on 01/22/99, so that the generic gendered object will be able to do verb conjugation as well as pronoun substitution.";
text = args[1];
if (a = `$list_utils:assoc(text, this.verb_subs) ! ANY')
  return a[2];
else
  return $gender_utils:get_conj(text, this);
endif
