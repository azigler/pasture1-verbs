#75:_controls_verb   this none this x

{who, what, name} = args;
return who == verb_info(what, name)[1] || who.wizard;
