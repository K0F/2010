

float rate = 1000;

void setup(){
	size(400,300);
	
	frameRate(rate);
	
	println(PFont.list());

	textFont(createFont("Rachana",11));
//	textMode(SCREEN);

}



void draw(){

	background(0);
	fill(255);
	stroke(255);
	
	
	float rr = map(frameRate,0,rate,0,width);
	text(frameRate,rr,20);
	line(rr,0,rr,height);
	



}
