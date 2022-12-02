#41:set   this none this rxd

"$gender_utils:set(object,gender) --- sets the pronoun properties of object.";
"gender is a string: one of the strings in $gender_utils.genders, the list of rcognized genders.  If the gender change is successful, the (full) name of the gender (e.g., \"male\") is returned.  E_NONE is returned if gender does not match any recognized gender.  Any other error encountered (e.g., E_PERM, E_PROPNF) is likewise returned and the object's pronoun properties are left unaltered.";
set_task_perms(caller_perms());
{object, gender} = args;
if (this == object)
  return E_DIV;
elseif (gnum = $string_utils:find_prefix(gender, this.genders))
  gender = this.genders[gnum];
else
  return E_NONE;
endif
save = {};
prons = this.pronouns;
for p in (prons)
  save = {@save, e = `object.(p) ! ANY'};
  if (typeof(e) != STR || typeof(e = `object.(p) = this.(p)[gnum] ! ANY') == ERR)
    for i in [1..length(save) - 1]
      object.(prons[i]) = save[i];
    endfor
    return e;
  endif
endfor
return gender;
