Size = 210;

// Middle Cube Factor
MCF = .9;

// Inner Cube Factor
ICF = .8;

// Bevel Factor
BF = .03;

// Sphere Factor
SF = .8;

my_fn=30;
$fn=my_fn;


module model(){
//%translate([0,0,90])
//cube([210,210,210], center=true);
translate([0,0,80])
difference(){
  companion_cube();
  translate([0,0,Size/2]) 
    cube([Size+1,Size+1,Size+1], center=true);
  inner_size = Size*ICF-Size*BF-3;
  %translate([0,0,3])
    cube([inner_size-3,inner_size-3,inner_size-3], center=true);
//  %translate([0,0,3])
//    cube([inner_size,inner_size,inner_size], center=true);
}
translate([0,0,80])
    rotate([90,90,0])
      %translate([0,0,Size*ICF/2]) platform();
translate([0,0,65])
  cylinder(d=25, h=100);
}
//middle();
//four_glasses();

//platform();
//linear_extrude(10, scale=1.5) 
//heart(radius=10, center=true);
//four_holder();
//translate([0,0,150]) four_holder_lid();
glass_color_code();

module four_holder_lid(){
  $fn=120;
  difference(){
    for(X=[-1,1], Y=[-1,1]) 
      translate([35*X,35*Y,0]) 
        cylinder(d=85,h=8);
    for(X=[-1,1], Y=[-1,1]) 
      translate([35*X,35*Y,-0.2]) 
        cylinder(d=80.5,h=6);
  }
}

module four_holder(){
  $fn=120;
  difference(){
    for(X=[-1,1], Y=[-1,1]) 
      translate([35*X,35*Y,0]) 
        cylinder(d=80,h=110);
    four_glasses(offset=35);
  }
}

module glass_color_code(thickness=7.5){
  $fn=120;
  difference(){
    union(){
      cylinder(d=48,h=thickness);
      rotate_extrude() translate([24,4,0]) circle(d=thickness);
        
      cylinder(d=24*2+thickness,h=thickness/2);
    }
    translate([0,0,thickness-5+0.2]) cylinder(d=47,h=5);
  }
}

module companion_cube(type="middle"){
  difference(){
    union(){
        // Outer Cube
        difference(){
            union(){
                for(x = [-1,1]){
                    for(y=[-1,1]){
                        for(z = [-1,1]){
                            translate([x * Size/3,y * Size/3,z * Size/3])
                            cube([Size/3,Size/3,Size/3],center=true);
                        }
                    }
                }
                
            }
            // Bevels the inside edges
            for(plane = [[90,0,0],[0,90,0],[0,0,90]]){
                for(x = [-1,1]){
                    rotate(plane)
                    translate([x*Size/2, 0,0])
                    for(z = [0,90]){
                        rotate([0,z,90])
                        for(y = [-1,1]){
                            translate([y*Size/6,0,0])
                            rotate([0,0,45])
                            cube([Size*BF,Size*BF,Size*2], center=true);
                        }
                    }
                }
                
                // Bevels the outside edges
                rotate(plane)
                for(y =[-1,1]){
                    for(z = [-1,1]){
                        translate([z*Size/2,y*Size/2,0])
                        rotate([0,0,45])
                        cube([Size*BF,Size*BF,Size*2],center=true);
                    }
                }
            }
        }
    
        // Middle Cube
      if(type == "middle"){
        difference(){
            // Sets the size of the inside butt outs
            for(plane = [[90,0,0],[0,90,0],[0,0,90]]){
                rotate(plane)
                cube([Size*MCF,Size*MCF,Size*MCF/4],center=true);
            }
        
            // Bevels the inside edges
            for(plane = [[90,0,0],[0,90,0],[0,0,90]]){
                for(x = [-1,1]){
                    rotate(plane)
                    translate([x*Size*MCF/2, 0,0])
                    for(z = [0,90]){
                        rotate([0,z,90])
                        for(y = [-1,1]){
                            translate([y*Size*MCF/8,0,0])
                            rotate([0,0,45])
                            cube([Size*MCF*BF,Size*MCF*BF,Size*2], center=true);
                        }
                    }
                }
                
                // Bevels the outside edges
                rotate(plane)
                for(y =[-1,1]){
                    for(z = [-1,1]){
                        translate([z*Size*MCF/2,y*Size*MCF/2,0])
                        rotate([0,0,45])
                        cube([Size*MCF*BF,Size*MCF*BF,Size*2],center=true);
                    }
                }
            }
        }
      }
    }

    for(plane = [[90,0,0],[0,90,0],[0,0,90]]){
        for(x = [-1,1]){
            // creates the rounded insets
            rotate(plane)
            translate([x*Size*SF/4*3, 0,0])
            sphere(d = Size*SF);
        }
    }
}
  difference(){
    union(){
  // Inner Cube
  difference(){
    cube([Size*ICF,Size*ICF,Size*ICF],center=true);
    for(plane = [[90,0,0],[0,90,0],[0,0,90]]){
        rotate(plane)
        cube([Size, Size, Size*BF/3*2],center=true);
    }
  }

  // Inner Inner Cube
  color("grey")
  cube([Size*ICF-Size*BF,Size*ICF-Size*BF,Size*ICF-Size*BF],center=true);
    }
  }
  for(plane=[[0,0,-90], // top
             [90,90,0], // front 
             [90,90,90], // right
             [90,90,-90], // left
             [90,90,180], // back
             [0,180,30] // bottom
            ])
    rotate(plane)
      translate([0,0,Size*ICF/2]) platform();
}

