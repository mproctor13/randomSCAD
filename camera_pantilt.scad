use <MCAD/involute_gears.scad>
internal_width=150;
mount_length=110;
use <NewBearing/bearing_test.scad>;
//ball_size=6;
race_width=3;
race_height=8;
ball_dia=3.5;
main_diameter=10;
twist=200;
pressure_angle=20;
CenterHole_dia = 5.1;
CenterHole_Flat_dia = 3.1;
$fn=60;

//translate([0,0,1.5]) mag_mount();
//as_inner_test();
//as_outer_test();
//test_foot();

//sigma_lens();

//difference(){
//as5600_mount();0
//    cube(30);
//}

//zoom_ring(geared=true);
zoom_ring(zoom_ring_dia=zoom_ring_dia, geared=true);
//drive_wheel();
//mirror([0,1,0]) 

//main_mount([-25,50], height=18);
//translate([0,0,0]) rotate([0,0,180]) main_mount([60,-5], height=18);
//mount_ring(full=false);
//mount_ring(ring_dia=91, height=25, cutout=21, full=false);//far
//mount_ring(ring_dia=93, height=10, cutout=44, full=false);//close

//rotate([0,0,90]) main_body();
mtest();
translate([-50,0,-25]) drive_wheel();
//%mtest(top=true, bottom=false);

module mtest(top=false, bottom=true){
  race_height=10;
  pi=3.141592653589793;
  circular_pitch = 88*pi/100;
    echo("My Pitch",circular_pitch);
  mmount_internal(top=top, bottom=bottom);
  
  if(top){
    translate([0,63,-20]) rotate([-90,0,0]){
      outside_race(diameter=75/2, 
                    holes=0, offset=3, 
                    ball_dia=5, 
                    race_width=5, 
                    race_height=race_height);
      translate([0,0,-3])
        gear(number_of_teeth=100,
			circular_pitch=circular_pitch,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = race_height,
			rim_thickness = race_height,
			hub_thickness = race_height,
			hub_diameter=race_height,
            bore_diameter=82);
    }
  }
  if(bottom){ 
    translate([0,-63,-20]) rotate([-90,0,0]){
      mirror([0,0,1]) outside_race(diameter=75/2, 
                    holes=0, offset=3, 
                    ball_dia=5, 
                    race_width=5, 
                    race_height=race_height);
      translate([0,0,-7])
        gear(number_of_teeth=100,
			circular_pitch=circular_pitch,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = race_height,
			rim_thickness = race_height,
			hub_thickness = race_height,
			hub_diameter=race_height,
            bore_diameter=82);
      }
  }
  if(top){ 
    difference(){
    translate([0,42.5,-20]) rotate([90,0,0])
      difference(){
        cylinder(d=85,h=40, center=true);
        cylinder(d=80,h=41, center=true);
      }
      mmount_internal(top=top,bottom=bottom,solid=true);
      translate([0,52.5,-25])
        for(R=[0,45,90,135]) rotate([0,R,0])
          hull() for(X=[-1,1]) 
            translate([5*X,0,0]) 
              cylinder(d=15,h=150, center=true);
    }
  }
  if(bottom){ 
    difference(){
    translate([0,-42.5,-20]) rotate([90,0,0])
      difference(){
        cylinder(d=85,h=40, center=true);
        cylinder(d=80,h=41, center=true);
      }
      mmount_internal(top=top,bottom=bottom,solid=true);
      translate([0,-52.5,-25])
        for(R=[0,45,90,135]) rotate([0,R,0])
          hull() for(X=[-1,1]) 
            translate([5*X,0,0]) 
              cylinder(d=15,h=150, center=true);
    }
  }
}

