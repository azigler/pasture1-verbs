#20:"name_and_number nn name_and_number_list nn_list"   this none this rxd

"name_and_number(object [,sepr] [,english_list_args]) => \"ObjectName (#object)\"";
"Return name and number for OBJECT.  Second argument is optional separator (for those who want no space, use \"\").  If OBJECT is a list of objects, this maps the above function over the list and then passes it to $string_utils:english_list.";
"The third through nth arguments to nn_list corresponds to the second through nth arguments to English_list, and are passed along untouched.";
{objs, ?sepr = " ", @eng_args} = args;
if (typeof(objs) != LIST)
  objs = {objs};
endif
name_list = {};
for what in (objs)
  name = valid(what) ? what.name | {"<invalid>", "$nothing", "$ambiguous_match", "$failed_match"}[1 + (what in {#-1, #-2, #-3})];
  name = tostr(name, sepr, "(", what, ")");
  name_list = {@name_list, name};
endfor
return this:english_list(name_list, @eng_args);
