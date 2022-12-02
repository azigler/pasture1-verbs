#14:set_message_body_by_index   this none this rxd

{i, body} = args;
if (!this:ok_write(caller, caller_perms()))
  "... maybe someday let people edit messages they've sent?";
  "... && !(this:ok(caller, caller_perms()) && (seq = this:own_messages_filter(caller_perms(), @args))) ???";
  return E_PERM;
endif
{bodyprop, @rest} = this._mgr:find_nth(this.messages, i);
if (!body)
  if (bodyprop)
    this:_kill(bodyprop);
    this._mgr:set_nth(this.messages, i, {0, @rest});
  endif
elseif (bodyprop)
  if (typeof(body) != LIST)
    raise(E_TYPE);
  endif
  this.(bodyprop) = body;
else
  bodyprop = this:_make(@body);
  this._mgr:set_nth(this.messages, i, {bodyprop, @rest});
endif
