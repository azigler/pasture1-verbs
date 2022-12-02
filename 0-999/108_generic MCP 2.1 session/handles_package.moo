#108:handles_package   this none this rxd

{package} = args;
if (assoc = $list_utils:assoc(package, this.packages))
  return assoc[2];
endif
