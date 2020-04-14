
$fn=120;
//pipe_dia=33.401+0.5; // 1" pvc
pipe_dia=49; // 1.5" abs

//base();
//keyholder();
full_stack();

module full_stack(){
    height=2133.6;
    
    translate([0,0,1300]) keyholder();
    for(Z=[300,700,1100,1700,2000])
    translate([0,0,80+Z]){
        top_supportV2();
        //%translate([0,-150,-300]) cube([100,100,390]);
    }
    for(Z=[80,960,2000])
    translate([0,0,Z]) bottom_support_unit();
    base();
    translate([0,0,height/2]) pipes(height=height);
}

module base(mount_hole=5){
    translate([0,195,5]) for(R=[-1,1]) 
        rotate([0,0,12*R]) 
        translate([0,-210,-4]) support();
    
    top_support(tongue_length=0, mount_hole=5, 
                    linked="none", width=100, angle=30);
    difference(){
        for(X=[-1,1]){
            translate([0,245,-2.5]) 
                rotate([0,0,15*X]) translate([0,-250,0]) 
                hull(){
                    sphere(d=15);
                    translate([0,-100,0]) sphere(d=15);
                }
        }
        translate([0,195,-5]) for(R=[-1,1]){
            rotate([0,0,12*R]) translate([0,-250,0])
            translate([0,40,2.5]) 
                cylinder(d=pipe_dia, h=16, center=true);
        }
    }
}

module keyholder(mount_hole=5){
    translate([0,-70,40]) rotate([70,0,0]){
        %cube([120, 75, 30], center=true); // wallet
    }
    translate([0,-70,-5]) wallet_support();
    difference(){
        top_support(tongue_length=0, mount_hole=5, 
                    linked="none", width=100, angle=25);
        translate([0,-72,40]) rotate([68,0,0]) translate([0,-3,0.5]) rounded_cube(dia=[120,75,30], d=4, f=20);
        
    }
    for(X=[-1,1]){
        translate([53*X,-100,-5]) 
            rotate([0,85*X,12.5*X]) translate([0,0,20]) 
            rounded_cylinder(d=10, $fn=30);
        translate([45*X,-65,-5]) 
            rotate([0,85*X,12.5*X]) translate([0,0,20]) 
            rounded_cylinder(d=10, $fn=30);
    }
}

module rounded_cylinder(d=10, $fn=30){
    hull(){
        cylinder(d=d, h=1);
        translate([0,0,15]) sphere(d=d, $fn=$fn);
    }
}

module wallet_support(height=75, width=120, thickness=30, d=4, f=20){
    hull()
    for(X=[-1,1], Y=[0,1], Z=[0,1]){
        translate([width/2*X, thickness*Y, 0]) sphere(d=d,$fn=f);
        translate([width/2*X, thickness, height]) sphere(d=d,$fn=f);
    }
}

module rounded_cube(dia=[100,10,100], d=4, f=20){
    hull()
    for(X=[-1,1], Y=[-1,1], Z=[-1,1]){
        translate([dia[0]/2*X, dia[1]/2*Y, dia[2]/2*Z]) sphere(d=d,$fn=f);
    }
}

module bottom_support_unit(mount_hole=5, height=20, offset=20){
    rotate([0,180,0])
    translate([0,195,10]) for(R=[-1,1]) 
    rotate([0,0,12*R]) translate([0,-210,0]){
        difference(){
            union(){
            cylinder(d=pipe_dia+10, h=height);
            hull(){
              translate([-0*R,0,height/2]) rotate([0,0,-12*R]){
                for(X=[-1,1], Z=[-1,1]){
                translate([((pipe_dia+5)/2)*X,0,((height/2)-2)*Z])
                  rotate([90,0,0]) cylinder(d=4, h=1);
                translate([0,(pipe_dia/2)+3+offset,((height/2)-2)*Z])
                  rotate([90,0,0]) cylinder(d=4, h=1);
                 translate([-25*R,(pipe_dia/2)+3+offset,0])
                    rotate([90,0,0]) cylinder(d=height, h=1);
                  }
                 }
                }
                
            }
            translate([0,0,-1]) 
                cylinder(d=pipe_dia, h=height+2);
            translate([0,0,height/2]) rotate([0,90,0]) 
            cylinder(d=mount_hole, h=pipe_dia*2, center=true);
        }
    }
    difference(){
        translate([0,(pipe_dia/2)-7.5+offset,-(height/2)-10])
            hull() for(Z=[-1,1])
                translate([0,0,(height*Z/2)-2*Z])
            rotate([0,90,0])
            cylinder(d=4, h=90, center=true);
        
        translate([0,offset,-height]) rotate([90,0,0]) 
            cylinder(d=mount_hole, h=70, center=true);
    }
}

