import codeanticode.gsvideo.*;
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;



int W = 320;
int H = 240;

int cw = W;
int ch = H;



GSPipeline cam;
Senzor s[];
Graph g;

void setup(){
	size(W,H,P2D);

	frameRate(25);
	
	oscP5 = new OscP5(this,12000);
	myRemoteLocation = new NetAddress("127.0.0.1",12000);

	reset();

	String webcam = "v4l2src ! queue2 ! ffvideoscale ! "+"video/x-raw-rgb,width="+cw+",height="+ch+", bpp=32, depth=24";
	String dv = "dv1394src ! queue ! dvdemux ! ffdec_dvvideo ! ffmpegcolorspace ! ffvideoscale ! video/x-raw-rgb,width = "+cw+", height = "+ch+", bpp=32, depth=24";
	
	cam = new GSPipeline(this, webcam);
	loadPixels();

	textFont(createFont("FreeSans",9,false));
	textMode(SCREEN);
	rectMode(CENTER);
	
	noFill();
	stroke(255);
	noSmooth();
}

void draw(){

	if (cam.available() == true){
		cam.read();
		cam.loadPixels();

		for(int y = 0;y<ch;y++){
			for(int x = 0;x<cw;x++){
				pixels[y*cw+x] = cam.pixels[y*cw+x];
			}
		}

	}

	for(int i =0;i<s.length;i++)
		s[i].compute();

	for(int i =0;i<s.length;i++)
		s[i].draw();
	
	//g.draw();
	//image(g.p,0,0);
	
	sendAll();
}



void reset(){
	s = new Senzor[0];
	g = new Graph();
}

void mousePressed(){
	s = (Senzor[])append(s,new Senzor(mouseX,mouseY,s.length));

}

void keyPressed(){
	if(keyCode==BACKSPACE){
		reset();
	}else if(keyCode==LEFT){
		s[s.length-1].x--;
	}else if(keyCode==RIGHT){
		s[s.length-1].x++;
	}else if(keyCode==DOWN){
		s[s.length-1].y++;
	}else if(keyCode==UP){
		s[s.length-1].y--;
	}

}

void sendAll(){
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/cam");
  
  for(int i =0;i<s.length;i++)
  myMessage.add(s[i].sval); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 


}

class Senzor{
	int x,y,id,bx,by;
	float val,sval,sval2;
	float speed = 10.0;
	float krouz;
	float r;

	Senzor(int _x,int _y,int _id){
		bx=x=_x;
		by=y=_y;
		id=_id;
		krouz = random(5,60);
		r = 30.0;
	}

	void draw(){
		stroke(255-sval);
		rect(x,y,3,3);
		pushStyle();
		fill(255-sval);
		text(id+":"+((int)sval),x+10,y);
		popStyle();
	}

	void compute(){
		
		val = getVal();
		sval2 = sval;
		sval += (val-sval) / speed;
		
		x=(int)(bx+(cos(frameCount/krouz)+1.0)*r);
		y=(int)(by+(sin(frameCount/krouz))*r);
		
		x = constrain(x,2,width-2);
		y = constrain(y,2,height-2);
	}

	float getVal(){
		float tmp = 0;
		for(int Y = -1;Y<=1;Y++){
			for(int X = -1;X<=1;X++){
				tmp += brightness(pixels[(y+Y)*W+(x+X)])/9.0;
			}
		}

		return(tmp);
	}
}

class Graph{
	PGraphics p;
	int xx = 0;
	
	Graph(){
		p = createGraphics(width,height,P2D);
	}
	
	void draw(){
		p.beginDraw();
		
		for(int i = 0;i<s.length;i++){
			p.stroke(255-s[i].sval);
			p.line(xx-1,map(s[i].sval,0,255,height,0),xx,map(s[i].sval2,0,255,height,0));		
		}
		p.endDraw();
		
		
		
		if(xx>width){
			xx=0;
			p = createGraphics(width,height,P2D);
	
		}
		
		
		xx++;
	
	}
	
	


}
