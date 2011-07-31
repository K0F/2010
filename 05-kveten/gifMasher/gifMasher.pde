/*
* Demonstrates the use of the GifAnimation library.
 * Exports a GIF-File to the sketch folder if space
 * bar is pressed. Wow, feels like 90's! ;)
 */

import gifAnimation.*;
import processing.opengl.*;

GifMaker gifExport;
PImage logo;
float rotation = 0.0;

color [] palette = new color[3];

public void setup() {
	size(600, 100, P2D);
	frameRate(12);

	println("gifAnimation " + Gif.version());
	gifExport = new GifMaker(this, "export.gif");
	gifExport.setRepeat(0); // make it an "endless" animation
	//gifExport.setTransparent(0,0,0); // make black the transparent color. every black pixel in the animation will be transparent
	// GIF doesn't know have alpha values like processing. a pixel can only be totally transparent or totally opaque.
	// set the processing background and the transparent gif color to the same value as the gifs destination background color
	// (e.g. the website bg-color). Like this you can have the antialiasing from processing in the gif.
	fill(255);
	noStroke();
	
	for(int i = 0;i<palette.length;i++)
		palette[i] = color(random(10,255),random(10,255),random(10,255));

	textFont(createFont("Sans",25,false));
	textMode(SCREEN);
	textAlign(CENTER);
}

void draw() {
	background(0);


	//rect(x,y,4,4);

	for(int i =0;i<100;i++){

		int x = (int)random(0,width);
		int y = (int)random(0,height);

		fill(palette[(int)random(palette.length)],140);
		text("FAMU - CAS",x,y);
	}

	gifExport.setDelay(1);
	gifExport.addFrame();
	
	if(frameCount==4)
		endIt();
}

void endIt(){
gifExport.finish();

	exit();
}

void keyPressed() {
	
}
