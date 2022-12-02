#42:"controls_prop*erty controls_verb"   this none this rxd

"Syntax:  controls_prop(OBJ who, OBJ what, STR propname)   => 0 | 1";
"         controls_verb(OBJ who, OBJ what, STR verbname)   => 0 | 1";
"";
"Is WHO allowed to hack on WHAT's PROPNAME? Or VERBNAME?";
{who, what, name} = args;
bi = verb == "controls_verb" ? "verb_info" | "property_info";
return who.wizard || who == call_function(bi, what, name)[1];
