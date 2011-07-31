Recorder r;
boolean rec = true;

int al = 250;
float val = 0;

int s = 200;
int v = 120;

void setup(){
	size(320,240,P2D);
	frameRate(25);
	noStroke();

	if(rec)
		r = new Recorder("out","strobo.mp4");
	
	colorMode(HSB);
}

void draw(){
	
	if(frameCount % 128 == 0){
		v+=33;//random(255);
		v=v%255;		
	}
	
	if(frameCount % ((int)(sin(frameCount/30.0)+2)*3) == 0){
		
	val = random(255);
		fill(255-v,s,255-val,al);
		rect(0,0,width,height);
		fill(v,s,val);
	}else{

		fill(v,s,val,al);
		rect(0,0,width,height);
		fill(255-v,s,255-val);
	}

	rect(40+random(-100,100)*0.02,40+random(-100,100)*0.02,width-80,height-80);

	filter(BLUR,1);
	
	for(int y = 0 ; y < height ; y++){
		for(int x = 0 ; x < width ; x++){
			stroke(0,random(40));
			point(x,y);

		}
	}
	noStroke();

	

	if(rec)
		r.add();

}

void keyPressed(){
	if(key =='q'){
		if(rec)
			r.finish();
		exit();
	}
}