module middle(){ // Middle Cube
  difference(){
    union(){
        difference(){
          cube([Size*MCF,Size*MCF,Size*MCF/4],center=true);
          cube([Size*ICF-Size*BF,Size*ICF-Size*BF,Size*MCF/4+1],center=true);
          // Bevels the inside edges
          for(plane = [[90,0,0],[0,90,0],[0,0,90]]){
                for(x = [-1,1]){
                    rotate(plane)
                    translate([x*Size*MCF/2, 0,0])
                    for(z = [0,90]){
                        rotate([0,z,90])
                        for(y = [-1,1]){
                            translate([y*Size*MCF/8,0,0])
                            rotate([0,0,45])
                            cube([Size*MCF*BF,Size*MCF*BF,Size*2], center=true);
                        }
                    }
                }
                
                // Bevels the outside edges
                rotate(plane)
                for(y =[-1,1]){
                    for(z = [-1,1]){
                        translate([z*Size*MCF/2,y*Size*MCF/2,0])
                        rotate([0,0,45])
                        cube([Size*MCF*BF,Size*MCF*BF,Size*2],center=true);
                    }
                }
            }
        }
    }

    for(R=[0,90,180,270]){
     // creates the rounded insets
       rotate([0,0,R])
       translate([Size*SF/4*3, 0,0])
         cylinder(d = Size*SF, h=Size*MCF/4+1, center=true);
    }
  }
}

module platform(height=5){ // Heart Platform
  hull(){
//  translate([0,0,Size*MCF/2])
    rotate_extrude($fn=my_fn*2)
      translate([Size*ICF/4-Size*ICF*BF/2,0,0])
        circle(d = Size*ICF*BF, $fn=my_fn*2);
    translate([0,0,-height])
      cylinder(d=Size*ICF/2, h=0.1, $fn=my_fn*2);
  }
  translate([0,0,-height/2])
  color("red") linear_extrude(height*2) heart(radius=Size*ICF/12, center=true);
}

module heart_sub_component(radius) {
    rotated_angle = 45;
    diameter = radius * 2;
    $fn = 48;

    translate([-radius * cos(rotated_angle), 0, 0]) 
        rotate(-rotated_angle) union() {
            circle(radius);
            translate([0, -radius, 0]) 
                square(diameter);
        }
}

module heart(radius, center = false) {
    offsetX = center ? 0 : radius + radius * cos(45);
    offsetY = center ? 1.5 * radius * sin(45) - 0.5 * radius : 3 * radius * sin(45);

    translate([offsetX, offsetY, 0]) union() {
        heart_sub_component(radius);
        mirror([1, 0, 0]) heart_sub_component(radius);
    }

}

module four_glasses(offset=40){
  for(X=[-1,1], Y=[-1,1])
    translate([offset*X,offset*Y,0])
      glass_cutout();
}

module glass_cutout(){
  translate([0,0,5]){
    cylinder(d=47, h=7);
    translate([0,0,7]) cylinder(d1=47, d2=69, h=68-7);
    translate([0,0,68]) cylinder(d=69, h=50);
  }
}