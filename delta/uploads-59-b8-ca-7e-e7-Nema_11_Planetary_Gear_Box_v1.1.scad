// Parametric Planetary Gear Box for Nema 11 Stepper by Felix Kolbe
// Sep. 2014
// It is licensed under the Creative Commons - GNU LGPL 2.1 license.

use <MCAD/involute_gears.scad>
use <MCAD/polyholes.scad>
use <MCAD/metric_fastners.scad>
include <MCAD/stepper.scad>

// Show what?
Sun=1;
Housing=1;
Joins=1;
Planet=1;
Explosion=0;

//ratio 1 Stack: 1-3.75, 2 Stack:1-14.0625, 3 Stack:1-52.7344  ..... and so on
Stacks=2;
Gear_thickness=5;

// Nema 11 assembly on Front Side or Back Side? (Front=1/Back=0 )
// when fron side change diaPitch to min. 0.87
Assembly_Front=1;

/*
	Inner Dia/Innen =d 4 mm
	Outer Dia/Aussen =D 13 mm
	Height / Breite =B 5 mm
	dxDxB
*/
FrontBearing=[5,11,5];


Front_Rotor_length=20;
Back_Rotor_length=14;
Rotor_dia=5;


// NOTHING TO DO AFTER THIS LINE

SonneZ=8;
PlanetZ=7;
HohlradZ=22;
Planeten=3;



//diaPitch=0.90909090;
//diaPitch=.84;
diaPitch=.87;


clearance=0.1;

HousingSquare=(1/diaPitch)*(HohlradZ+2)+2;
RoundCorner=10;
PlanetAchse=3;
FrontJoinHeight=3;
BackJoin=1;
BackJoinHeight=2;
HouseSpace=0.5;

involute_facets=25;

Ra=((1/diaPitch)*SonneZ)/2+((1/diaPitch)*PlanetZ)/2;


//closing the Front?
Assembly_from_Back=0;

echo("<b> Gear Ratio",pow(1+(HohlradZ/SonneZ),Stacks),":1");
echo("<b> Hohlkreis:",((1/diaPitch)*HohlradZ),"Sonne:",((1/diaPitch)*SonneZ),"Planet:",((1/diaPitch)*PlanetZ), "Hohlrad/2-Sonne/2+Planet:",((1/diaPitch)*HohlradZ)/2-(((1/diaPitch)*SonneZ)/2+((1/diaPitch)*PlanetZ)) );
echo("<b>GearHouse:",GearHouseHeight(),"</b>");


if(Explosion){
	if(Assembly_Front){
		rotate([180,0,0]) motor(Nema11,dualAxis=true);
	}else{
		
		translate([0,0,-42]) rotate([180,0,0]) mirror([0,0,1]) motor(Nema11,dualAxis=true);
	}
	 translate([0,0,20]) {
		color("yellow") render() Rotor_Sonne();
		translate([-10,0,2.5]) color("gray") render() rotate([0,90,0]) cylinder(h=3,d=3,$fn=50);
	}
	translate([0,0,Gear_thickness+30]) {
		color("white") render() 
		 if(Assembly_Front){
			HousingFrontMount();		
		}else{
			HousingBackMount();
		}
		
		color("gray")render()	translate([HousingSquare/2+5,0,Stacks*6])mirror([0,0,0])cap_bolt(3,10);
		color("gray")render() translate([-HousingSquare/2-5,0,Stacks*6])mirror([0,0,0])cap_bolt(3,10);
		if(Assembly_Front){
			translate([0,0,18]) for(i=[1:4]){
				color("gray")render() rotate([0,0,-45+i*90]) translate([HousingSquare/2+3,0,0]) mirror([0,0,1])cap_bolt(2.5,6);
			}
		}else{
			translate([0,0,6]){
				color("gray")render() translate([19/2,0,0]) mirror([0,0,1])cap_bolt(2.5,8);
				color("gray")render() translate([-19/2,0,0]) mirror([0,0,1])cap_bolt(2.5,8);
			}
		}
	
	}
	
	 translate([0,0,Gear_thickness+35+GearHouseHeight()+FrontMountHeight()]){ 
		for(x=[0:Stacks-1]){
			
			translate([0,0,x*(Gear_thickness*2+FrontJoinHeight+BackJoinHeight+13)]){
				if(BackJoin){
					translate([0,0,-3]) color("red") render() BackJoin();
				}
				color("blue") render()
				for(i=[1:Planeten]){
					rotate([0,0,(360/Planeten)*i]) translate([0,Ra,0]) Planet();
				}
				color("red") render(){
					translate([0,0,12])
						mirror([0,0,1]) rotate([0,0,155]) 
						if(x+1!=Stacks){
							FrontJoin();
						}else{
							rotate([0,0,0]) End_FrontJoin();
							
						}
				}
				if(x+1==Stacks){
					color("gray") render()rotate([0,0,-90])translate([-10,00,10])  rotate([0,90,0]) cylinder(h=3,d=3,$fn=50);
				}
				if(x+1!=Stacks)
				color("yellow") render(){
					translate([0,0,Gear_thickness*2+FrontJoinHeight+BackJoinHeight+7])
						mirror([0,0,1])Zwischen_Sonne();
				}
			}
		}
	}
	if(!Assembly_from_Back || !Assembly_Front){
		translate([0,0,Gear_thickness+40+GearHouseHeight()+FrontMountHeight()+Stacks*(Gear_thickness*2+FrontJoinHeight+BackJoinHeight+7)]){
			color("white") render(){
				mirror([0,0,1])HousingFront();
			}
			color("gray") render(){
				translate([HousingSquare/2+5,0,3]) flat_nut(3);
				translate([-HousingSquare/2-5,0,3]) flat_nut(3);
				translate([0,0,-10]) cylinder(h=30,d=Rotor_dia,$fn=50);
			}			
		}
	}
}


