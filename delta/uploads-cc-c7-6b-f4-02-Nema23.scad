

// Dimensions are given in inches, and multiplied by 25.4 to convert mm
module Nema23(length=2.08)
{
	inch = 25.4; // inch to mm
	translate([0,0,length]*inch){
		difference(){
			hull() for(x=[-1,1],y=[-1,1])
				translate([x*1.8,y*1.8,-length]*.5*inch)
				cylinder(d=.4*inch,h=length*inch,center=true,$fn=36); // Main Motor Body
			for(x=[-1,1],y=[-1,1]){
				translate([x*1.85,y*1.85,-length+1]*.5*inch)
					cylinder(d=.197*inch,h=length*inch,center=true,$fn=36); // Screw Holes
				translate([x*1.87,y*1.87,-length-.2*2]*.5*inch)
					cube([.37,.37,length]*inch,center=true); // Motor Body inset parts
			}
		}
		cylinder(d=1.5*inch,h=.063*inch,$fn=90); // Motor Circle Thing
		cylinder(d=.25*inch,h=1*inch,$fn=36); // Rod
		translate([1.10,-.41,-length]*inch) cube([.2,.82,.45]*inch); // Cable Connector
	}
}

Nema23();

