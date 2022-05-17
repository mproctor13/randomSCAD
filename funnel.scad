funnel_opening = 100;
neck_width = 10;
neck_length = 20;
$fn=$preview ? 30 : 120;

cylinder(d1=funnel_opening, d2=neck_width, h=100);
translate([0,0,100]) cylinder(d=neck_width, h=neck_length);