module mmount_internal(top=false, bottom=true, 
                        solid=false){
  translate([0,0,21]){
    if(top){
      rotate([0,0,180]) main_mount([60,-5], height=18, solid=solid);
    }
    if(bottom){
      main_mount([-25,50], height=18, solid=solid);
    }
  }
  difference(){
    union(){
      translate([0,0,10.5]) cylinder(d=95,h=2);
      translate([45,-1,11.5]) cube([22,46,2],center=true);
    }
    if(bottom){
      translate([0,50,12]) cube([120,100,4], center=true);
    }
    if(top){
      translate([0,-50,12]) cube([120,100,4], center=true);
    }
    if(!solid){
      translate([0,0,5]) cylinder(d=86,h=10);
    }
  }
  translate([0,0,-23]) difference(){
    union(){
      translate([0,0,10.5]) cylinder(d=95,h=2);
      translate([45,-1,11.5]) cube([22,46,2],center=true);
    }
    if(bottom){
      translate([0,50,12]) cube([120,100,4], center=true);
    }
    if(top){
      translate([0,-50,12]) cube([120,100,4], center=true);
    }
    if(!solid){
      translate([0,0,5]) cylinder(d=93,h=10);
    }
  }
  if(bottom){
    mount_ring(ring_dia=93, height=25, cutout=44, full=false, solid=solid);//close
  }
  if(top){
    mirror([0,1,0])
    mount_ring(ring_dia=93, height=25, cutout=44, full=false, solid=solid);//close
  }
  translate([0,0,-11.5]) difference(){
    cylinder(d=115,h=2,center=true);
    cylinder(d=93,h=2.5,center=true);
    if(bottom){
      translate([0,50,0]) cube([120,100,4], center=true);
    }
    if(top){
      translate([0,-50,0]) cube([120,100,4], center=true);
    }
  }
  translate([0,0,-27.5]){
  if(bottom){
    zoom_ring(zoom_ring_dia=110, zoom_ring_height=30, geared=false, solid=solid);
  }
  if(top){
    mirror([0,1,0])
    zoom_ring(zoom_ring_dia=110, zoom_ring_height=30, geared=false, solid=solid);
  }
  }
  
  translate([0,0,-41.5]) difference(){
    cylinder(d=115,h=2,center=true);
    cylinder(d=91,h=2.5,center=true);
    if(bottom){
      translate([0,50,0]) cube([120,100,4], center=true);
    }
    if(top){
      translate([0,-50,0]) cube([120,100,4], center=true);
    }
    translate([48,0,0]) cube([10,21,4], center=true);
  }
  translate([0,0,-55]){
  if(bottom){
    mount_ring(ring_dia=91, height=25, cutout=21, full=false, solid=solid);//far
  }
  if(top){
    mirror([0,1,0])
    mount_ring(ring_dia=91, height=25, cutout=21, full=false, solid=solid);//far
  }
  }
    
}

module main_body(){
  angle=120;
  main_dia=200;
  main_length=230;
  difference(){
    body_shell(main_dia,main_length);
    translate([0,0,(main_length+main_dia/2)/2-1]) cube([120,200,main_length+main_dia/2+1],center=true);
  }
  center_section(main_dia,main_length,angle);
}

module center_section(main_dia,main_length,angle=0){
  translate([0,0,main_length/2+main_dia/2]) rotate([angle,0,0]) translate([0,0,-main_length/2-main_dia/2])
  union(){
    %intersection(){
      body_shell(main_dia, main_length);
      translate([0,0,(main_length+main_dia/2)/2-1]) cube([120,200,main_length+main_dia/2+1],center=true);
    }
    
    sigma_lens();
  }
}

module body_shell(main_dia,main_length){
    hull(){
      translate([0,0,main_length]) sphere(d=main_dia);
      cylinder(d=main_dia, h=1);
    }
}

module main_mount(angles=[-40,35], height=8, solid=false){
  difference(){
    zoom_ring(zoom_ring_dia=86, zoom_ring_height=height, geared=false, full=false, solid=solid);
    if(!solid){
      translate([0,0,4-height/2]) for(R=angles)
        rotate([0,90,90+R]) 
          cylinder(d=5.2,h=100,$fn=60,center=true);
    }
  }
}

module drive_wheel(drive_dia=20, zoom_ring_height=20){
  teeth=20;
  pi=3.141592653589793;
  circular_pitch = drive_dia*pi/teeth;
  circular_pitch = 88*pi/100;
  
