
int b = 50;

void setup(){
	size(800,480);
	rectMode(CENTER);
	noStroke();
	fill(255,120);
	
	//println(PFont.list());
	
	textFont(createFont("Sawasdee Bold",32,true));
	textAlign(CENTER);
	background(0);
	loadPixels();
}


void draw(){
	background(0);
	
	
	
	translate(noise(frameCount/10.0)*3,noise(2*frameCount/10.0)*3);
	rect(width/2,height/2-b,b,b);
	
	
	
	translate(noise(frameCount/10.0)*3,noise(2*frameCount/10.0)*3);
	rect(width/2+b,height/2,b,b);
	
	
	
	
	
	translate(noise(frameCount/10.0)*3,noise(2*frameCount/10.0)*3);
	rect(width/2+b,height/2+b,b,b);

	
	translate(noise(frameCount/10.0)*3,noise(2*frameCount/10.0)*3);
	rect(width/2,height/2+b,b,b);
	
	
	translate(noise(frameCount/10.0)*3,noise(2*frameCount/10.0)*3);
	rect(width/2-b,height/2+b,b,b);
	
	
	translate(noise(frameCount/10.0)*3,noise(2*frameCount/10.0)*3);
	text("hello world!",width/2,height/2+2.5*b);
	
	//saveFrame("anim/anim#####.png");

}
