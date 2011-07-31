/**
*
*/

import hipstersinc.sunflow.*;
import hipstersinc.sunflow.shader.*;
import hipstersinc.*;

int numSpheres = 400;
Sph[] sph;

void setup() {
	size(720, 480 ,"hipstersinc.P5Sunflow");
	sph = new Sph[numSpheres];
	//noLoop();

	for(int i = 0;i<numSpheres;i++)
		sph[i] = new Sph();
}


void draw() {
	background(0);

	for(int i=0; i<numSpheres; i++) {
		sph[i].draw();
	}

	saveFrame("out/fram####.png");
}

class Sph{

	float x,y,z,speed = 40.0;

	Sph(){
		x = random(-width,width*2);
		y = random(-width,width*2);
		z = -random(width);
	}

	void draw(){
		compute();
		pushMatrix();
		translate(x,y,z);
		fill( 255 );
		sphere(40);
		popMatrix();
	}

	void compute(){
		x+= (width/2-x)/speed;
		y+= (height/2-y)/speed;
		z+= (-z)/speed;
	}

}
