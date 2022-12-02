#59:verb_or_property   this none this rxd

"verb_or_property(<obj>, <name> [, @<args>])";
"Looks for a callable verb or property named <name> on <obj>.";
"If <obj> has a callable verb named <name> then return <obj>:(<name>)(@<args>).";
"If <obj> has a property named <name> then return <obj>.(<name>).";
"Otherwise return E_PROPNF, or E_PERM if you don't have permission to read the property.";
set_task_perms(caller_perms());
{object, name, @rest} = args;
return `object:(name)(@rest) ! E_VERBNF, E_INVIND => `object.(name) ! ANY'';
