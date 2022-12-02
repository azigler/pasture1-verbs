#58:@db*size   none none none rd

set_task_perms(player);
"Let 'em @kill it.";
count = (maxobj = toint(max_object()) + 1) - length(recycled_objects());
player:notify(tostr("There are ", count, " valid objects out of ", maxobj, " allocated object numbers."));