module support(mount_hole=5){
    difference(){
        hull(){
            cylinder(d=pipe_dia+10, h=40);
            for(X=[-1,1]) translate([15*X,-pipe_dia,0]) 
                cylinder(d=10, h=5);
        }
        translate([0,0,-1]) cylinder(d=pipe_dia, h=42);
        translate([0,0,20]) rotate([0,90,0]) 
            cylinder(d=mount_hole, h=70, center=true);
    }
}
module top_supportV2(tongue_length1=120, tongue_length2=50, mount_hole=5){
    top_support(tongue_length=tongue_length1, mount_hole=5, linked="none");
    translate([0,195,-5]) for(R=[-1,1]) 
    rotate([0,0,12*R]) translate([0,-205-tongue_length1,0]) rotate([-90,0,0]) shoe_support(tongue_length2, linked="none");
}

module top_support(tongue_length=120, mount_hole=5, linked=false, angle=11, width=10){
    translate([0,195,-5]) for(R=[-1,1]) 
    rotate([0,0,12*R]) translate([0,-210,0]){
        difference(){
            union(){
                if(tongue_length > 0){
                    shoe_support(tongue_length, linked=linked);
                }
                translate([0,0,2.5]) 
                    cylinder(d=pipe_dia+10, h=15, center=true);
                
            }
            translate([0,0,2.5]) 
                cylinder(d=pipe_dia, h=16, center=true);
            translate([0,40,2.5]) rotate([90,0,0]) 
                cylinder(d=mount_hole, h=pipe_dia+11, center=true);
       }
    }
    difference(){
        translate([0,245,-2.5])
        rotate([0,0,-(angle/2)-90])
        rotate_extrude(angle=angle, convexity = 10)
        translate([250, 0, 0])
        hull(){
            circle(d=15);
            translate([width,0,0]) circle(d=15);
        }
        translate([0,195,-5]) for(R=[-1,1]){
            rotate([0,0,12*R]) translate([0,-250,0])
            translate([0,40,2.5]) 
                cylinder(d=pipe_dia, h=16, center=true);
        }
    }
}
module pipes(height=500){
    translate([0,195,-5]) for(R=[-1,1])
        %rotate([0,0,12*R]) translate([0,-250,0])
            translate([0,40,2.5]) 
                cylinder(d=pipe_dia, h=height, center=true);
 }
module shoe_support(tongue_length=100, linked=false){
    difference(){
        intersection(){
            union(){
                translate([0,-tongue_length/2,-40]) 
                    rotate([90,0,0]) 
                    cylinder(d=100, h=tongue_length, center=true, $fn=240);
                if(linked=="none"){
                    
                }
                else if(linked){
                    hull(){
                    translate([0,-tongue_length+5,-40]) 
                        rotate([90,0,0])
                        rotate_extrude(convexity = 10)
                        translate([50, 0, 0])
                        circle(d=10);
                    
                    translate([0,0,-40]) 
                        rotate([90,0,0])
                        rotate_extrude(convexity = 10)
                        translate([50, 0, 0])
                        circle(d=10);
                    }
                }
                else{
                    translate([0,-tongue_length+5,-40]) 
                        rotate([90,0,0])
                        rotate_extrude(convexity = 10)
                        translate([50, 0, 0])
                        circle(d=10);
                }
            }
            translate([-25,-tongue_length,-5]) 
                cube([50, tongue_length, 20]);
        }
        for(X=[-1,1]) 
            translate([25*X,-tongue_length/2,-10])
            rotate([0,-45*X,0])
            cube([20,tongue_length+5,10], center=true);
        translate([0,-tongue_length,-10]) 
            rotate([45,0,0]) cube([55,10,20], center=true);
        for(X=[-1,1]) translate([25*X,-tongue_length-5,0]) 
            rotate([0,0,-45*X]) cube([10,20,30], center=true);
    }
}