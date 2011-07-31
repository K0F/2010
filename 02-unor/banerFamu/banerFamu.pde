PImage a;
PGraphics ram;
String txt = "CAS / Centrum audiovizuálních studií";

PFont Font1,Font2;

Recorder r;
boolean rec = true;

void setup(){
	size(268,97,P2D);
	frameRate(30);
	background(0);
	println(PFont.list());

	Font1 = createFont("DejaVu Sans Mono Bold",10);
	Font2 = createFont("DejaVu Sans Mono Bold",32);

	textMode(SCREEN);
	background(#FFaa00);

	ram = createGraphics(width+20,height+20,P2D);
	ram.beginDraw();
	ram.stroke(0);
	ram.strokeWeight(30);
	ram.noFill();
	ram.rect(0,0,width+20,height+20);
	ram.filter(BLUR,5);

	ram.endDraw();
	
	
	if(rec)
	r = new Recorder("out","banner.mp4");

}


void draw(){
	background(lerpColor(#aaaaaa,#000000,random(40,60)/100.0) );

	
/*	
	drawSign(15,(int)random(65,67),(int)random(77,79),#000000);
	filter(BLUR,random(1,3));

	
	fill(0,150);
	int res = (int)random(2,6);
	kosticka(0,0,width,height,res,res);

	fill(255,150);
	res = (int)random(2,6);
	kosticka(0,0,width,height,res,res);

	fill(#FF1100,150);
	res = (int)random(2,6);
	kosticka(0,0,width,height,res,res);
	
	fill(0,150);
	res = (int)random(2,6);
	kosticka(0,0,width,height,res,res);

	fill(255,150);
	res = (int)random(2,6);
	kosticka(0,0,width,height,res,res);

	fill(#FF1100,150);
	res = (int)random(2,6);
	kosticka(0,0,width,height,res,res);

	//drawSign(15,(int)random(55,57),(int)random(75,77));

	filter(BLUR,random(1,2));
*/
	
	

	//drawSign();

	fill(255,50);
	kosticka((int)random(-30,0),(int)random(-30,0),width*2,height*2,(int)random(2,6),(int)random(2,30));

	kosticka((int)random(-30,0),(int)random(-30,0),width*2,height*2,(int)random(2,6),(int)random(2,30));

	kosticka((int)random(-30,0),(int)random(-30,0),width*2,height*2,(int)random(2,6),(int)random(2,30));
	
	noiser(60,80);
	drawSign(15,(int)random(63,65),(int)random(75,77),#ffffff);
	image(ram,-10+random(-2,2),-10+random(-2,2));
	
	if(rec)
		r.add();




}

void drawSign(float _x,int y1, int y2,color c){

	for(int i = 0;i<txt.length();i++){


		for(int q = 0;q<height;q++){


			if(i<4){

				fill(c,random(1,3));
				textFont(Font2);

				if(q==y1){
					fill(c,random(100,130));
					text(txt.charAt(i),10+i*18+_x,q);

				}else{

					text(txt.charAt(i),10+i*18+random(-2,2)+_x,q);
				}
			}else{

				fill(c,random(1,3));
				textFont(Font1);

				if(q==y2){
					fill(c,random(80,150));
					text(txt.charAt(i),10+i*7-30+_x,q);
				}else{
					text(txt.charAt(i),10+i*7-30+random(-2,2)+_x,q);
				}
			}
		}
	}



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

