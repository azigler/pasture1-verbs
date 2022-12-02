#99:color_selector   this none this rxd

{?raw = 0, ?input = 0, ?foreground_color = 0} = args;
colors = {"Red", "Green", "Blue", "Yellow", "Cyan", "Purple", "Gray", "White"};
backgrounds = {"Red", "Green", "Blue", "Yellow", "Cyan", "Purple", "White"};
menu = codes = {};
for x in (colors)
  if (!foreground_color)
    menu = {@menu, tostr(this:hr_to_code(code = x), x, "[normal]")};
    codes = {@codes, code};
    menu = {@menu, tostr(this:hr_to_code(code = "bold|" + x), "Bold ", x, "[normal]")};
    codes = {@codes, code};
  endif
  if (x in backgrounds)
    menu = {@menu, tostr(this:hr_to_code(code = "b:" + x), x == "white" ? "[gray]" | (foreground_color ? this:Hr_to_code(foreground_color) | "[white]"), "Background ", x, "[normal]")};
    codes = {@codes, code};
  endif
endfor
menu = {@menu, xterm = "Xterm 256 Value"};
if (player:ansi_option("truecolor"))
  menu = {@menu, rgb = "24-bit [red]R[normal][green]G[normal][blue]B[normal] Value"};
endif
menu = {@menu, "None"};
sel = $menu_utils:menu(menu, ["hidden_menu" -> input, "input" -> input]);
if (sel in {0, -1})
  return 0;
elseif (sel <= length(codes))
  retcode = codes[sel];
  if (retcode[1..2] == "b:")
    retcode = (foreground_color ? foreground_color | "white") + "|" + retcode;
  endif
  if (raw)
    return $ansi_utils:hr_to_code(retcode);
  else
    return retcode;
  endif
elseif (menu[sel] == "none")
  return "";
elseif (menu[sel] == xterm)
  player:tell("Please input an Xterm 256 value in between 0-255.");
  val = $command_utils:read();
  xtermint = $code_utils:toint(val);
  if (xtermint == E_TYPE || xtermint > 255 || xtermint < 0)
    return player:tell("Invalid input. You must enter a number that is in between 0 and 255.");
  endif
  if (raw)
    return tostr("[:", xtermint, "]");
  else
    return tostr(":", xtermint);
  endif
elseif (menu[sel] == rgb)
  red = green = blue = 0;
  invalidmsg = "Invalid color value.";
  while (!red || !green || !blue)
    if (!red)
      player:tell("Enter a [red]red[normal] value between 0 and 255:");
      red = toint($command_utils:read());
      if (red < 0 || red > 255)
        player:tell(invalidmsg);
        red = 0;
        continue;
      endif
    endif
    if (!green)
      player:tell("Enter a [green]green[normal] value between 0 and 255:");
      green = toint($command_utils:read());
      if (green < 0 || green > 255)
        player:tell(invalidmsg);
        green = 0;
        continue;
      endif
    endif
    if (!blue)
      player:tell("Enter a [blue]blue[normal] value between 0 and 255:");
      blue = toint($command_utils:read());
      if (blue < 0 || blue > 255)
        player:tell(invalidmsg);
        blue = 0;
        continue;
      endif
    endif
  endwhile
  if (raw)
    return tostr("[", red, ":", green, ":", blue, "]");
  else
    return tostr(red, ":", green, ":", blue);
  endif
endif
