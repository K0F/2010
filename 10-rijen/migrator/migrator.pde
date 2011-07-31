
int num = 8000;

float GLOB = 1.0;
Migra m[];

int xs[],ys[];
int len = 77;

void setup(){
	size(800,300,P2D);
	background(0);


	xs = new int[len];
	ys = new int[len];

	for(int i = 0;i<xs.length;i++){
		float a = random(100);
		if(a<25){
			xs[i]=1;
		}else if(a<50){
			xs[i]=-2;
		}else if(a<75){
			ys[i]=1;

		}else{
			ys[i]=-1;
		}
		
	}

	m = new Migra[num];

	for(int i = 0;i<m.length;i++)
		m[i] = new Migra(width/3*2,(int)map(i,0,m.length,0,height));


	loadPixels();
}




void draw(){

	//background(0);

	//loadPixels();
	

	tint(23,2,0,noise(frameCount/10.0)*25);
	image(g,-1,random(-1,1));//xs[frameCount%xs.length],ys[frameCount%ys.length]);

	for(int i = 0;i<m.length;i++){	
		m[i].compute();
		m[i].draw();
	}


pushMatrix();
	translate(random(-5,5),random(-5,5));


	pushStyle();

	for(int i = 0;i<5000;i++){
	stroke(random(255),18);
	strokeWeight(random(1.25,2));
	point(random(width),random(height));
	}

	popStyle();

popMatrix();


pushMatrix();

	pushStyle();
        noFill();
        stroke(0,180);
        strokeWeight(10);
        rect(0,0,width,height);

	popStyle();
popMatrix();

}

class Migra{
	
	int x,y;
	int tlak;
	float speed = 30.0;

	Migra(int _x,int _y){
		x = _x;
		y = _y;
		tlak = 255;//(int)random(255);
		speed = GLOB;//.01387263;
		GLOB+=0.124314;
	}


	void compute(){


		if(x>width)x=0;
                if(x<0)x=width;
		if(y>height)y=0;
                if(y<0)y=height;

		int brigh = 1;//(int)(brightness(pixels[constrain(y*width+x,0,pixels.length-1)]))+1;

		if(noise(frameCount/speed) > 0.75){
			x+=brigh;
		}else if(noise(frameCount/speed) > .5){
			x-=brigh;
		}else if(noise(frameCount/speed) > .25){
			y+=brigh;
                }else{
			y-=brigh;
                }




	}

	void draw(){
		stroke(255,90);
		point(x,y);
		
	}


}
