

PImage logo;


Recorder r;
boolean rec = true;

void setup(){
	
	logo = loadImage("logo.gif");
	size(logo.width,logo.height,P2D);
	
	frameRate(30);
	
	
	if(rec)
	r = new Recorder("out","banner.mp4");



}


void draw(){
	image(logo,0,0);

	noStroke();
	fill(255);
	for(int i = 0;i<width;i+=(int)random(1,5)){
		rect(i,height-5,random(1,2),5);
	}
	
	for(int i = 0;i<width;i+=(int)random(1,5)){
		rect(i,0,random(1,2),65);
	}

	fill(255);
	int res = (int)random(2,6);
	kosticka(0,0,width,height,res,res);
	
		if(rec)
		r.add();

}


void kosticka(int _x,int _y,int w,int h,int rx,int ry){

	noStroke();
	for(int x  = 0;x<w;x+=rx){
		for(int y  = 0;y<h;y+=ry){
			if(random(255)>128)
				rect(_x+x*rx,_y+y*ry,rx,ry);
		}
	}


}

void noiser(int mn,int mx){

for(int x = 0;x<width;x++){

		for(int y = 0;y<height;y++){
			stroke(0,random(mn,mx));
			point(x,y);
		}
	}

}