if(Sun && !Explosion){
	for(i=[0:Stacks-1]){
		if(i==0){
			Rotor_Sonne();
		}else{
			translate([15*i,0,0]){				
				Zwischen_Sonne();
			}
		}
	};
}

module Zwischen_Sonne(){
	Sonne();
	translate([0,0,Gear_thickness])cylinder(h=3,r=SchluesselWeite_Radius(5.5),$fn=6);
}
module Rotor_Sonne(){
	difference(){
		union(){
			translate([0,0,5])Sonne();				
			cylinder(h=5,d=(1/diaPitch)*(SonneZ+2));					
		}				
		polyhole(h=Gear_thickness+5,d=Rotor_dia);									
		translate([0,0,2.5]) rotate([0,-90,0]) polyhole(h=12/2,d=2.5);
	}
}
if(Planet && !Explosion){
	for(i=[0:Stacks-1]){
		for(x=[0:Planeten-1]){
			translate([12*x,(i+1)*12,0]){
				Planet();
				//translate([0,0,11])rotate([0,0,360/PlanetZ/2])Planet_1();
			}
		}
		
	};
}

if(Joins && !Explosion){	
	for(i=[0:Stacks-1]){
		translate([(Ra*3+Ra)*i,-Ra*2,0]){
			if(BackJoin){
				translate([0,-Ra*2.5,0]) BackJoin(BackJoinHeight);
			}		
			if(i+1==Stacks){
				End_FrontJoin();
			}else{
				FrontJoin();
			}
		}
	};
}

if(Housing && !Explosion){
	if(Assembly_Front){
		translate([-40,-20,0]) HousingFrontMount();
	}else{
		translate([-40,-20,0]) HousingBackMount();
	}
};

module FrontJoin(Sechskant=1){
	difference(){
		union(){
			cylinder(h=3,r=5,$fn=50);
			for(i=[0:Planeten-1]){
				rotate([0,0,(360/Planeten)*i]){
					translate([0,-1.5,0]) cube([Ra,3,3]);
					translate([Ra,0,0]){
						cylinder(h=FrontJoinHeight,d=4,$fn=50);
						if(BackJoin){
							cylinder(h=FrontJoinHeight+Gear_thickness+BackJoinHeight,d=PlanetAchse,$fn=50);
						}else{
							cylinder(h=FrontJoinHeight+Gear_thickness,d=PlanetAchse,$fn=50);
						}
					}
				}
			}
		}
		if(Sechskant){
			cylinder(h=3,r=SchluesselWeite_Radius(5.7),$fn=6);
		}
	}
}

module End_FrontJoin(){
	difference(){
		union(){
			translate([0,0,FrontJoinHeight]) FrontJoin(0);
			FrontJoin(0);			
		}
		polyhole(h=5,d=Rotor_dia);
		
		translate([0,0,2.5]) 
			if(Planeten==4){
				rotate([0,-90,45]) polyhole(h=12/2,d=2.5);
			}else{
				rotate([0,-90,120]) polyhole(h=12/2,d=2.5);
			}
		
	}
}

