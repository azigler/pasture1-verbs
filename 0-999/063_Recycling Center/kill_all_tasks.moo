#63:kill_all_tasks   this none this rxd

"kill_all_tasks ( object being recycled )";
" -- kill all tasks involving this now-recycled object";
caller == this || caller == #0 || raise(E_PERM);
{object} = args;
typeof(object) == OBJ || typeof(object) == ANON || raise(E_INVARG);
if (!valid(object))
  fork (0)
    for t in (queued_tasks())
      for c in (`task_stack(t[1]) ! E_INVARG => {}')
        if (object in c)
          kill_task(t[1]);
          continue t;
        endif
      endfor
    endfor
  endfork
endif
