#136:read   this none none rxd

uncompleted = completed = {};
for i in (this.elements)
  uncompleted = {@uncompleted, i};
endfor
for i in (this.completed)
  completed = {@completed, i};
endfor
player:tell_lines({"Uncompleted tasks,", @uncompleted, "----", "completed tasks,", @completed});
