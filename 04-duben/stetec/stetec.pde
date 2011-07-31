/**
*
* Peresent mode
*
*
*/

import processing.opengl.*;

PImage sim;
float x,y,tx,ty;
float speed = 50.0;
float theta;

boolean down = false;

void setup(){
	size(1024,768,P2D);
	background(0);

//	hint(DISABLE_OPENGL_2X_SMOOTH);
	//hint(DISABLE_DEPTH_TEST);
	//hint(ENABLE_DEPTH_SORT);


	sim=loadImage("test.png");
		smooth();
}

void draw(){/*
				  //background(0);
				  fill(0,5);
				  rect(0,0,width,height);

				*/

	if(frameCount<10)
		background(0);


	if(!down){
		tx = mouseX;
		ty = mouseY;
	}else{

		tx+=(mouseX-tx)/speed;
		ty+=(mouseY-ty)/speed;
		x+=(tx-x)/speed;
		y+=(ty-y)/speed;
		theta=atan2(ty-y,tx-x);

		tint(255,5);
		pushMatrix();
		translate(x+(sim.width/2),y+(sim.height/2));
		rotate(theta);
		//image(sim,0,0);
		
		for(int i = (-50);i<50;i+=5){
			stroke(#FFCC00,map(i,-50,50,0,20));
			line(0,i,15,i);
		}
		popMatrix();

	}
}

void mousePressed(){
	down = true;
	tx = mouseX;
	ty = mouseY;

	x = pmouseX;
	y = pmouseY;
}

void mouseReleased(){
	down = false;

}

void keyPressed(){
	if(key == ' '){
		save("screen"+frameCount+".png");
	}else if(keyCode == DELETE){
		background(0);
	}
	keyPressed=false;
}