  difference(){
    union(){
      gear(number_of_teeth=teeth,
			circular_pitch=circular_pitch,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = zoom_ring_height/2,
			rim_thickness = zoom_ring_height/2,
			hub_thickness = zoom_ring_height/2,
			hub_diameter=zoom_ring_height/2,
			twist=twist/teeth);
      mirror([0,0,1])
        gear (number_of_teeth=teeth,
			circular_pitch=circular_pitch,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = zoom_ring_height/2,
			rim_thickness = zoom_ring_height/2,
			hub_thickness = zoom_ring_height/2,
			hub_diameter=zoom_ring_height/2,
			twist=twist/teeth);
    }
    linear_extrude(zoom_ring_height, center=true)
    intersection(){
      circle(d=CenterHole_dia,$fn=30);
      square([CenterHole_dia,CenterHole_Flat_dia],center=true);
    }
    for(Z=[-1,1]) 
      translate([0,0,(zoom_ring_height/2-1.5)*Z])
        cylinder(d=CenterHole_dia, h=3, center=true, $fn=60);
  }
}

module zoom_ring(zoom_ring_dia=88, zoom_ring_height=20, full=false, geared=false, solid=false){
  if( full ){
    zoom_ring_internal(zoom_ring_dia, zoom_ring_height, geared, solid=solid);
  }
  else{
    difference(){
      zoom_ring_internal(zoom_ring_dia, zoom_ring_height, geared, solid=solid);
      translate([0,zoom_ring_dia/2,0])
      cube([zoom_ring_dia*2, zoom_ring_dia, zoom_ring_height*2], center=true);
    }
  }
}

module zoom_ring_internal(zoom_ring_dia, zoom_ring_height, geared=false, solid=false){
  teeth=120;
  pi=3.141592653589793;
  circular_pitch = (zoom_ring_dia+5)*pi/teeth;
  echo(str("circular_pitch=", circular_pitch));
  difference(){
    union(){
      if(geared){
		gear (number_of_teeth=teeth,
			circular_pitch=circular_pitch,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = zoom_ring_height/2,
			rim_thickness = zoom_ring_height/2,
			hub_thickness = zoom_ring_height/2,
			hub_diameter=zoom_ring_height/2,
			bore_diameter=5,
			twist=twist/teeth);
		mirror([0,0,1])
		gear (number_of_teeth=teeth,
			circular_pitch=circular_pitch,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = zoom_ring_height/2,
			rim_thickness = zoom_ring_height/2,
			hub_thickness = zoom_ring_height/2,
			hub_diameter=zoom_ring_height/2,
			bore_diameter=5,
			twist=twist/teeth);
      }
      else{
        cylinder(d=zoom_ring_dia+5, h=zoom_ring_height, center=true);
      }
      cube([zoom_ring_dia+16,5,zoom_ring_height], center=true);
    }
    if(!solid){
      cylinder(d=zoom_ring_dia, h=zoom_ring_height+1, center=true);
    }
    holes=[0];
    if(zoom_ring_height > 10){
      for(X=[-1,1], Z=[-(zoom_ring_height/4),(zoom_ring_height/4)]) 
        translate([(zoom_ring_dia/2+5)*X,0,Z])
          rotate([90,0,0]) cylinder(d=3, h=10, center=true);
    }
    else{
      for(X=[-1,1], Z=holes) 
        translate([(zoom_ring_dia/2+5)*X,0,0])
          rotate([90,0,0]) cylinder(d=3, h=10, center=true);
    }
  }
  
}

module as5600_mount(){
  translate([0,0,0]) %as5600_board();
//  translate([0,0,-2]) cylinder(d=22,h=1);
    as_inner_test();
    as_outer_test();
}

module mag_mount(type=1){
  difference(){
    mount_plug();
    if(type==1){
      translate([0,0,1.5]) hull(){
        rotate([0,90,0]) cylinder(d=3.2, h=10, $fn=120, center=true);
        translate([0,0,-4]) cube([10,3,0.1], center=true);
      }
    }
    else{
      cylinder(d=6.35, h=3.175, $fn=120);
    }
  }
}

