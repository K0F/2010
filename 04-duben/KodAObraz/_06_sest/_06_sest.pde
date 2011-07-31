float tras = 2.0;
PGraphics frame;
PImage tup,trees;
float valx = 0.0,valy = 45.23;

boolean rec = false;

void setup(){
	size(320,240,P2D);
	fill(0);
	frameRate(20);
	noStroke();

	tup = loadImage("tu.png");	
	trees = loadImage("trees.png");
	

	loadPixels();

	frame = createGraphics(width+20,height+20,P2D);
	frame.beginDraw();

	frame.stroke(0,120);
	frame.noFill();
	frame.strokeWeight(20);

	frame.stroke(0,40);
	frame.rect(0,0,width,height);
	frame.filter(BLUR,10);

	frame.stroke(0,120);
	frame.rect(0,0,width,height);
	frame.filter(BLUR,2);

	frame.endDraw();

	noSmooth();
	
}

void draw(){
	background(255);
	pre();
	prod();
	post();
}

void prod(){
	stroke(0,50);
	fill(0,10);

	tint(#fdee9d);
	image(tup,random(-10,10)/10.0+noise(frameCount/100.0)*80,noise(frameCount/1000.0)*180+noise(frameCount/100.0)*12.0,tup.width/2,tup.height/2);
	noTint();
	
	image(trees,((frameCount*40)%(trees.width*2))-trees.width,height/2-50);
	image(trees,((frameCount*40)%(trees.width*3))-trees.width*2,height/2-50);
	image(trees,((frameCount*40)%(trees.width))-trees.width*2,height/2-50);
	image(trees,((frameCount*40)%(trees.width*3))-trees.width,height/2-50);
	
}

void pre(){

	beginShape(QUADS);
	fill(20+noise(frameCount/4.0)*50);
	vertex(0,0);
	vertex(width,0);
	fill(#a8d8ff);
	vertex(width,height);
	vertex(0,height);
	endShape(CLOSE);

	float modx = noise(valx++)*tras-tras/2.0;
	float mody = noise(valy++)*tras-tras/2.0;
	pushMatrix();
	translate(modx,mody);
	translate(-random(2),-random(2));
}

void post(){

	translate(random(2),random(2));
	for(int i =0;i<3;i++){
		stroke(0,25);
		line(width/2+noise(frameCount/200.0+i)*160+noise(frameCount/10.0+i)*6,0,width/2+noise(frameCount/200.0+i)*160+noise(frameCount/10.0+i)*6,height);
	}
	
	popMatrix();

	image(frame,-random(2),-random(2));
	for(int i =0;i<pixels.length;i++){
		float glitch = random(-85,3);
		pixels[i] = color(red(pixels[i])+glitch,green(pixels[i])+glitch,blue(pixels[i])+glitch);
	}
		filter(ERODE);
	filter(BLUR,random(1,2));
	
	
}
