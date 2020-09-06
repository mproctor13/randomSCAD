bigC=11.6;
smallC=6.7;
boxH=23.6;
boxD = 4;
offsetH = 1.3;
screw = 2;
smallScrew = 1.74;
servoGear = 3.82;
zipTie = 5;
armW=15;
armD=4;
TarmL=25;
ParmL=40;
armHT=35;
armHS=25;

$fs=.01;

//translate([35,0,15]) rotate([90,180,-90]) tilt();

//translate([0,15,26]) rotate([0,90,-90]) pan();

//servoBlank();
//pi_camera();
//rotate([0,0,0]) pi_tilt();


module pi_tilt(){
  tilt();
  translate([1,-12.5,10]) rotate([0,0,-90]) pi_camera_mount();
}

module pi_camera_mount(){
  difference(){
    union(){
      translate([0,0,2.5]) cube([30,2,25], center=true);
      translate([-10.35,-1.51,4]) cube([2,4.5,10], center=true);
      translate([10.35,-1.51,4]) cube([2,4.5,10], center=true);
    }
    for(X=[-10.35,10.35], Z=[10.5,-2.2]){
      translate([X,2,Z]) rotate([90,0,0]) cylinder(d=2, h=5);
    }
  }
}

module pi_camera(){
  difference(){
    color("green") cube([25,1.5,24], center=true);
    for(X=[-10.35,10.35], Z=[10.5,-2.2]){
      translate([X,1,Z]) rotate([90,0,0]) cylinder(d=1.65, h=2);
    }
  }
  translate([0,1.35,-9]) color("white") cube([22,4.1,5.45], center=true);
}

module tilt(){
	union(){
		difference(){
			cube([armW,armD,armHS]);
			translate([armW/2,armD+.1,armHS-10]) rotate([90,0,0]) cylinder(h=2.5,d=servoGear);
			translate([armW/2,armD,armHS-10]) rotate([90,0,0]) cylinder(h=5,d=smallScrew);
		}
		
		difference(){
			translate([0,-TarmL,0]) cube([armW,TarmL,armD]);
			translate([armW/2,-TarmL+13,0]) cylinder(h=armD+1,d=zipTie);
			translate([armW/2,-TarmL+50,0]) cylinder(h=armD+1,d=zipTie);
		}

		union(){
			translate([0,-TarmL-armD,0]) cube([armW,armD,armHS]);
			translate([armW/2,-TarmL+(-armD),armHS-10]) rotate([90,0,0]) cylinder(h=2, d1=7,d2=4.5);
			translate([armW/2,-TarmL+(-armD),armHS-10]) rotate([90,0,0]) cylinder(h=10,d=4.5);
		}
	}
}

module pan(){
	union(){
		difference(){
			cube([armHT,armW,boxD*1.8]);
			translate([5,1.5,0]) servoBlank();
		}
		difference(){
			translate([31,0,boxD*1.8]) cube([armD,armW,ParmL]);
			translate([32.1,7.5,(ParmL/2)+8]) rotate([0,90,0]) cylinder(h=3,d=3.82);
			translate([30,7.5,(ParmL/2)+8]) rotate([0,90,0]) cylinder(h=5,d=smallScrew);
		}

		difference(){
			translate([0,0,(boxD*1.8)+ParmL])cube([armHT,armW,boxD*1.8]);
			translate([(bigC/2)+5,(bigC/2) +1.5,(boxD*1.8)+ParmL]) rotate([0,0,0]) cylinder(h=boxD*1.8,d=5);
		}
		
	}
}


module servoBlank(){
	union(){
		cube([boxH,bigC,boxD]);
		translate([bigC/2,bigC/2,boxD]) cylinder(h=boxD,d=bigC);
		translate([bigC+.3,bigC/2,boxD]) cylinder(h=boxD,d=smallC);
		translate([(bigC/2)-.3,(bigC/2)-(smallC/2),0]) cube([smallC,smallC,boxD*2]);
	}
	
	translate([-(offsetH+(screw/2)),bigC/2,0]) cylinder(h=boxD*2.5,d=screw);

	translate([boxH+(offsetH+(screw/2)),bigC/2,0]) cylinder(h=boxD*2.5,d=screw);
}

