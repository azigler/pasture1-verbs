# pasture1 changelog
## 12.08.2022:
- Replay has been added. Categories such as general, chat and say can be accessed by entering their name or partial name into the command. This also applies to message ranges, for instance replay 8 will show the last 8 messages of general, replay say 8 will do the same for the say category. All messages over an hour old will be periodically wiped to prevent replay clutter. (caranov): 07:51:09
## 12.07.2022:
- [$prog:@forked] Add the total number of returned tasks at the bottom. (Saeed): 17:39:54
- [$wiz:@code-review] Report how long the verb took to finish. (Saeed): 17:45:42
## 12.06.2022:
- source control now includes the changelog as README.md (Zig): 18:04:09
- Added $waif_utils (which is also $anon_utils) to find WAIFs and ANONs. Feel free to try it out. Example: $anon_utils:find_anons() (Zig): 22:32:53
## 12.05.2022:
- @locate command now exists for builderclass and above. (caranov): 17:47:08
- match_exit on $room should now find an exit by its first letter, regardless of custom exit status. (caranov): 17:47:08
- The moo will sync all verbs to git every 4 hours. all non-player object folders include a __dump.txt that includes a full copy-paste @dump with create. enjoy. (Zig): 18:55:38
## 12.04.2022:
- Added support for automatically going AFK and coming... BTK? Whatever. Anyway, you can configure it with the .autoafk_options property on yourself. The keys are: auto_afk (enable automatic AFK), auto_unafk (enable automatic un-AFK), and max_time (the time, in seconds, you're idle before going AFK). (lisdude): 03:46:34
- Added AUTOAFK-O to configure the recently-implemented AFK preferences through an options menu interface (because I'm a sucker for menues!) (Saeed): 04:48:59
- Added @advent, which will show Zig's private leaderboard for Advent of Code 2022. (lisdude): 21:03:31
