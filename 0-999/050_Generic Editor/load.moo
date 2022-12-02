#50:load   this none this rxd

texts = args[2];
if (!(fuckup = this:ok(who = args[1])))
  return fuckup;
elseif (typeof(texts) == STR)
  texts = {texts};
elseif (typeof(texts) != LIST || (length(texts) && typeof(texts[1]) != STR))
  return E_TYPE;
endif
this.texts[who] = texts;
this.inserting[who] = length(texts) + 1;
this.changes[who] = 0;
this.readable[who] = 0;
this.times[who] = time();
