include <libs/vslot.scad>;

for(Y=[-1,1]) translate([0,(1500/2)*Y,0]) side();

for(X=[-1,1]) translate([X*((500/2)+40),(1500/2),10]) rotate([90,0,0]) vslot20x80(1500, vslot_color_black);


for(X=[-1,1]) translate([X*((500/2)+70),(1500/2),750]) rotate([90,90,0]) vslot20x80(1500, vslot_color_black);

for(X=[-1,1]) translate([X*((500/2)+70),(1500/2),1460]) rotate([90,90,0]) vslot20x80(1500, vslot_color_black);

translate([0,0,800]) tank_75();

module side(height=1500, width=500){
  for(X=[-1,1]) translate([X*((width/2)+40),0,0]) vslot20x80(height, vslot_color_black);

  for(Z=[-1,1]) translate([-(width/2),0,(height/2)+((height/2)*Z)-40*Z]) rotate([0,90,0]) vslot20x80(width, vslot_color_black);
}

module tank_75(){
  tank(width=48, depth=18, height=21);
}

module tank(width=48, depth=18, height=21){
  translate([0,0,((height/2)*25.4)]) %cube([(18*25.4), (48*25.4), (height*25.4)], center=true);
}