module mount_plug(){
  cylinder(d=15-0.2, h=2, $fn=8);
  cylinder(d=11, h=4, $fn=60);
}

module test_foot(){
  difference(){
    cylinder(d=30, h=4, center=true, $fn=60);
    translate([0,0,1]) cylinder(d=26.2, h=4, center=true, $fn=12);
    translate([0,0,1]) cube([8,100,4], center=true);
  }
  for(X=[-1,1]) translate([6*X,0,-1.5]) cylinder(d=2,h=2, $fn=60);
}

module as_inner_test(){
  difference(){
    inside_race(diameter=main_diameter, 
                holes=0, offset=-1.5, 
                ball_dia=ball_dia,
                race_width=race_width+3, 
                race_height=race_height);  
    cylinder(d=15, h=4, $fn=8);
    cylinder(d=12, h=20, $fn=60);
  }
}

module as_outer_test(){
  intersection(){
    difference(){
      union(){
        outside_race(diameter=main_diameter, 
                        holes=0, offset=3, 
                        ball_dia=ball_dia, 
                        race_width=race_width, 
                        race_height=11);
//        translate([0,0,-1]) cylinder(d=25, h=1, center=true, $fn=12);
//        for(X=[-1,1]) translate([6*X,0,-1.5]) cylinder(d=2,h=2, $fn=60);
      }
      translate([0,0,-3]) rotate([0,90,90]) 
        cylinder(d=8, h=40, center=true, $fn=6);
    }
    cylinder(d=26, h=40, center=true, $fn=12);
  }
}

module as5600_board(){
  intersection(){
    difference(){
      cylinder(d=18,h=1);
      for(X=[-1,1]) translate([6*X,0,-1]) cylinder(d=2.2,h=3, $fn=60);
    }
    cube([15,16,4], center=true);
  }
}

module mount_ring(ring_dia=91, height=10, cutout=21, full=true, solid=false){
  if( full ){
    mount_ring_internal(ring_dia,height,cutout,solid=solid);
  }
  else{
    difference(){
      mount_ring_internal(ring_dia,height,cutout,solid=solid);
      translate([0,ring_dia/2,0])
      cube([ring_dia*2, ring_dia, height*2], center=true);
    }
  }
}

module mount_ring_internal(ring_dia=90, height=10, cutout=21, solid=solid){
  
  difference(){
    translate([ring_dia/4+10,0,0]) cube([ring_dia/2,cutout+5,height], center=true);
    if(!solid){
      translate([ring_dia/4+7.5,0,0]) 
        cube([ring_dia/2,cutout,height+1], center=true);
    }
    cylinder(d=ring_dia, h=height+1, center=true);
    translate([ring_dia/2+9,-13,-4]) rotate([90,0,90]) 
      linear_extrude(2) text(str(ring_dia),8);
  }
  difference(){
    zoom_ring_internal(ring_dia, height, solid=solid);
    translate([ring_dia/2+3,0,0])
      cube([ring_dia/2,cutout,height+1], center=true);
  }
  difference(){
    translate([ring_dia/2+12,0,0])
      cube([8,5,height], center=true);
    holes=[0];
    if(height > 10){
      for(X=[1], Z=[-(height/4),(height/4)]) 
        translate([(ring_dia/2+13),0,Z])
          rotate([90,0,0])
            cylinder(d=3, h=10, center=true, $fn=60);
    }
    else{
      for(X=[1], Z=holes) 
        translate([(ring_dia/2+13)*X,0,0])
          rotate([90,0,0]) 
            cylinder(d=3, h=10, center=true, $fn=60);
    }
  }
}

module sigma_lens(){
//  %cylinder(d=95,h=280);
  cylinder(d=85,h=85);
  translate([0,0,85]) cylinder(d=90,h=30);
  translate([0,0,115]) cylinder(d=95,h=45);
  translate([0,0,160]) cylinder(d=92,h=48);
  translate([0,0,208]) cylinder(d=85,h=20);
  translate([0,0,228]) cylinder(d=84,h=15);
  translate([0,0,243]) cylinder(d=73,h=17);
}

