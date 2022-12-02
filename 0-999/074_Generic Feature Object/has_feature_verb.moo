#74:has_feature_verb   this none this rxd

":has_feature_verb(verb, dlist, plist, ilist)";
"If this feature has a feature verb that matches <verb> and whose {dobj, prep, iobj} arguments match the possibilities listed in <dlist>, <plist> and <ilist>, then return the name of that verb, otherwise return false.";
"Note: Individual FOs may over-ride this the method to redirect particular feature verbs to different verbs on the object. For example, 'sit with <any>' and 'sit on <any>' could be directed to separate :sit_with() and :sit_on() verbs -- which is something that the code below cannot do.";
{vrb, dlist, plist, ilist} = args;
if (`valid(loc = $object_utils:has_callable_verb(this, vrb)[1]) ! ANY => 0')
  vargs = verb_args(loc, vrb);
  if (vargs[2] in plist && (vargs[1] in dlist && vargs[3] in ilist))
    return vrb;
  endif
endif
return 0;
