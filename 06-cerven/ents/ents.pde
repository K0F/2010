
PGraphics p;

void setup(){
	size(800,800,P2D);
	background(0);
	
	p = createGraphics(width,height,P2D);
}


void draw(){
	p.beginDraw();
	p.pushMatrix();
	p.translate(width/2,height/2.0);
	
	p.pushMatrix();
	p.rotate(radians(frameCount));
	p.stroke(255,25);
	p.line(cos(frameCount/100.0)*width/2.0,noise(frameCount/10.0)*400,cos(frameCount/100.0)*width/2.0,-40);
	p.popMatrix();

	p.popMatrix();
	p.endDraw();
	
	pushMatrix();
	translate(width/2,height/2.0);
	scale(sin(frameCount/300.0));
	pushMatrix();
	rotate(radians(-frameCount));
	image(p,-p.width/2,-p.height/2.0);
	
	popMatrix();
	popMatrix();
}
