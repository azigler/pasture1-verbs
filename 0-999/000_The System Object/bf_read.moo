#0:bf_read   this none this rxd

set_task_perms(caller_perms());
`player.reading_input = 1 ! E_PROPNF, E_INVIND';
input = `read(@args) ! ANY';
`clear_property(player, "reading_input") ! E_PROPNF, E_INVARG';
return typeof(input) == ERR && $code_utils:dflag_on() ? raise(input) | input;
