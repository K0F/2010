import geomerative.*;

RShape C;
RPoint pC[];
RShape polyshp;


PImage metroCbck;
int h,m,s;
boolean ignoringStyles = true;
	

ArrayList soupravy;


void setup(){
	size(1200,800,P2D);
	metroCbck = loadImage("c.png");

	h = m = s = 0;
	//geomerative.RGeomerative.init(this);
	geomerative.RG.init(this);
	geomerative.RG.ignoreStyles(ignoringStyles);

	C = geomerative.RG.loadShape("C.svg");
	polyshp = geomerative.RG.polygonize(C);
	pC = C.getPoints();


	soupravy = new ArrayList();
	soupravy.add(new Souprava(pC,soupravy.size()));
	 

	println(pC[0]);

	textFont(createFont("Sans",20));
	strokeWeight(3);
	rectMode(CENTER);

}

void mousePressed(){
	soupravy.add(new Souprava(pC,soupravy.size()));
}

void draw(){

	background(0);
	
	pushMatrix();
	
	translate(400,100);

	image(metroCbck,0,0);

	noFill();
	stroke(255,0,0,120);

	pushStyle();
	noStroke();
	fill(255);
	
	for(int i = 0;i<soupravy.size();i++){
		Souprava tmp = (Souprava)soupravy.get(i);
		tmp.tick();
	
		tmp.draw();
	}
	
	popStyle();
	
	

	//for(int i = 0;i<pC.length;i++)
	//rect(pC[i].x,pC[i].y,5,5);

	//C.draw();
	//C.centerIn(g, 1, 1, 1);
	//C.scale(0.98); //scales the map
	//C.translate(0, 0); //center the map

	popMatrix();


	fill(255);
	text(h+":"+nf(m,2)+":"+nf(s,2),width - 100,20);


	
	tick(10);



}


void tick(int speed){
	s += speed;
	if(s>=60){
		s = 0;
		m++;
	}

	if(m>=60){
		m = 0;
		h++;
	}

	if(h>=24){
		h = 0;
	}
}

class Souprava{
	float x,y,tx,ty;
	int cntr = 1;
	RPoint[] body;
	float speed = 3.0;
	float delta;
	int id;

	Souprava(RPoint[] _body,int _id){
		id = _id;
		body = _body;
		gotoStart();
	}

	void gotoStart(){
		cntr = 1;
		x = body[0].x;
		y = body[0].y;
		tx = body[1].x;
		ty = body[1].y;

	}

	void tick(){

		x+=(tx-x)/speed;
		y+=(ty-y)/speed;

		delta += (atan2(ty-y,tx-x)-delta)/speed;
		if(abs(delta-atan2(ty-y,tx-x))>1.5){
		delta = atan2(ty-y,tx-x);
		}
		
		if(dist(tx,ty,x,y)<=0.5){

			tx = body[cntr].x;
			ty = body[cntr].y;

			cntr++;

			if(cntr>=body.length-1){
				//gotoStart();
				destroy();
			}

		}
		
		

	}

	void draw(){
		pushMatrix();
		translate(x+3,y);
		
		text(id,5,5);
		rotate(delta);
		rect(0,0,10,5);
		
		popMatrix();


	}
	
	void destroy(){
	soupravy.remove(this);
	
	}

}
