PGraphics tmp,frame;

float valx = 0.0,valy = 45.23;
float tras = 2.0;

Recorder r;
boolean rec = true;

void setup(){

	size(640,240,P2D);

	tmp = createGraphics(width,height,P2D);
	tmp.loadPixels();
	tmp.beginDraw();
	
	for(int y = 0;y<height;y++){
		for(int x = 0;x<width;x++){
			tmp.pixels[y*width+x] = color(random(255));
		}
	}

	tmp.endDraw();

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

	background(tmp);
	loadPixels();

	if(rec)
		r = new Recorder("out","turning.mp4");

}



void draw(){

	pre();

	//tint(255,50);
	image(tmp,random(-2,3),random(-2,3));
	noTint();

	float approx = 0.5;
	for(int y = 0;y<height;y++){
		for(int x = 0;x<width;x++){
			tmp.pixels[y*width+x] = color(pixels[y*width+x]);
			approx += map(brightness(pixels[y*width+x]),0,255,0,1);
		}
	}


	if(frameCount%50==0){
		tmp.beginDraw();
		for(int y = 0;y<height;y++){
			for(int x = 0;x<width;x++){
				tmp.pixels[y*width+x] = color(random(255));
			}

		}
		tmp.endDraw();
	}

	approx /= (width*height);

	//if(frameCount%10==0)
	tmp.filter(BLUR,2);

	//if(frameCount%20==0)
	tmp.filter(THRESHOLD,approx);

	if(frameCount%2==0)
		filter(INVERT);
	
	post();

	if(rec)
		r.add();


}

void pre(){

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
	filter(BLUR,3);
	
	//resetMatrix();
	image(frame,-random(2),-random(2));
	
	for(int i =0;i<pixels.length;i++)
		pixels[i] = color(brightness(pixels[i])+random(-30,3));

}

void keyPressed(){

	if(key == 'q'){
		if(rec)
			r.finish();

		exit();
	}

}
