
PImage src;
PImage cak[] = new PImage[10];

color c[] = new color[16];


void setup(){
	size(1024,768,P2D);
	
	src = loadImage("one.gif");
	src.loadPixels();
	
	
	for(int i = 0 ;i < c.length;i++)
		c[i] = src.pixels[(int)random(src.pixels.length)];
			
	for(int i = 0 ;i < 10;i++)
		cak[i] = loadImage(i+".png");
			
			
			noStroke();
			
			background(0);
	

}



void draw(){
	tint(c[(int)random(c.length)],135);
	
	float x = 10,y;
	for(int i = 0 ; i < (int)random(5,50);i++){
		pushMatrix();
		
		x = random(width);
		y = random(height);
		translate(x,y);
		rotate(random(-PI,PI));
		float scale = random(0.25,2);
		int id = (int)random(10);
		image(cak[id],0,0,scale*cak[id].width,scale*cak[id].height);
		popMatrix();
	}
	//rect(random(width),random(height),random(-width,width),random(-height,height));
	
	fill(0,12);
	ellipse(width/2,height/2,x,x);


}