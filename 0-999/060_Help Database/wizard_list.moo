#60:wizard_list   this none this rxd

wizzes = {};
for w in ($object_utils:leaves($wiz))
  if (w.wizard && (w.advertised && is_player(w)))
    wizzes = {@wizzes, w};
  endif
endfor
wizzes = {#2, @$list_utils:randomly_permute(setremove(wizzes, #2))};
numwiz = length(wizzes);
hlist = {"ArchWizard:", "Wizard" + (numwiz == 2 ? ":" | "s:"), @$list_utils:make(max(0, numwiz - 2), "")};
slist = {};
su = $string_utils;
for i in [1..numwiz]
  wiz = wizzes[i];
  slist = {@slist, tostr(su:left(hlist[i], 13), su:left(wiz.name, 16), (wpi = `wiz.public_identity.name ! ANY') ? " (a.k.a. " + wpi + ")" | "")};
endfor
return slist;
