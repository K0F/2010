import processing.opengl.*;

ArrayList body = new ArrayList(0);
ArrayList cestovatele = new ArrayList(0);

int ID = 0;

void setup(){
	size(640,420,OPENGL);
	
	background(0);	
	

}


void draw(){
//	noStroke();
//	fill(0,15);
//	rect(0,0,width,height);


background(0);	

	for(int i  = 0; i< cestovatele.size();i++){
		Cestovatel tmp = (Cestovatel)cestovatele.get(i);	
		tmp.move();
		tmp.draw();
	}
	
	cursor(CROSS);


}

class Cestovatel{
	float x,y,lx,ly;
	float nx,ny;
	int idm,target;
	float speed = 10.0;

	Cestovatel(){
		Bod tmp = (Bod)body.get(0);
		nx = x = tmp.x;
		ny = y = tmp.y;
	}

	void skip(){
		target++;
		if(target>=body.size()){

			target = 0;
			Bod tmp = (Bod)body.get(target);
			nx = x = tmp.x;
			ny = y = tmp.y;
			
			
		
		}	
		
		Bod tmp = (Bod)body.get(target);
		nx = tmp.x;
		ny = tmp.y;

	}

	void move(){

		lx=x;
		ly=y;

		x += (nx-x) / speed;
		y += (ny-y) / speed;

		if(dist(nx,ny,x,y)<1){
			skip();
		}

	}


	void draw(){
		fill(255,100);
		//strokeWeight(3);
		rect(x,y,5,5);

	}


}

class Bod{
	float x,y;
	int id;

	Bod(float _x,float _y,int _id){
		x = _x;
		y = _y;
		id = _id;
	}
}


void mousePressed(){
	body.add(new Bod(mouseX,mouseY,ID++));

}

void keyPressed(){
	if (key == ' ' && body.size() > 0){
		cestovatele.add(new Cestovatel());
	}else if(key == ' '){
		println("zadne body nebyly definovany");

	}


}
