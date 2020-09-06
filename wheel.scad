
main_dia=200;
outside_dia=180;

/*%cube([200,200,200], center=true);*/
/*cylinder(d=63, h=80, $fn=60, center=true);*/
//wheel_assembly();
//wheel(main_dia=200);
//wheel1(main_dia=200);

/*%circle(main_dia/5, $fn=60);*/
new_wheel();
module new_wheel(){

rotate_extrude(convexity=10, $fn=60) translate([30, 0])
    //circle(main_dia/5, $fn=60);
    hull(){
      for(Y=[-1,1]){
        translate([50, 30*Y, 0]) circle(20, $fn=60);
        translate([32, 67*Y, 0]) circle(3, $fn=60);
        translate([30, 60*Y, 0]) circle(5, $fn=60);
      }
      translate([30, 0, 0])
      difference(){
        %for(Y=[-1,1]) translate([0, 30*Y, 0]) circle(40, $fn=60);
        for(Y=[-1,1]) translate([0, 30*Y, 0]) circle(40, $fn=60);
        translate([-28, 0, 0])square(size = [60, 180], center=true);
      }
      //difference(){
        //%translate([30, 0, 0]) resize(newsize=[80,130,0], auto=true) circle(main_dia/5, $fn=60);
        //translate([0, 0, 0]) square(size = [50, 150], center=true);
        //translate([80, 0, 0]) square(size = [30, 120], center=true);
      //}

      translate([-10, 0, 0]) square(size = [10, 30], center=true);
    }
    /*hull(){
      translate([0, 30, 0]) resize(newsize=[120,80,0], auto=true) circle(main_dia/5, $fn=60);
      translate([0, -10, 0]) square(size = [60, 10], center=true);
    }*/
  }

module hex_array(angle=60, length=100){
  row_height=9;
  base_offset=20;
  translate([0,-base_offset+7,0])
      rotate([angle,0,0]) cylinder(d=8, h=length, $fn=6);
  translate([0,-base_offset-(row_height*1),0])
      rotate([angle,0,0]) cylinder(d=8, h=length, $fn=6);
  for(X=[-1,1]) translate([7*X,-base_offset-(row_height*2),0])
      rotate([angle,0,0]) cylinder(d=8, h=length, $fn=6);
  translate([0,-base_offset-(row_height*3),0])
      rotate([angle,0,0]) cylinder(d=8, h=length, $fn=6);

  for(X=[-1,1]) translate([7*X,-base_offset-(row_height*4),0])
      rotate([angle,0,0]) cylinder(d=8, h=length, $fn=6);

  for(X=[-1,0,1]) translate([14*X,-base_offset-(row_height*5),0])
      rotate([angle,0,0]) cylinder(d=8, h=length, $fn=6);
  for(X=[-1,1]) translate([7*X,-base_offset-(row_height*6),0])
      rotate([angle,0,0]) cylinder(d=8, h=length, $fn=6);
  for(X=[-1,0,1]) translate([14*X,-base_offset-(row_height*7),0])
      rotate([angle,0,0]) cylinder(d=8, h=length, $fn=6);
}

/*%translate([0,0,20]) cylinder(d=125, h=130, $fn=60, center=true);*/

module sk3_assembl(){
  translate([0,0,-50]) rotate([0,180,0]) sk3_6375(simple=false);

  translate([0,0,-55])
  difference(){
    cylinder(d=70, h=85, $fn=60);
    translate([0,0,5]) cylinder(d=62, h=90, $fn=60);
    translate([0,0,-5]) cylinder(d=10, h=10, $fn=60);
    for(A=[0:90:360]){
      rotate([0,0,45+A]) translate([22,0,-4]) cylinder(d=4, h=12, $fn=60);
    }
  }
}

module full_assembly(){
  difference(){
    //wheel(main_dia=200);
    wheel_assembly();
    difference(){
      difference(){
      union(){
        for(Z=[0,1]) rotate([0,0,45*Z]) translate([0,0,24]) hex_array();
        hull() rotate([0,0,22.5]){
          for(Z=[-1,1]) translate([0,0,30]) rotate([45,0,22.5*Z])
              translate([0,0,100]) cylinder(d=8, h=10, $fn=60);
          for(Z=[-1,1]) translate([0,0,50]) rotate([100,0,5.625*Z])
              cylinder(d=8, h=150, $fn=60);
        }
      }

      hull() rotate([0,0,22.5]){
        for(Z=[-1,1]) rotate([0,0,10*Z]) translate([0,-60,0])
            translate([0,0,60]) rotate([0,-10*Z,0]) cylinder(d=8, h=20, $fn=60);
        for(Z=[-1,1]) translate([10*Z,0,-15]) rotate([60,0,-5*Z]) cylinder(d=8, h=150, $fn=60);
      }
    }
        /*%hull() rotate([0,0,22.5]){
          for(Z=[-1,1]) translate([0,0,30]) rotate([45,0,22.5*Z])
              translate([0,0,100]) cylinder(d=8, h=10, $fn=60);
          for(Z=[-1,1]) translate([0,0,90]) rotate([120,0,5.625*Z])
              cylinder(d=8, h=150, $fn=60);
        }*/
      wheel(main_dia=190);
    }

  }
  %cylinder(d=125, h=100, $fn=60);
}

