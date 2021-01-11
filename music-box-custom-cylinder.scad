//================================
//Music Box Cylinder Generator
//================================
//
//by gsyan ( https://gsyan888.blogspot.com/ )
//
//2021.01.09 start this project
//
//


/* [Global] */ 

/* [Direction Setting] */
//bass pin is on the top (near the gear)
isTopFirst = true;

//cylinder rotate direction
isCounterclockwise = true;


/* [Cylinder Size Setting] */
cylinderDiameter = 13;
cylinderThickness = 0.6;
cylinderHeight = 20;

//cylinder diameter cylinderTolerance
cylinderTolerance = 0.1;

/* [Combo Teeth Setting] */
comboWidth = 16.3;
teethTotalNumber = 18;

/* [Pins Size Setting] */
pinDiameter = 0.4;
pinBaseDiameter = 0.8;
pinHeight = 0.6;

//the distance of two pins
pinOffset = 0.9;

//if same note move more
enableAvoidTooNear = false;

//the position of the first pin
firstPinPosition = 1.9+pinBaseDiameter/4;

/* [Cylinder Bottom Setting] */
cylinderBottomDiameter = 15.3;
cylinderBottomHeight = 1;
cylinderBottomHoleD1 = 5.4;
cylinderBottomHoleD2 = 4;

/* [Cylinder Top Lock Hole Setting] */
cylinderTopHoleWidth = 3.6;
cylinderTopHoleHeight = 1;

//=========================================
// Music score example
//=========================================
//
// the note numbers are defined in a list,
// find the list named "notesIndexMap"
//
musicScore = [
	//1st. track
    [
3,4,
5,0, 30,0,
10,0, 20,10,
10,0, 7,0,
7,0, 2, 3,
4,0, 20,0,
7,0, 10, 7,
6,0, 5,0,
5,0, 3, 4,
5,0, 10, 20,
30,0, 20, 10,
6,0, 20, 30,
40,0, 30, 20,
5,0, 40,0,
30,0, 20,0,
10,0,0,0,
0, 0, 0, 0
    ]
];


//
//notes and comb teeth number mapping
//
//
//Note Nomenclature
//
//		Note	C	D	E	F	G	A	B
//Octave
//[3]			-	-	-	-	-	-	-7
//[4]			1	2	3	4	5	6	7
//[5]			10	20	30	40	-	-	-
//
//Others		
//				A#3		-6.5
//				G#4		5.5
//				A#4		6.5
//				C#5		10.5
//				D#5		20.5
//				E#5		30.5
//				pause	0
//
notesIndexMap = [
 //note number, teeth number
 [0         , 0],   //pause
 
 [-6.5      , 1],   //A#3
 [-7        , 2],   //B3
 
 [1         , 3],   //C4
 [2         , 4],   //D4
 [3         , 5],   //B4
 [4         , 6],   //F4
 [5         , 7],   //G4 
 [5.5       , 8],   //G#4
 [6         , 9],   //A4
 [6.5       ,10],   //A#4
 [7         ,11],   //B4
 
 [10        ,12],   //C5
 [10.5      ,13],   //C#5
 [20        ,14],   //D5
 [20.5      ,15],  	//D#5
 [30        ,16],   //E5
 [30.5      ,17],   //E#5
 [40        ,18]    //F5
  
];

/* [Hidden] */ //don't touch below this line unless you need to adjust under the hood


//total number of tones
tonesTotalNumber = len(notesIndexMap)-1;

//
//Find the value in a list(key and value) with key
//
// OpenSCAD looup return unknow value when found nothing
// this function will return 0 when found nothing
//
function findValue(key, nList, n=0) = (n>=0 && n<len(nList) ? (key==nList[n][0] ? nList[n][1] : findValue(key, nList, n+1)) : 0);


//find the tooth number (1-22) of the note
//function getToothId(n) = lookup(n, notesIndexMap);
function getToothId(n) = findValue(n, notesIndexMap);

//generate cylinder body
module generateBody() {
	difference() {
		cylinder(d=cylinderDiameter-cylinderTolerance, h=cylinderHeight, $fn=100, center=false);
    
		cylinder(d=cylinderDiameter-cylinderTolerance-cylinderThickness*2, h=cylinderHeight, $fn=100, center=false);
    
		//top hole
		translate([cylinderDiameter/-2,cylinderTopHoleWidth/-2, cylinderHeight-cylinderTopHoleHeight])
		cube([cylinderDiameter, cylinderTopHoleWidth, cylinderTopHoleHeight]);
	}
	//bottom
	translate([0, 0, -cylinderBottomHeight])
	difference() {
		cylinder(d=cylinderBottomDiameter, h=cylinderBottomHeight, $fn=64, center=false);

		cylinder(d1=cylinderBottomHoleD1,d2=cylinderBottomHoleD2, h=cylinderBottomHeight, $fn=64, center=false);
	}
}

module generatePins(notes) {
    notesTotal = len(notes);		//total number of notes
    offsetAngle = 360/notesTotal; 	//the angle to roate
    
    for(i=[0 :notesTotal-1]) {
        toothId = getToothId(notes[i]);
     
        //echo(i, notes[i], toothId);
        if( toothId > 0 ) {
            angleMore = (enableAvoidTooNear && offsetAngle<10 && i>0 && notes[i-1] == notes[i] ? offsetAngle/2 : 0);
            angle = (isCounterclockwise ? -1 : 1)*(offsetAngle*i+angleMore);
        
            rOffset = 0.3;
            radius = cylinderDiameter/2-rOffset;
            x = radius*cos(angle);
            y = radius*sin(angle);
            z = firstPinPosition+pinOffset*(isTopFirst ? (tonesTotalNumber-toothId) : toothId);  //the smaller the highter
        
            translate([x, y, z])
            rotate([0, 0, angle])
            rotate([0, 90, 0])
           cylinder(d1=pinBaseDiameter, d2=pinDiameter, h=pinHeight+rOffset, $fn=20, center=false); //cylinder(r1=pinDiameter/2*2,r2=pinDiameter/2, h=pinHeight+rOffset, $fn=100, center=false);
        } else if(notes[i] !=0 ) {
            echo("==Not Exist== ",notes[i]);
        }
    }
}

//  
//main module
//
module generateMusicBoxCylinder() {
	//body
	generateBody();
	
	//pins
	for(i=[0 : len(musicScore)-1]) {
		generatePins(musicScore[i]);
	}
}

//=========================================
// Start to generate the music box disc
//=========================================
generateMusicBoxCylinder();
