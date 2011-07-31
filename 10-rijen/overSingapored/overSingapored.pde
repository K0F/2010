import processing.opengl.*;

void setup(){
	size(1024,768,OPENGL);
	background(255);


}

int y=0;

void draw(){
	line(0,y,width,y++);	



}
