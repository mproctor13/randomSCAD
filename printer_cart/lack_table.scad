
lack_table();

module lack_table(){
    translate([0,0,400]) lack_top();
    for(X=[-1,1], Y=[-1,1]) translate([247.5*X, 247.5*Y, 0]) lack_leg();
}

module lack_leg(){
    translate([0,0,200]) cube([50,50,400], center=true);
}

module lack_top(){
    translate([0,0,25]) cube([550,550,50], center=true);
}

