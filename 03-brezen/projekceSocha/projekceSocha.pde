import processing.opengl.*;

PImage shape;

int shX,shY;
int eff = 10;

ArrayList pos,fl;
int next = 0;

//ArrayList a<int>;

boolean plochy = false;

int tx,ty;

void setup(){

	size(1440-1,1050-1,OPENGL);
	frameRate(40);

	background(0);
	shape = loadImage("xift.bmp");
	//shape.filter(BLUR,5);
	shX = 1;
	shY = 55;
	strokeWeight(10);
	textFont(createFont("Veranda",20,true));
	pos = new ArrayList();
	fl = new ArrayList();
	//cursor(CROSS);
}

void draw(){

	//background(0);

	fill(0,10);
	rect(0,0,width,height);


	if(plochy){
		tint(random(255),random(255),random(255),random(50));
		image(shape,shX+random(-100,100)/10.0,shY+random(-100,100)/10.0);


		//eff = (int)random(3,50);

		for(int i =0;i<height;i+=eff){
			stroke(0,random(55));
			line(0,i,width,i);
		}
	}

	if(fl.size()>0){
		for(int i = 0;i<fl.size();i++){
			Follower tmp = (Follower)fl.get(i);
			tmp.move();
			tmp.draw();

		}


	}
	
	fill(255,50);
	text("kof",tx,ty);




}

class Follower{

	int next = 0;

	float x,y,lx,ly;
	float speed;
	boolean destroyOnEnd = false;

	Follower(boolean _a){

		destroyOnEnd = _a;
		PVector tmp = (PVector)pos.get(0);
		lx = x = tmp.x;
		ly = y = tmp.y;
		next = 1;
		speed = random(5,60);
	}




	void move(){
		lx = x;
		ly = y;

		PVector tmp = (PVector)pos.get(next);
		x+=(tmp.x-x)/speed;
		y+=(tmp.y-y)/speed;


		PVector nxt = (PVector)pos.get(next);
		if(dist(nxt.x,nxt.y,x,y)<1){
			next++;
			if(next>=pos.size()){

				if(destroyOnEnd){
					fl.remove(this);
					fl.add(new Follower(true));
				}else{
					next = 0;
				}

			}
		}


	}

	void draw(){
		pushStyle();
		strokeWeight(1);
		stroke(255);
		line(lx,ly,x,y);
		popStyle();


	}


}

void mousePressed(){

	if(mouseButton==LEFT){
	pos.add(new PVector(mouseX,mouseY));
	}else{
	tx=mouseX;
	ty=mouseY;
	}

}

void keyPressed(){

	if(keyCode==LEFT){
		shX--;

	}else if(keyCode==RIGHT){
		shX++;
	}else if(keyCode==UP){
		shY--;
	}else if(keyCode==DOWN){
		shY++;
	}else if(keyCode==ENTER){
		if(pos.size()>2){
			fl.add(new Follower(true));
		}
	}else if(keyCode==DELETE){
		fl = new ArrayList();
		pos = new ArrayList();

	}else if(keyCode==BACKSPACE){
		background(0);
	}else if(key=='v'){
	plochy =  !plochy;
	
	}

}
