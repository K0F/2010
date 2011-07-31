import gifAnimation.*;
import processing.opengl.*;

Postava p;
//Postava2 p2;

int skalovani = 2;

/////////////////////////////////////
String globName = "stallman";
boolean render = true;
/////////////////////////////////////


color trans=color(85,255,255);
PImage bck;

void setup() {

	size(320*skalovani,240*skalovani);
	frameRate(25);

	noSmooth();
	hint(DISABLE_OPENGL_2X_SMOOTH);


	reload();
	//imageMode(CENTER);

	textFont(createFont("FreeSans",9,false));
	textMode(SCREEN);

}
void reload(){
	bck = loadImage("cube_01.jpg");
	p = new Postava(this,globName, width/2-35 , height/2-64);
	//p2 = new Postava2(this,globName, width /2-128 , height/2-128);
}

void draw() {

	scale(skalovani);
	//image(bck,0,0);
	background(trans);
	//image(bck,0,0);
	
	//p2.draw();
	p.draw();
	if(render)
		saveFrame(p.name+"/"+p.name+"###.png");



}



void keyPressed(){
	if(key==' '){
		reload();
	}else if(key == 'q'){
		String params = "xterm -e 'cd "+sketchPath+" && tar zcvf "+globName+".tar.gz "+globName+"'";
		println(params);
		try{
			Runtime.getRuntime().exec(params);//(params);
		}catch(Exception e){
			println(e);
		}

		exit();
	}else if(keyCode==LEFT){
		p.wL=true;
	}else if(keyCode==RIGHT){
		p.wR=true;
	}else if(keyCode==DOWN){
		p.wD=true;
	}else if(keyCode==UP){
		p.wU=true;
	}

}

void keyReleased(){
	p.wL = p.wR = p.wU = p.wD = false;

}


class Postava{
	PImage walkL[],walkR[],walkU[],walkD[];
	PImage still;
	int x,y;
	String name;
	PApplet parent;
	PGraphics msk;

	boolean walking = false;
	boolean oneFrame = false;
	boolean wL,wR,wD,wU;


	int faze = 0;

	Postava(PApplet _parent, String _name,int _x, int _y){
		parent = _parent;
		name = ""+_name;
		walkL = Gif.getPImages(parent, name+"WalkL.gif");//new Gif(parent, name+"WalkL.gif");
		walkR = Gif.getPImages(parent, name+"WalkR.gif");
		walkU = Gif.getPImages(parent, name+"WalkU.gif");
		walkD = Gif.getPImages(parent, name+"WalkD.gif");

		msk = createGraphics(walkR[0].width,walkR[0].height,JAVA2D);
		//= Gif.getPImages(this, "lavalamp.gif");

		x =  _x;//width/2-walkL[0].width;//width/2;
		y = _y;//height-200;

		still = walkR[0];
		applyMask();
	}

	void applyMask(){

		if(walkL!=null)
			for(int i =0;i<walkL.length;i++){
				walkL[i].loadPixels();
				msk.loadPixels();
				//println(walkL[0].pixels[10]);
				for(int q = 0;q<msk.width*msk.height;q++){
					if(walkL[i].pixels[q]==trans)
						msk.pixels[q] = color(0);
					else
						msk.pixels[q] = color(255);
				}
				walkL[i].mask(msk);
			}

		if(walkR!=null)
			for(int i =0;i<walkR.length;i++){
				walkR[i].loadPixels();
				msk.loadPixels();
				//println(walkR[0].pixels[10]);
				for(int q = 0;q<msk.width*msk.height;q++){
					if(walkR[i].pixels[q]==trans)
						msk.pixels[q] = color(0);
					else
						msk.pixels[q] = color(255);
				}
				walkR[i].mask(msk);
			}
		if(walkD!=null)
			for(int i =0;i<walkD.length;i++){
				walkD[i].loadPixels();
				msk.loadPixels();
				//println(walkD[0].pixels[10]);
				for(int q = 0;q<msk.width*msk.height;q++){
					if(walkD[i].pixels[q]==trans)
						msk.pixels[q] = color(0);
					else
						msk.pixels[q] = color(255);
				}
				walkD[i].mask(msk);
			}

		if(walkU!=null)
			for(int i =0;i<walkU.length;i++){
				walkU[i].loadPixels();
				msk.loadPixels();
				//println(walkU[0].pixels[10]);
				for(int q = 0;q<msk.width*msk.height;q++){
					if(walkU[i].pixels[q]==trans)
						msk.pixels[q] = color(0);
					else
						msk.pixels[q] = color(255);
				}
				walkU[i].mask(msk);
			}
	}

	void walkLeft(){

	//	x-=2;

		if(x<-walkL[0].width)x=width;
		image(walkL[faze],x/skalovani,y/skalovani,walkL[faze].width*skalovani,walkL[faze].height*skalovani);
		still = walkL[faze];
		if(frameCount%2==0)faze++;
		if(faze>=walkL.length)faze = 0;
	}

	void walkDown(){
	//	y+=2;


		if(y>height)y=-walkD[0].height;
		image(walkD[faze],x/skalovani,y/skalovani,walkD[faze].width*skalovani,walkD[faze].height*skalovani);
		still = walkD[faze];
		if(frameCount%2==0)faze++;
		if(faze>=walkD.length)faze = 0;
	}

	void walkRight(){
	//	x+=2;


		if(x>width)x=-walkR[0].width;
		image(walkR[faze],x/skalovani,y/skalovani,walkR[faze].width*skalovani,walkR[faze].height*skalovani);
		still = walkR[faze];
		if(frameCount%2==0)faze++;
		if(faze>=walkR.length)faze = 0;
	}

	void walkUp(){
	//	y-=2;
		if(y<-walkU[0].height)y=0;
		image(walkU[faze],x/skalovani,y/skalovani,walkU[faze].width*skalovani,walkU[faze].height*skalovani);
		still = walkU[faze];
		if(frameCount%2==0)faze++;
		if(faze>=walkU.length)faze = 0;

	}

	void draw(){
		if(!wR&&!wL&&!wU&&!wD){
			image(still,x/skalovani,y/skalovani,walkR[faze].width*skalovani,walkR[faze].height*skalovani);
			faze = 0;
		}

		if(wR)
			walkRight();

		if(wL)
			walkLeft();

		if(wD)
			walkDown();

		if(wU)
			walkUp();



	}
}


class Postava2{

	int x,y;
	String name;
	PApplet parent;
	PGraphics msk;
	PImage anim[];
	int faze = 0;

	Postava2(PApplet _parent, String _name,int _x, int _y){
		parent = _parent;
		name = ""+_name;
		anim = Gif.getPImages(parent, name+".gif");

		msk = createGraphics(anim[0].width,anim[0].height,JAVA2D);

		x = _x;
		y = _y;

		for(int i =0;i<anim.length;i++){
			anim[i].loadPixels();
			msk.loadPixels();
			//println(walkR[0].pixels[10]);
			for(int q = 0;q<msk.width*msk.height;q++){
				if(anim[i].pixels[q]==trans)
					msk.pixels[q] = color(0);
				else
					msk.pixels[q] = color(255);
			}
			anim[i].mask(msk);
		}

	}


	void draw(){

		image(anim[faze],x/skalovani,y/skalovani,anim[faze].width*skalovani,anim[faze].height*skalovani);
		//still = anim[faze];
		if(frameCount%3==0)faze++;
		if(faze>=anim.length)faze = 0;

	}


}
