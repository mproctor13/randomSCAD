one=25.4*.75;
two=25.4*1.75;
three=25.4*2.75;

for(X=[-1,1]) translate([(25.4*24)*X, 0,two]) cube([two, two, (25.4*48)]);

for(X=[-1,1]) translate([(25.4*24)*X, -(25.4*24),0]) cube([two, (25.4*48), two]);

for(Z=[(25.4*24), (25.4*48)]) translate([-(25.4*24),0,Z]) cube([(25.4*48), two, two]);


for(X=[-1,1]) translate([(25.4*24)*X, (25.4*24), -two]) rotate([30,0,0]) cube([one, three, (25.4*48)]);

for(X=[-1,1]) translate([(25.4*24)*X, -(25.4*24), -two]) rotate([-30,0,0]) cube([one, three, (25.4*48)]);
