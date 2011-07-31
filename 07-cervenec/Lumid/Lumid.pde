import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int num = 10;
Lum lum[] = new Lum[num];
int W = 800;

int H = 600;


void setup(){
	size(W,H,P2D);

	frameRate(30);

	oscP5 = new OscP5(this,12000);
	myRemoteLocation = new NetAddress("127.0.0.1",1234);

	textFont(createFont("FreeSans",9,false));
	textMode(SCREEN);
	rectMode(CENTER);
	noStroke();
	noSmooth();

	for(int i = 0;i<lum.length;i++){
		lum[i] = new Lum(i);
	}
}

void draw(){
	background(0);
	for(int i = 0;i<lum.length;i++){
		lum[i].draw();
	}
	sendAll();
}


void sendAll(){
	/* in the following different ways of creating osc messages are shown by example */
	OscMessage myMessage = new OscMessage("/lumid");

	for(int i =0;i<lum.length;i++)
		myMessage.add(lum[i].vald); /* add an int to the osc message */

	/* send the message */
	oscP5.send(myMessage, myRemoteLocation);
}

void keyPressed(){
	if(key >= '0' && key <= '9' ){
		//println((int)key);
		lum[(int)key-48].valUp();
		//lum
	}


}

void keyReleased(){
	if(key >= '0' && key <= '9' ){
		lum[(int)key-48].valDown();
		//lum
	}


}

class Lum{
	PGraphics vzor;
	int val,id,vald = 0;
	int x,y,w,h;

	boolean render = false;

	Lum(int _id){
		id = _id;
		x = (int)random(width);
		y = (int)random(height);
		w = (int)random(-width,width);
		h = (int)random(-height,height);

		if(render){
			vzor = createGraphics(W,H,P2D);
			vzor.beginDraw();
			vzor.fill(255);
			vzor.noSmooth();
			vzor.noStroke();
			vzor.rect(random(width),random(height),random(-w,w),random(-h,h));
			//vzor.filter(BLUR,2.0);
			vzor.endDraw();
		}
	}

	void step(){
		val = (int)(noise(id+frameCount/2.0)*255);
	}

	void valUp(){
		val = 255;
	}

	void valDown(){
		val = 0;
	}

	void draw(){

		if(render){
			tint(255,vald);
			image(vzor,0,0);
		}else{
			vald = val*(frameCount%2);
			fill(255,vald);
			rect(x,y,w,h);

		}
	}

}

