import processing.opengl.*;


Bot bot[];
PImage art;

//Recorder r;
boolean rec  = false;


int num = 50;
int pass[];
color c[];
int intv[];

void setup(){

	size(1024,480,OPENGL);
	art = loadImage("psi.png");


	bot = new Bot[num];
	for(int i = 0;i<bot.length;i++){
		bot[i] = new Bot(i);
	}


	pass =new int[num];
	intv =new int[num];
	c = new color[num];
	for(int i = 0;i<num;i++){
		c[i] = color(random(255),random(123),random(100));
		intv[i] = (int)random(3,300);
		pass[i] = 0;

	}

  noSmooth();

//	if(rec)
//		r = new Recorder("out","smrst.mp4");

}


void draw(){

	background(0);


	for(int i = 0;i<num;i++){
		if(frameCount%intv[i]==0)
			pass[i]+=1;

		if(pass[i]>bot.length)
			pass[i]=0;

	}



	pushMatrix();
	translate(width/2-art.width/2,height/2-art.height/2);
	for(int i = 0;i<bot.length;i++){
		for(int q = 0;q<num;q++){
			noTint();
			if(i==pass[q]){
				tint(c[q]);
				break;
			}

		}

		bot[i].draw();

	}

	popMatrix();

	pushStyle();
	noStroke();
	fill(0);
	rect(0,0,width,10);

	rect(0,0,10,height);

	rect(width,height,-width,-10);

	rect(width,height,-10,-height);

	popStyle();


//	if(rec)
//		r.add();


}

void keyPressed(){
	if(key=='q'){
//		if(rec)
//			r.finish();
		exit();

	}

}

class Bot{

	float x,y;
	float sca,speed;
	float al,shiftX,shiftY;
	float Z;

	Bot(float _scl){
		Z = _scl;
		x = width/2.0;
		y = height/2.0;
		sca = map(_scl,0,bot.length,0.001,1);// random(0.001,1);
		speed = random(500,2550)*((random(50)>25)?-1:1);
		al = 255;// random(60,240);
		shiftX = random(-512,512);
		shiftY = random(-512,512);

	}


	void draw(){
		//tint(255,al);
		pushMatrix();
		//translate(x,y);
		pushMatrix();
		translate(art.width/2+shiftX,art.height/2);
		rotate(frameCount/speed);
		scale(sca);
		//background(123);
		image(art,-art.width/2+shiftX,-art.height/2+shiftY);
		popMatrix();

		popMatrix();


	}
}
