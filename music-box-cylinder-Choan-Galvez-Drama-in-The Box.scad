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
//Choan Galvez : Drama in The Box
// http://ukulelehunt.com/2019/02/27/choan-galvez-drama-in-the-box-tab/
musicScore = [
    //1st. track
   [
6, 10, 3, 6, 10, 3, 6, 10,
6, 10, 3, 6, 10, 3, 6, 10,
5.5, 7, 3, 5, 7,  3, 5, 7,
10, 30, 3, 10, 30, 3, 10, 30,
6, 10.5, 3, 6, 10, 3, 6, 10,
20, 40, 6, 20, 40, 6, 20, 40, 
6, 10, 3, 6, 7, 3, 5.5, 7
    ]
];


//=========================================
// Start to generate the music box disc
//=========================================
// keep this line
//
generateMusicBoxCylinder();
