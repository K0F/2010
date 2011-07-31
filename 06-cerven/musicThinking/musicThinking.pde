import codeanticode.gsvideo.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

boolean full = false;
int X = 0;
int Y = 0;
Tonenode t[] = new Tonenode[0];

int siz = 10;



void setup(){
	size(640,20,P2D);
	rectMode(CENTER);


	int cw = width;
	int ch = height;
	oscP5 = new OscP5(this,12000);
	myRemoteLocation = new NetAddress("127.0.0.1",12000);
	frameRate(30);

	int cnt = 0;
	while(!full){
		t = (Tonenode[])append(t,new Tonenode(cnt));
		cnt++;
	}

	textFont(createFont("FreeSans",9,false));
	textMode(SCREEN);
	rectMode(CENTER);
	noFill();
	noStroke();
	noSmooth();


}


void draw(){
	background(0);

	for(int i  = 0 ;i<t.length;i++)
		t[i].setval(noise((frameCount+i)/100.0)*255);


	//set(0,0,cam);

	for(int i  = 0 ;i<t.length;i++){
		t[i].draw();

	}

	sendAll();



}

void sendAll(){
	/* in the following different ways of creating osc messages are shown by example */
	OscMessage myMessage = new OscMessage("/cam");

	for(int i =0;i<t.length;i++)
		myMessage.add(t[i].val2); /* add an int to the osc message */

	/* send the message */
	oscP5.send(myMessage, myRemoteLocation);


}

class Tonenode{

	int id;
	int x,y;
	int state;
	float val = 0,val2 = 0;

	Tonenode(int _id){
		id = _id;
		x=X;
		y=Y;

		X+=siz;
		if(X>=width){
			X=0;
			Y+=siz;

		}

		if(Y>=height)
			full = true;
	}


	void draw(){

		val2 = (t[(id+t.length-1)%(t.length-1)].val+t[(id+t.length+1)%(t.length-1)].val+val)/3.0;
		fill(val2);
		rect(x,y,siz,siz);



	}

	void setval(float _val){
		val = _val;
	}

}

class Link{

	Link(){


	}

}
