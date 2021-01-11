//================================
//Music Box Cylinder Generator
//================================
//
//by gsyan ( https://gsyan888.blogspot.com/ )
//
//2021.01.09 start this project
//
//
//=========================================
// Include the generator
//=========================================
// keep this line
include <music-box-custom-cylinder.scad>;


//=========================================
// Edit your Music score
//=========================================
//
// the note numbers are defined in music-box-cylinder.scad
// find the list named "notesIndexMap"
//
//Alle Vögel sind schon da
//春神來了
musicScore = [
    //1st. track
    [
1,0,0, 3, 5,0,  10,0, 
6,0, 10,6, 5,0, 0,0,
4,0,0,  5, 3,0, 1,0, 
2,0,0,0, 1,0, 0,0,
5,0, 5,0, 4,0, 4,0, 
3,0, 5,3, 2,0,0,0,
5,0, 5,0, 4,0, 4,0, 
3,0, 5,3, 2,0, 0,0,
1,0,0, 3, 5,0,  10,0, 
6,0, 10,6, 5,0, 0,0,
4,0,0,  5, 3,0, 1,0, 
2,0,0,0, 1,0, 0,0
    ]
];


//=========================================
// Start to generate the music box disc
//=========================================
// keep this line
generateMusicBoxCylinder();
