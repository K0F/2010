Packer pac[];
Site sites[];

///////////////////////////////////////////////// >
int num = 300;
int precision = 4;
///////////////////////////////////////////////// >

Recorder r;
boolean rec = true;

void setup(){
	size(800,600,P2D);
	background(255);
	rectMode(CENTER);

	sites = new Site[num];
	for(int i =0;i<sites.length;i++){
		sites[i] = new Site(i);
	}

	for(int i =0;i<sites.length;i++){
		sites[i].compute();
	}

	pac = new Packer[num];
	for(int i =0;i<sites.length;i++){
		pac[i] = new Packer(sites[i]);
	}

	if(rec)
		r = new Recorder("out","voro.mp4");


}

void reset(){
	for(int i =0;i<sites.length;i++){
		sites[i].live();
	}
	
	for(int i =0;i<sites.length;i++){
		pac[i].reassign(sites[i]);
	}
}

void draw(){
	boolean fin = true;
	for(int i =0;i<pac.length;i++){
		if(!pac[i].stopthis){
			pac[i].update();
			fin = false;
		}
	}

	if(fin){
		reset();
		
		if(rec)
			r.add();
		
		fill(255,90);
		rect(width/2,height/2,width,height);
	}



}


void keyPressed(){
	if(key == 'q'){
		if(rec)
			r.finish();

		exit();
	}

}

class Packer{

	color c;
	PVector dir;
	PVector loc;
	float treshold = 200;
	Site s;
	PVector data[];
	int step = 0;
	boolean stopthis = false;

	Drawer d;


	Packer(){
		relocate();
		reset();
		d = new Drawer(this);
		smooth();
	}

	Packer(Site _s){
		c = color(random(60));
		d = new Drawer(this);
		reassign(_s);
	}

	void reassign(Site _s){
		stopthis = false;
		s = _s;
		data = new PVector[s.poradi.size()];
		for(int i = 0;i<s.poradi.size();i++){
			data[i] = new PVector(lerp((float)(Float)s.vX.get((Integer)s.poradi.get(i)),s.x,0.05),lerp((float)(Float)s.vY.get((Integer)s.poradi.get(i)),s.y,0.05));
		}

		step = 0;

		nextnode();
	}

	void nextnode(){
		loc = new PVector(data[step].x,data[step].y);
		dir = PVector.sub(new PVector(data[(step+1)%(s.poradi.size())].x,data[(step+1)%(s.poradi.size())].y),new PVector(data[step].x,data[step].y));
		dir.normalize();

		step++;

		if(step>data.length-1){
			stopthis = true;
			//reassign(sites[s.id+1]);
		}

	}

	void update(){

		if(dist(loc.x,loc.y,data[step].x,data[step].y)<=1)
			nextnode();

		loc.add(dir);

		//rotatePV(dir,0.8);

		if(loc.x>=width||loc.x<=0||loc.y>=height||loc.y<=0)
			relocate();

		d.draw(c);
	}

	void reset(){
		dir = new PVector(random(-100,100)/100.0,random(-100,100)/100.0);
		dir.normalize();
	}

	void relocate(){
		loc = new PVector(random(width),random(height));
	}

	void turnR(){
		rotatePV(dir,90);
	}

	void turn(float _an){
		rotatePV(dir,random(_an));
	}

	void turnL(){
		rotatePV(dir,90);
	}

	PVector perp(){
		PVector side = new PVector(dir.y,dir.x);
		return side;

	}

	void rotatePV(PVector what, float _deltaAngle){
		float deltaAngle = radians(_deltaAngle);
		float x = what.x;
		float y = what.y;
		what.x = (float) ( x * Math.cos( deltaAngle ) - y * Math.sin( deltaAngle ) );
		what.y = (float) ( x * Math.sin( deltaAngle ) + y * Math.cos( deltaAngle ) );
	}
}


class Drawer{

	Packer p;
	PVector up = new PVector(0,10);

	Drawer(Packer _p){
		p = _p;

	}

	void draw(color _c){
		pushMatrix();
		//PVector temp = PVector.add(p.loc, p.dir);
		//PVector d = PVector.sub(temp, p.loc);
		//PVector polar = cartesianToPolar(d);

		translate(p.loc.x,p.loc.y);
		rotate( p.dir.heading2D()+HALF_PI );


		stroke(_c,random(1,2));
		for(int i =0;i<20;i++){
			line(0,0,random(2),0);
			line(0,0,random(50),0);

		}
		popMatrix();


	}


}