module wheel_assembly(){
  intersection(){
    intersection(){
      cylinder(d=main_dia, h=80, $fn=60, center=true);
      union(){
        for(A=[0:(360/8):360]) rotate([0,0,A]) translate([0,(main_dia/2)-5,0])
            rotate([90,0,0]) cylinder(d=50, h=5, $fn=6, center=true);
        for(A=[0:(360/8):360]) rotate([0,0,A]) translate([0,(main_dia/2),0])
            rotate([90,0,0]) cylinder(d1=43, d2=50, h=5, $fn=6, center=true);
        //cylinder(d=main_dia, h=20, $fn=60, center=true);

        translate([0,0,8.5]) cylinder(d1=main_dia, d2=main_dia-5, h=2.5, $fn=60, center=true);
        cylinder(d=main_dia, h=14.5, $fn=60, center=true);
        translate([0,0,-8.5]) cylinder(d1=main_dia-5, d2=main_dia, h=2.5, $fn=60, center=true);
      }
    }
    for(A=[0:(360/104):360]) // needs to me multiplue of 8
      rotate([0,0,A]) translate([0,(main_dia/2)-3,0]) rotate([90,0,0]) cube([4,60,10], center=true);
  }
  difference(){
    wheel();

    translate([0,0,65]) cylinder(d1=75, d2=125, h=20, $fn=8, center=true);
    /*translate([0,0,-55]) cylinder(d1=100, d2=75, h=30, $fn=8, center=true);*/
    /*translate([0,0,-30]) cylinder(d=125, h=130, $fn=60, center=true);*/

    middle_band(dia=201);
    difference(){
      for(A=[0:(360/8):360]) rotate([0,0,A]) translate([0,(main_dia/2)-3,0]) rotate([90,0,0]) cylinder(d1=60, d2=50, h=10, $fn=6, center=true);
      cylinder(d=main_dia-10, h=80, $fn=60, center=true); //fill in hex cutouts
    }

  }
}
module middle_band(dia=200, height=30, depth=10, aheight=5){
  difference(){
    cylinder(d=dia, h=height, $fn=60, center=true);
    union(){
      offset=(height/2)-(aheight/2)-0.001;
      translate([0,0,-offset]) cylinder(d1=dia, d2=dia-depth, h=aheight, $fn=60, center=true);
      translate([0,0,offset]) cylinder(d2=dia, d1=dia-depth, h=aheight, $fn=60, center=true);
      cylinder(d=dia-depth, h=height, $fn=60, center=true);
    }
  }
}


module wheel(main_dia=200){
  //hull(){
    cylinder(d=main_dia, h=60, $fn=60, center=true);
    for(Z=[-1,1]) translate([0,0,32*Z]) rotate_extrude(convexity=10, $fn=60)
        translate([(main_dia/4)+2, 0]) resize(newsize=[95,80,0], auto=true) circle(main_dia/5, $fn=60);
    //for(Z=[-1,1]) translate([0,0,62*Z]) rotate_extrude(convexity=10, $fn=60) translate([main_dia/3, 0]) circle(4, $fn=60);

    //for(Z=[-1,1]) translate([0,0,30*Z]) rotate_extrude(convexity=10, $fn=60) translate([(main_dia/2)-8, 0]) circle(8, $fn=60);
  //}
}

module wheel1(main_dia=200){
  union(){
    //cylinder(d=main_dia, h=60, $fn=60, center=true);
    for(Z=[-1,1]) translate([0,0,27.5*Z]) rotate_extrude(convexity=10, $fn=60) translate([main_dia/3.333, 0]) circle(main_dia/5, $fn=60);
  }
}

module wheel2(){

  difference(){
    union(){
      cylinder(d=main_dia, h=80, $fn=60, center=true);
      for(Z=[-1,1]) translate([0,0,40*Z]) rotate_extrude(convexity=10, $fn=60) translate([80, 0]) circle(20, $fn=60);
    }

   translate([0,0,45]) cylinder(d1=115, d2=150, h=30, $fn=8, center=true);
   translate([0,0,-45]) cylinder(d1=150, d2=115, h=30, $fn=8, center=true);
  }
}

module sk3_6375(simple=true){
  outer_dia=59;
  height=82.3;
  fixed_height=8;
  fixed_dia=54;
  spin_dia=40;
  cylinder(d=8, h=26.5, $fn=60);
  difference(){
    union(){
      if(simple){
        translate([0,0,-height]) cylinder(d=outer_dia, h=height, $fn=60);
      }
      else{
        translate([0,0,-fixed_height]) cylinder(d1=outer_dia, d2=fixed_dia, h=fixed_height, $fn=60);
        translate([0,0,-(height-fixed_height)]) cylinder(d=outer_dia, h=height-(fixed_height*2)-0.5, $fn=60);
        translate([0,0,-height]) cylinder(d1=spin_dia, d2=outer_dia, h=fixed_height, $fn=60);
      }
    }
    for(A=[0:90:360]){
      rotate([0,0,45+A]) translate([22,0,-4]) cylinder(d=4, h=6, $fn=60);
      rotate([0,0,45+A]) translate([10,0,-height-1]) cylinder(d=3, h=6, $fn=60);
    }
  }
  translate([0,0,-height-2]) cylinder(d=16.5, h=2, $fn=60);
  translate([0,0,-height-4]) cylinder(d=8, h=2, $fn=60);

}
