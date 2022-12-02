#88:translate_refusal_synonym   this none this rxd

"'translate_refusal_synonym (<word>)' -> list - If the <word> is a synonym for some set of refusals, return the list of those refusals. Otherwise return the empty list, {}. Programmers can override this verb to provide more synonyms.";
word = args[1];
if (word == "all")
  return this:refusable_actions();
endif
return {};
