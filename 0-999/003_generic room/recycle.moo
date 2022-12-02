#3:recycle   this none this rxd

"Make a mild attempt to keep people and objects from ending up in #-1 when people recycle a room";
if (caller == this || $perm_utils:controls(caller_perms(), this))
  "... first try spilling them out onto the floor of enclosing room if any";
  if (valid(this.location))
    for x in (this.contents)
      try
        x:moveto(this.location);
      except (ANY)
        continue x;
      endtry
    endfor
  endif
  "... try sending them home...";
  for x in (this.contents)
    if (is_player(x))
      if (typeof(x.home) == OBJ && valid(x.home))
        try
          x:moveto(x.home);
        except (ANY)
          continue x;
        endtry
      endif
      if (x.location == this)
        move(x, $player_start);
      endif
    elseif (valid(x.owner))
      try
        x:moveto(x.owner);
      except (ANY)
        continue x;
      endtry
    endif
  endfor
  pass(@args);
else
  return E_PERM;
endif