module BackJoin(h=1){
	linear_extrude(height=h)
		difference(){
			circle(r=Ra+PlanetAchse/2+1,$fn=50);
			circle(d=(1/diaPitch)*(SonneZ+2)+2,$fn=50);
			for(i=[0:Planeten-1]){
				rotate([0,0,(360/Planeten)*i])
					translate([Ra,0,0]){
						circle(d=PlanetAchse+.2,$fn=50);
				}
			}
		}
}

module Sonne(){
difference(){
	gear (number_of_teeth=SonneZ,
				diametral_pitch=diaPitch,
				circles=0,
				hub_diameter=0,
				bore_diameter=0,
				clearance=clearance,
				rim_thickness=Gear_thickness,
				involute_facets=involute_facets);		
	};
}

//Planeten

module Planet_1(){
	difference(){
		linear_extrude("Planet.dfx",height=Gear_thickness);
		polyhole(h=5,d=PlanetAchse+.2);
	}
}
module Planet(){
	//circular_pitch=Pitch,
	//diametral_pitch=1.2,
	difference(){
				//rotate([0,0,10/i*36])
		gear (number_of_teeth=PlanetZ,				
			diametral_pitch=diaPitch,
			circles=0,
			hub_diameter=0,
			bore_diameter=3,
			rim_thickness=Gear_thickness,
			clearance=clearance,
			involute_facets=involute_facets
			);
		polyhole(h=5,d=PlanetAchse+.2);
	}
}
module HousingFront(){
	if(!Assembly_from_Back){
		translate([0,0,FrontBearing[2]+1]) rotate([180,0,0]) _HousingFront();
	}else{
		_HousingFront();
	}
}
module _HousingFront(){	
	difference(){
		union(){
			cylinder(h=FrontBearing[2]+1,r=((1/diaPitch)*(HohlradZ+2))/2+1);
			if(!Assembly_from_Back){	
				translate([-(((1/diaPitch)*(HohlradZ+2))+8*2)/2,-8/2,0]) cube([((1/diaPitch)*(HohlradZ+2))+8*2,8,FrontBearing[2]+1]);
			}
		}
		polyhole(h=FrontBearing[2]+1,d=FrontBearing[0]);
		polyhole(h=FrontBearing[2],d=FrontBearing[1]+0.2);
		if(!Assembly_from_Back){
			translate([(((1/diaPitch)*(HohlradZ+2))+7.75)/2,0,0]){
				polyhole(h=FrontBearing[2]+1,d=3);
				
				rotate([0,0,360/12]) translate([0,0,2.2])cylinder(h=FrontBearing[2]+1,r=SchluesselWeite_Radius(5.6),$fn=6);
			}
			translate([-(((1/diaPitch)*(HohlradZ+2))+7.75)/2,0,0]){
				polyhole(h=FrontBearing[2]+1,d=3);
				
				rotate([0,0,360/12]) translate([0,0,2.2])cylinder(h=FrontBearing[2]+1,r=SchluesselWeite_Radius(5.6),$fn=6);
			}
		}
	}
}

module M25Bolt(){
	union(){
		translate([0,0,6.6-2.5]) polyhole(h=2.5,d=4.6);
		polyhole(h=6.6,d=2.5);
	}
}

module HousingBackMount(){
	M25h=2.6;
	
	difference(){
		union(){		
			
			linear_extrude(height=BackMountHeight()){
				minkowski(){
					square(HousingSquare-RoundCorner,true);
					circle(d=RoundCorner);
				}
			}			
			translate([0,0,M25h+1.5+(BackMountHeight()-(M25h+1.5))])cylinder(h=GearHouseHeight(),r=((1/diaPitch)*(HohlradZ+2))/2+1);
			
			translate([0,0,M25h+1.5+(BackMountHeight()-(M25h+1.5))+GearHouseHeight()-4.4]) FrMountBottom();
		}
		translate([19.05/2,0,0]) {
			translate([0,0,1.5]) polyhole(h=HousingSquare,BackMountHeight()-(M25h+1.5)+1,d=4.55);
			polyhole(h=M25h+1.5,d=2.5);
			rotate([0,-7,0])M25Bolt();
		}
		translate([-19.05/2,0,0]){
			translate([0,0,1.5]) polyhole(h=HousingSquare,BackMountHeight()-(M25h+1.5)+1,d=4.55);
			polyhole(h=M25h+1.5,d=2.5);
			rotate([0,7,0])M25Bolt();
		}
		
		polyhole(h=M25h+1.5,d=((1/diaPitch)*(SonneZ+2))+1);
		translate([0,0,(M25h+1.5)]) polyhole(h=BackMountHeight()-(M25h+1.5),d=((1/diaPitch)*(HohlradZ-2.5)));
		
		translate([0,0,M25h+1.5+(BackMountHeight()-(M25h+1.5))]) 
				gear (number_of_teeth=HohlradZ,
						diametral_pitch=diaPitch,
						circles=0,
						hub_diameter=0,
						bore_diameter=0,					
						hub_thickness=0,
						rim_thickness=GearHouseHeight()+.001,
						gear_thickness=GearHouseHeight()+.001,
						clearance=-clearance,
						involute_facets=involute_facets
						);
		
	}
	if(!Explosion){
		translate([0,(((1/diaPitch)*(HohlradZ+2))+8)/2+20,0]) HousingFront();
	}
}

