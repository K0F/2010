

int num = 10; 
Kruzidlo k[];

void setup(){

	size(800,600,P2D);
	
	k = new Kruzidlo[num];

	
	for(int i = 0 ;i<k.length;i++){
		k[i] = new Kruzidlo();
	}
	
	background(255);
	stroke(0,60);
}



void draw(){

	
	
	for(int i = 0 ;i<k.length;i++){
		k[i].compute();
	}
	
	
	for(int i = 0 ;i<k.length;i++){
		k[i].draw();
	}


}

class Kruzidlo{

	float lx,ly,x,y,pol,speed;
	int id;
	
	Kruzidlo(){
		lx = x = random(width);
		ly = y = random(height);
		pol = 1.1;
		speed = random(1,255);
	}
	
	void compute(){
		lx = x;
		ly = y;
		
		x += cos(frameCount/speed+0.321)*pol;
		y += sin(frameCount/speed)*pol;
		
		pol = noise(frameCount/30.0)*10;
		
		
	}
	
	void draw(){
		line(x,y,lx,ly);
	
	}
	


}
