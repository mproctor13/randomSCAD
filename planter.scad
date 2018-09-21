

module onebyfour(length){
    cube([3.5,length,.75], center=true);
}

module sheet(){
//    25.75
}


module base(){
    for(X=[-1,1]) translate([(6-1.75)*X,0,0]) onebyfour(96);
    for(Y=[-1,1]) translate([0,(48-1.75)*Y,0]) rotate([0,0,90]) color("orange") onebyfour(12-7);

    for(X=[-1,1]) translate([(6-(.75/2))*X,0,1.75+(.75/2)]) rotate([0,90,0]) onebyfour(96);
    for(Y=[-1,1]) translate([0,(48-(.75/2))*Y,1.75+(.75/2)]) rotate([0,90,90]) color("orange") onebyfour(12-1.5);
}

module legs(){
    translate([0,0,36/2]) for(X=[-1,1], Y=[-1,0,1]) translate([(6+(.75/2))*X,(48-(3.5/2)+.75)*Y,0]) rotate([90,0,90]) onebyfour(36);
    translate([0,0,36/2]) for(X=[-1,1], Y=[-1,1]) translate([(6-1.75)*X,(48+(.75/2))*Y,0]) rotate([90,0,0]) onebyfour(36);
}


//legs();
//translate([0,0,22.7]) base();
//
//translate([0,0,36]) for(X=[-1,1]) translate([(6+1.75)*X,0,0]) onebyfour(96);
//translate([0,-48,36-(25.75/2)]) cube([1,96,(25.75/2)]);

module firepit(sides=3, base=12, top=30){
  rotate([0,0,(360/(sides*2))]){
    cylinder(d=(25.4*base), h=(25.4*0.125), $fn=sides);
    %cylinder(d1=(25.4*base), d2=(25.4*top), h=(25.4*10), $fn=sides);
  }
    for(R=[0:(360/sides):360])
      rotate([0,0,-90+R]) translate([-(25.4*(12/2)),(25.4*(12/2)),0]) rotate([50,0,0]) cube([(25.4*base), (25.4*base), (25.4*0.125)]);
}
// 3::120 4::90  5::72  6::60
firepit(sides=5, base=12);