module HousingFrontMount(){
	difference(){
		union(){
			linear_extrude(height=FrontMountHeight()){
				minkowski(){
					square(HousingSquare-RoundCorner,true);
					circle(d=RoundCorner);
				}
			}
			translate([0,0,(FrontMountHeight())])cylinder(h=GearHouseHeight(),r=((1/diaPitch)*(HohlradZ+2))/2+1);
			if(!Assembly_from_Back){	
				translate([0,0,(FrontMountHeight())+GearHouseHeight()-4.4]) FrMountBottom();
			}else{
				translate([0,0,(FrontMountHeight())+GearHouseHeight()]) HousingFront();
			}
			
		}
		for(i=[1:4]){
			rotate([0,0,-45+90*i])translate([sqrt(pow(11.5,2)*2),0,0]){				
				polyhole(d=2.5,h=10);
				translate([0,0,5.5]) rotate([0,0,360/18])polyhole(d=4.5,h=16);
				translate([0,-2.25,5.5]) cube([4.5,4.5,16]);
				
			}
		}
		if(Assembly_from_Back){	
			gear (number_of_teeth=HohlradZ,
						diametral_pitch=diaPitch,
						circles=0,
						hub_diameter=0,
						bore_diameter=0,					
						hub_thickness=0,
						rim_thickness=GearHouseHeight()+FrontMountHeight(),
						gear_thickness=GearHouseHeight()+FrontMountHeight(),
						clearance=-clearance,
						involute_facets=involute_facets
						);
		}else{
			translate([0,0,FrontMountHeight()]){ //scale([1.016,1.016,1])
				gear (number_of_teeth=HohlradZ,
						diametral_pitch=diaPitch,
						circles=0,
						hub_diameter=0,
						bore_diameter=0,					
						hub_thickness=0,
						rim_thickness=GearHouseHeight()+.001,
						gear_thickness=GearHouseHeight()+.001,
						clearance=-clearance,
						involute_facets=involute_facets
						);
			translate([0,0,-BackJoinHeight-.5])cylinder(h=BackJoinHeight+.5,r=Ra+PlanetAchse/2+1+.5,$fn=50);
			}
		}
		polyhole(h=(Front_Rotor_length-Gear_thickness-5)+Stacks*8,d=22.2);
		
		
	}
		
	if(!Assembly_from_Back && !Explosion){	
		translate([0,(((1/diaPitch)*(HohlradZ+2))+7.75)/2+20,0]) HousingFront();
	}
}

module FrMountBottom(){
	difference(){
		translate([0,0,2.2]) cube([HousingSquare+8*2,8,4.4],true);
		translate([(((1/diaPitch)*(HohlradZ+2))+8)/2,0,0]){
			polyhole(h=5,d=3);
			polyhole(h=2,d=5.7);
			//cylinder(h=2.2,r=SchluesselWeite_Radius(5.5),$fn=6);
		}
		translate([-(((1/diaPitch)*(HohlradZ+2))+8)/2,0,0]){
			polyhole(h=5,d=3);
			polyhole(h=2,d=5.7);
		}
	}
}

function SchluesselWeite_Radius(SW)=(SW/2)/cos(30);


function GearHouseHeight()=Stacks*(FrontJoinHeight+Gear_thickness)+(Stacks-1)*(BackJoinHeight*BackJoin)+3+HouseSpace;

function BackMountHeight()=max(Back_Rotor_length-Gear_thickness,Gear_thickness+5);
function FrontMountHeight()=max(Front_Rotor_length-Gear_thickness,Gear_thickness+5);

