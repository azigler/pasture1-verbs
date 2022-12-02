#75:_parent_property_info   this none this xd

{object, property} = args;
for parent in (parents(object))
  this:_suspend_if_necessary();
  if (ret = `property_info(parent, property) ! E_PROPNF')
    return ret;
  endif
endfor
return {};
