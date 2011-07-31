
ArrayList a;
int alp = 500;
int maxCyc = 100000;

int W = 128;
int H = 96;

import codeanticode.gsvideo.*;

GSPipeline cam;
Recorder r;

boolean rec = false;

PGraphics mmsk;

void setup(){
	size(720,576,P2D);

	a = new ArrayList(0);


	frameRate(25);



	//println(PFont.list());
	textFont(loadFont("Fruc-8.vlw"),8);
	textMode(SCREEN);

	mmsk = createGraphics(W,H,P2D);
	mmsk.beginDraw();
	mmsk.background(0);
	mmsk.fill(255);
	mmsk.noStroke();
	mmsk.ellipse(mmsk.width/2.0,mmsk.height/2.0,H-40,H-40);
	mmsk.filter(BLUR,4);
	mmsk.endDraw();

	//videofilp method=2
	String webcam = "v4l2src ! queue2 ! ffvideoscale ! "+"video/x-raw-rgb,width="+W+",height="+H;
	cam = new GSPipeline(this, webcam);

	if(rec)
		r= new Recorder("okoNeuro","jineSvety.mp4");

	background(0);
}

void draw(){

	//background(0);
	fill(0,5);
	noStroke();
	rect(0,0,width,height);

	for(int i = 0;i < (int)random(maxCyc);i++)
		a.add(new Snake(random(4,333),width/2,height/2,a.size()));

	for(int i = 0;i<a.size();i++){
		Snake tmp = (Snake)a.get(i);
		//tmp.modX(screenX(tmp.x,tmp.y),200.0);
		//tmp.modY(screenY(tmp.x,tmp.y),200.0);
		tmp.move(12);
		//println(i);
	}


	/*pushMatrix();

	translate(width/2, height/2);
	rotate(frameCount*6*TWO_PI/360.0);
	translate(-width/2, -height/2);
	*/

	for(int i = 0;i<a.size();i++){
		Snake tmp = (Snake)a.get(i);
		//tmp.modX(screenX(tmp.x,tmp.y),200.0);
		//tmp.modY(screenY(tmp.x,tmp.y),200.0);
		//tmp.move(12);
		tmp.draw();
		//println(i);
	}


	fill(0);
	noStroke();
	rect(0,0,width,18);
	fill(255);
	text(a.size(),10,14);

	/*
	popMatrix();
	*/


	if (cam.available() == true){
		cam.read();
		cam.filter(GRAY);
		cam.mask(mmsk);
		image(cam, (int)(width/2.0-W/2.0)+random(-1,1) , (int)(height/2.0-H/2.0)+random(-1,1) );
		//neuroFeed();
	}

	if(rec)
		r.add();

}

void keyPressed(){
	if(key == 'q'){
		if(rec)
			r.finish();
		exit();

	}

}



public class Morpher{

	public float x,y,xx,yy,lx,ly;
	int id;
	int type;
	int bttl,ttl = 160;
	float zivo;

	public Morpher(int _type){
		this.type = _type;
		x = random(width);
		y = random(height);


	}

	public Morpher(float _zivo,float _x, float _y,int _type,int _id){
		type = _type;
		lx = xx = x = _x;
		ly = yy = y = _y;
		id = _id;
		bttl = ttl = (int)random(255);
		zivo = _zivo;
	}

	void draw(){
		stroke(lerpColor(#FFFFFF,#FFFFFF,norm(zivo,333,0)),map(ttl,0,bttl,0,128));
		noFill();

		line(lx,ly,x,y);



	}

	void move(float howMuch){

		lx = x;
		ly = y;

		xx+= random(-howMuch,howMuch);

		yy+= random(-howMuch,howMuch);

		xx = constrain(xx,3,width-3);
		yy = constrain(yy,3,height-3);



		x+=(xx-x)/zivo;
		y+=(yy-y)/zivo;


		//float smer = atan2(ly-y,lx-x);
		//x+=cos(smer*ttl*TWO_PI/360.0)*5;
		//y+=sin(smer*ttl*TWO_PI/360.0)*5;

		ttl--;

		if(ttl<=0)
			destroy();
	}

	void destroy(){

		int q = a.indexOf(this);
		a.remove(q);
	}

	void modX(float _x,float sp){
		xx+=(_x-x)/sp;

	}


	void modY(float _y,float sp){
		yy+=(_y-y)/sp;

	}




}


public class Snake extends Morpher{

	public Snake(){
		super(0);
	}

	public Snake(float _zivo, float _x,float _y,int _id){
		super(_zivo,_x,_y,0,_id);
	}

}
