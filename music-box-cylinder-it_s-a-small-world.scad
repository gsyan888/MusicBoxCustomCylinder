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
//It's a small world
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


//=========================================
// Start to generate the music box disc
//=========================================
// keep this line
generateMusicBoxCylinder();
