#99:test_benchmark   this none this rxd

if (caller != this)
  return E_PERM;
else
  new = $recycler:_create($ansi_pc);
  if (typeof(new) != OBJ)
    return player:tell("Unable to create Benchmark test player: ", new);
  endif
  new:set_name("Benchmark_test_player");
  suspend(0);
  ticks = ticks_left();
  seconds = seconds_left();
  for x in [1..3]
    $ansi_utils:notify(new, "[blue]B[bold]e[unbold]n[bold]c[unbold]h[bold]m[unbold]a[bold]r[unbold]k [red]T[bold]e[unbold]s[bold]t [random].[random].[random].[random].[random].");
  endfor
  for x in [1..3]
    $ansi_utils:notify(new, "[123:123:123]B[1:1:1]e[0:100:0]n[100:0:100]c[100:100:100]h[100:0:0]m[0:0:100]a[255:0:255]r[255:0:0]k [0:255:0]T[0:0:255]e[255:255:0]s[123:45:6]t.");
  endfor
  ticks = ticks - ticks_left();
  seconds = seconds - seconds_left();
  new:set_ansi_option("colors", 1);
  new:set_ansi_option("escape", "~");
  new:set_ansi_option("misc", 1);
  ticks = ticks + ticks_left();
  seconds = seconds + seconds_left();
  for x in [1..3]
    $ansi_utils:notify(new, "[blue]B[bold]e[unbold]n[bold]c[unbold]h[bold]m[unbold]a[bold]r[unbold]k [red]T[bold]e[unbold]s[bold]t [random].[random].[random].[random].[random].");
  endfor
  for x in [1..3]
    $ansi_utils:notify(new, "[123:123:123]B[1:1:1]e[0:100:0]n[100:0:100]c[100:100:100]h[100:0:0]m[0:0:100]a[255:0:255]r[255:0:0]k [0:255:0]T[0:0:255]e[255:255:0]s[123:45:6]t.");
  endfor
  for x in [1..3]
    $ansi_utils:notify(new, "Testing...");
  endfor
  this:add_noansi();
  for x in [1..3]
    $ansi_utils:notify(new, "[blue]B[bold]e[unbold]n[bold]c[unbold]h[bold]m[unbold]a[bold]r[unbold]k [red]T[bold]e[unbold]s[bold]t [random].[random].[random].[random].[random].");
  endfor
  for x in [1..3]
    $ansi_utils:notify(new, "[123:123:123]B[1:1:1]e[0:100:0]n[100:0:100]c[100:100:100]h[100:0:0]m[0:0:100]a[255:0:255]r[255:0:0]k [0:255:0]T[0:0:255]e[255:255:0]s[123:45:6]t.");
  endfor
  this:remove_noansi();
  ticks = ticks - ticks_left();
  seconds = seconds - seconds_left();
  $recycler:_recycle(new);
  player:tell("21 notifies: ", ticks, " tick", ticks == 1 ? "" | "s", ", ", seconds, " second", seconds == 1 ? "" | "s", ".");
endif
