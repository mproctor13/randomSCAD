// *************************************************
// Laser Cut Wood Box
//
// Units: mm
// *************************************************

Mat_T=0.125*25.4;
Curf_w=0.25;

Overlap=0.01;

module BoxLeft(Y=100,Z=40,HasTop=true){
	nZTabs=3;
	EndNotch_Z=Z/(nZTabs*2)-Curf_w;
	EndNotch_Y=Mat_T-Curf_w;
	
	nYTabs=6;
	BotNotch_Z=Mat_T-Curf_w;
	BotNotch_Y=(Y-Mat_T*2)/(nYTabs*2+1)-Curf_w;
	
	difference(){
		// the raw panel w/ 1/2 Curf extra all the way around
		translate([-Curf_w/2,-Curf_w/2]) square([Z+Curf_w,Y+Curf_w]);
		
		// back
		for (j=[0:nZTabs-1]) translate([Z/(nZTabs*2)+Z/nZTabs*j+Curf_w/2, Y-EndNotch_Y+Curf_w/2])
			square([EndNotch_Z, EndNotch_Y+Overlap]);
			
		// front
		for (j=[0:nZTabs-1]) translate([Z/(nZTabs*2)+Z/nZTabs*j+Curf_w/2, EndNotch_Y-Curf_w/2])
			mirror([0,1]) square([EndNotch_Z, EndNotch_Y+Overlap]);
		
		// bottom
		for (j=[0:nYTabs-1]) translate([Z-BotNotch_Z+Curf_w/2, Mat_T+BotNotch_Y+(BotNotch_Y+Curf_w)*2*j+Curf_w/2])
			square([BotNotch_Z+Overlap,BotNotch_Y]);
	} // diff
} // BoxLeft

BoxLeft();

module BoxBottom(X=60,Y=100){
	nYTabs=6;
	LeftNotch_Z=Mat_T-Curf_w;
	LeftNotch_Y=(Y-Mat_T*2)/(nYTabs*2+1)-Curf_w;

	nXTabs=3;
	BackNotch_Y=Mat_T-Curf_w;
	BackNotch_X=X/(nXTabs*2+1)-Curf_w;
	
	difference(){
		// the raw panel w/ 1/2 Curf extra all the way around
		translate([-Curf_w/2,-Curf_w/2]) square([X+Curf_w,Y+Curf_w]);
		
		// left edge
		for (j=[0:nYTabs]) translate([Mat_T-Curf_w/2, Mat_T+(LeftNotch_Y+Curf_w)*2*j+Curf_w/2])
			mirror([1,0]) square([LeftNotch_Z+Curf_w+Overlap,LeftNotch_Y]);
		
		// right edge
		for (j=[0:nYTabs]) translate([X-Mat_T+Curf_w/2, Mat_T+(LeftNotch_Y+Curf_w)*2*j+Curf_w/2])
			square([LeftNotch_Z+Curf_w+Overlap,LeftNotch_Y]);
		
		// back edge
		for (j=[0:nXTabs]) translate([(BackNotch_X+Curf_w)*2*j+Curf_w/2, Y-BackNotch_Y-Curf_w/2])
			square([BackNotch_X,BackNotch_Y+Curf_w+Overlap]);
	} // diff
} // BoxBottom

translate([50,0]) BoxBottom();






















