#0:handle_task_timeout   this none this rxd

if (!callers())
  {resource, stack, traceback} = args;
  if (!$object_utils:connected(player))
    "Mail the player the traceback if e isn't connected.";
    $mail_agent:send_message(#0, player, {"traceback", $wiz_utils.gripe_recipients}, traceback);
  endif
  "now let the player do something with it if e wants...";
  return `player:(verb)(@args) ! ANY';
endif
