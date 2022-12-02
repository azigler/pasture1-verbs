#75:_controls_property   this none this x

{who, what, name} = args;
return who == property_info(what, name)[1] || who.wizard;
