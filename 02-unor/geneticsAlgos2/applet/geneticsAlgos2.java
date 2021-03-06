import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class geneticsAlgos2 extends PApplet {

/**
*  Genome flock algorithm by Krystof Pesek alias Kof, licensed under Creative Commons Attribution-Share Alike 3.0 license.
*  Work: http://openprocessing.org/visuals/?visualID=7626
*  License: http://creativecommons.org/licenses/by-sa/3.0/
*
* visit more @ http://vimeo.com/kof
* if you leave this header, bend, share, spread the code, it is a freedom!
*
*   ,dPYb,                  ,dPYb,
*   IP'`Yb                  IP'`Yb
*   I8  8I                  I8  8I
*   I8  8bgg,               I8  8'
*   I8 dP" "8    ,ggggg,    I8 dP
*   I8d8bggP"   dP"  "Y8ggg I8dP
*   I8P' "Yb,  i8'    ,8I   I8P
*  ,d8    `Yb,,d8,   ,d8'  ,d8b,_
*  88P      Y8P"Y8888P"    PI8"8888
*                           I8 `8,
*                           I8  `8,
*                           I8   8I
*                           I8   8I
*                           I8, ,8'
*                            "Y8P'
*
*/


Bytost alfa[];
Bytost global,vzorek;
int num = 500;
boolean blurring = false;
float counter[][] = new float[8][8];
float counterG[][] = new float[8][8];


Recorder r;
boolean rec = false;

public void setup(){

	size(640,480,P3D);

	for(int Y = 0;Y<8;Y++){
		for(int X = 0;X<8;X++){
			counter[X][Y] = 0;
			counterG[X][Y] = 0;
		}
	}

	alfa = new Bytost[num];

	global = new Bytost(536,10,true);
	//vzorek = new Bytost(width-28,54,false);

	for(int i =0;i<alfa.length;i++)
		alfa[i] = new Bytost();

	//println(PFont.list());
	textFont(loadFont("NimbusSanL-Bold-10.vlw"));
        //createFont("DejaVu Sans",9));
	textMode(SCREEN);

	noCursor();

	if(rec)
		r = new Recorder("rec","genomeWar.mp4");
}


public void draw(){
	background(0);


	for(int i =0;i<alfa.length;i++){
		alfa[i].draw();


		for(int Y = 0;Y<8;Y++){
			for(int X = 0;X<8;X++){
				if( alfa[i].col[Y].dna.charAt(X) == '1')
					counterG[X][Y] += (1-counterG[X][Y])/(num+0.0f);
				else
					counterG[X][Y] -= counterG[X][Y]/(num+0.0f);
			}
		}

	}


	if(blurring)
		filter(BLUR,2);


	fill(0);
	rect(width-32-20,0,52,52);
	rect(0,0,width,20);

	for(int Y = 0;Y<8;Y++){
		for(int X = 0;X<8;X++){
			fill(counter[X][Y]*255,160);
			rect(mouseX+X*4-16,mouseY+Y*4-16,4,4);
		}

	}

	for(int Y = 0;Y<8;Y++){
		for(int X = 0;X<8;X++){
			fill(counterG[X][Y]*255,255);
			rect(width-32-10+X*4,10+Y*4,4,4);
		}

	}

	fill(255);

	text("avg. genome: ",width-180,12);


	global.draw();
	//vzorek.draw();


	if(rec)
		r.add();


}

public void mousePressed(){

	for(int i =0;i<num;i++){
		if(alfa[i].over()){
			float tmpx = alfa[i].x;
			float tmpy = alfa[i].y;
			alfa[i] = new Bytost(tmpx,tmpy);
		}
	}

}



public void keyPressed(){
	if(key == 'q'){
		if(rec)
			r.finish();

		exit();
	}
}


class Bytost{


	Genome[] col;
	float x,y,tx,ty,r,g,b,a,velikost = 0,radius = 0;
	float speed = 40;
	int kadence;
	float mmn = 30;
	float mmx = 80;
	float blink;
	boolean fixed = false;
	boolean glob = false;

	int att = 14;
	int mut = 0;

	float bizarreKoeficient,bizSUM = 0;

	boolean deviant = false;

	Bytost(){

		if(random(100)<95)
			deviant = true;

		col = new Genome[8];

		for(int i = 0 ;i<col.length;i++){
			col[i] = new Genome(8);

			//println(col[i].getDna()+" = "+unbinary(col[i].getDna()));
		}

		x = tx = map(rowInt(0),0,255,0,width);
		y = ty = map(rowInt(1),0,255,20,height);


		kadence =  (int)random(3,2000);//rowInt(3)+1;

		r = colInt(0);
		g = colInt(1);
		b = colInt(2);
		a = rowInt(6);

		blink = revdiagInt(6)/4.0f;
		//g = random(255);
		//b = random(255);
		//a = random(255);





		//col[3].setDna(120);
	}
	
	Bytost(float _x,float _y){

		if(random(100)<95)
			deviant = true;

		col = new Genome[8];

		for(int i = 0 ;i<col.length;i++){
			col[i] = new Genome(8);

			//println(col[i].getDna()+" = "+unbinary(col[i].getDna()));
		}

		x = _x;//tx = map(rowInt(0),0,255,0,width);
		y = _y; // = map(rowInt(1),0,255,20,height);


		kadence =  (int)random(3,2000);//rowInt(3)+1;

		r = colInt(0);
		g = colInt(1);
		b = colInt(2);
		a = rowInt(6);

		blink = revdiagInt(6)/4.0f;
		//g = random(255);
		//b = random(255);
		//a = random(255);





		//col[3].setDna(120);
	}

	Bytost(float _x,float _y,boolean _glob){
		fixed = true;
		glob=_glob;

		col = new Genome[8];


		for(int i = 0 ;i<col.length;i++){
			col[i] = new Genome(8);

			//println(col[i].getDna()+" = "+unbinary(col[i].getDna()));
		}

		if(!fixed){
			x = tx = map(rowInt(0),0,255,0,width);
			y = ty = map(rowInt(1),0,255,0,height);
		}else{
			x=tx=_x;
			y=ty=_y;
		}

		kadence =  (int)random(3,20);//rowInt(3)+1;

		r = colInt(0);
		g = colInt(1);
		b = colInt(2);
		a = rowInt(6);

		blink = revdiagInt(6)/4.0f;
		//g = random(255);
		//b = random(255);
		//a = random(255);





		//col[3].setDna(120);
	}

	public void compute(){

		//for(int i = 0 ;i<col.length;i++){


		//}


		if(!fixed){
			tx = map(rowInt(0)^revdiagInt(6),0,255,0,width);
			ty = map(rowInt(2)^diagInt(7),0,255,0,height);
		}

		speed += ((diagInt(3)^revdiagInt(3))*3.0f-speed)/40.0f;

		kadence = (int)((colInt(4)^diagInt(6))*3.0f+3);

		speed = constrain(speed,30,255);
		kadence = constrain(kadence,1,255);


		if(!fixed){
			x += (tx-x)/speed;
			y += (ty-y)/speed;
		}

		r += ((diagInt(2))-r)/speed;
		g += ((diagInt(3))-g)/speed;
		b += ((diagInt(4))-b)/speed;
		a += ((rowInt(6))-a)/speed;

		//att = revdiagInt(7)&diagInt(0);

		velikost += (rowInt(5)-velikost)/speed;

		radius += ((diagInt(5)^revdiagInt(4)^revdiagInt(3))-radius)/speed;

		blink += (diagInt(6)-blink)/speed;


		if(!fixed){
			bizarreKoeficient = 0;

			for(int i =0;i<col.length;i++){
				for(int q =0;q<col[i].dna.length();q++){
					float myGen = (float)parseInt(col[i].dna.charAt(q)+"");
					bizarreKoeficient += (abs(myGen-counterG[q][i])-bizarreKoeficient)/(num+0.0f);
				}
			}


			//if(frameCount%(kadence/4.0)==0){
			for(int i = 0;i<att;i++)
				income(1,mut);
			//}





		}else if(glob){

			for(int i =0;i<col.length;i++){

				int tmp[] = new int[col.length];

				for(int q =0;q<col[i].dna.length();q++){
					if(counterG[q][i]>0.5f){
						tmp[q] = 1;
					}else{
						tmp[q] = 0;
					}


				}
				col[i].setDna(tmp);

			}
		}else{
			for(int i =0;i<col.length;i++){

				int tmp[] = new int[col.length];

				for(int q =0;q<col[i].dna.length();q++){
					if(counter[q][i]>0.5f){
						tmp[q] = 1;
					}else{
						tmp[q] = 0;
					}


				}
				col[i].setDna(tmp);

			}

		}



		//attract((int)(colInt(4)/10.0),diagInt(4));
		//detract((int)((colInt(6)^revdiagInt(1))/10.0),(diagInt(6)^colInt(5)));

		//detract(2,200.0);


	}

	public void income(int jakMoc,int degenerace){


		Bytost next = alfa[(int)random(alfa.length)];


		/*
		bizSUM = bizarreKoeficient;
		//prefer others genes
		for(int i =0;i<col.length;i++){
			for(int q =0;q<col[i].dna.length();q++){
				float myGen = (float)parseInt(col[i].dna.charAt(q)+"");
				float nextGene = (float)parseInt(next.col[i].dna.charAt(q)+"");
				bizSUM += abs(nextGene-myGen);
			}
	}




		if(!deviant){
		*/
		//gene of dominance .. majority
		//	if(bizarreKoeficient<next.bizarreKoeficient){


		if(dist(x,y,next.x,next.y)<map(radius,0,255,mmn,mmx)){


			if(!fixed){

				if(frameCount%kadence==0){

					//deviant=!deviant;


					next.col[(int)random(col.length)].degen(1);
					next.col[(int)random(col.length)].degen(3);
					next.col[(int)random(col.length)].degen(5);


				}
			}

			for(int i = 0;i<jakMoc;i++){
				int wh = (int)random(col.length);
				col[wh].dna = next.col[wh].dna+"";
				//if(i==0)

			}

			for(int i = 0;i<degenerace;i++){
				col[(int)random(col.length)].degen(1);
			}

		}
		//	}

		/*
	}else{
		//gene of dominance .. minority
		if(bizarreKoeficient<next.bizarreKoeficient){
			if(dist(x,y,next.x,next.y)<map(radius,0,255,mmn,mmx)){
				for(int i = 0;i<jakMoc;i++){
					int wh = (int)random(col.length);
					col[wh].dna = next.col[wh].dna+"";
					//if(i==0)

				}

				for(int i = 0;i<degenerace;i++){
					col[(int)random(col.length)].degen(1);
				}

			}
	}

	}
		*/


	}


	public void draw(){

		compute();

		noStroke();
		//fill(lerpColor(color(r,g,b),0xFFFFFFFF,(sin(frameCount/blink)+1)/2.0),a);
		stroke(r,g,b,constrain(a/12.0f+((sin(frameCount/(blink*.1f))+1)*40.0f),0,255));
		noFill();
		//ellipse(x,y,map(radius,0,255,16,20),map(radius,0,255,16,20));

		//ellipse(x,y,map(radius,0,255,16,30),map(radius,0,255,16,30));

		ellipse(x,y,map(radius,0,255,16,40),map(radius,0,255,16,40));
		//rect(x-8,y-8,16,16);

		noStroke();
		//drawText();
		drawHex();

	}

	public boolean over(){

		if((dist(mouseX,mouseY,x,y)<map(radius,0,255,16,190))&&!fixed){
			for(int Y = 0;Y<8;Y++){
				for(int X = 0;X<8;X++){
					if( col[Y].dna.charAt(X) == '1')
						counter[X][Y] += (1-counter[X][Y])/(40.0f);
					else
						counter[X][Y] += (-counter[X][Y])/(40.0f);
				}
			}
			return true;
		}else{
			return false;
		}


	}

	public void attract(int kolik,float jakMoc){

		for(int i = 0;i<kolik;i++){
			Bytost next = alfa[(int)random(alfa.length)];
			if(dist(x,y,next.x,next.y)<map(radius,0,255,mmn,mmx)){
				x+=(next.x-x)/jakMoc;
				y+=(next.y-y)/jakMoc;
			}
		}

	}

	public void detract(int kolik,float jakMoc){

		for(int i = 0;i<kolik;i++){
			Bytost next = alfa[(int)random(alfa.length)];
			if(dist(x,y,next.x,next.y)<map(radius,0,255,mmn,mmx)){
				tx-=(next.x-tx)/jakMoc;
				ty-=(next.y-ty)/jakMoc;
			}
		}

	}


	public void drawText(){
		fill(255,120);

		for(int i = 0 ;i<col.length;i++){
			text(col[i].dna,x+7,y+2+i*9);
		}

	}

	public void drawHex(){
		if(over())
			fill(255);
		else
			fill(r,g,b,120);
		//fill(0);
		pushMatrix();
		translate(x-4,y-4);
		for(int Y = 0 ;Y<col.length;Y++){
			for(int X = 0 ;X<col.length;X++){
				if(col[Y].dna.charAt(X) == '1')
					rect(X,Y,1,1);
			}
		}
		popMatrix();

	}

	public String row(int which){

		String a = "";
		for(int i =0;i<col.length;i++){
			a += col[i].dna.charAt(which)+"";

		}

		return a;

	}

	public int rowInt(int which){

		String a = "";
		for(int i =0;i<col.length;i++){
			a += col[i].dna.charAt(which)+"";

		}

		return unbinary(a);

	}

	public int colInt(int which){

		return unbinary(col[which].dna);

	}

	public int diagInt(int which){

		String a = "";

		a += col[0].dna.charAt(which)+"";
		a += col[1].dna.charAt((which+1)%col[0].dna.length())+"";
		a += col[2].dna.charAt((which+2)%col[0].dna.length())+"";
		a += col[3].dna.charAt((which+3)%col[0].dna.length())+"";

		a += col[4].dna.charAt((which+4)%col[0].dna.length())+"";
		a += col[5].dna.charAt((which+5)%col[0].dna.length())+"";
		a += col[6].dna.charAt((which+6)%col[0].dna.length())+"";
		a += col[7].dna.charAt((which+7)%col[0].dna.length())+"";

		return unbinary(a);

	}

	public int revdiagInt(int which){

		String a = "";

		a += col[0].dna.charAt(which)+"";
		a += col[1].dna.charAt((which-1+col[0].dna.length())%col[0].dna.length())+"";
		a += col[2].dna.charAt((which-2+col[0].dna.length())%col[0].dna.length())+"";
		a += col[3].dna.charAt((which-3+col[0].dna.length())%col[0].dna.length())+"";

		a += col[4].dna.charAt((which-4+col[0].dna.length())%col[0].dna.length())+"";
		a += col[5].dna.charAt((which-5+col[0].dna.length())%col[0].dna.length())+"";
		a += col[6].dna.charAt((which-6+col[0].dna.length())%col[0].dna.length())+"";
		a += col[7].dna.charAt((which-7+col[0].dna.length())%col[0].dna.length())+"";

		return unbinary(a);

	}


}

class Genome{
	String dna;
	int mn,mx;

	Genome(int strict){
		dna = "";

		regen(strict);
	}

	Genome(int _mn, int _mx){
		dna = "";

		mn = _mn;
		mx = _mx;

		regen();
	}





	public void regen(){
		generateDna((int)random(mn,mx));
	}

	public void regen(int _in){
		generateDna(_in);
	}

	public void degen(int kolik){


		for(int i = 0;i<kolik;i++){

			int which = (int)random(dna.length());
			String stremp = "";

			if(dna.charAt(which)=='1'){
				stremp = dna+"";
				dna = stremp.substring(0,which)+"0"+stremp.substring(which+1,stremp.length());

			}else{

				stremp = dna+"";
				dna = stremp.substring(0,which)+"1"+stremp.substring(which+1,stremp.length());
			}

		}
		//println(dna+" = "+unbinary(dna));


	}




	public int[] decode(){
		String temp = getDna();
		int[] answ = new int[temp.length()];

		for(int i =0;i<answ.length;i++){
			answ[i] = parseInt(temp.charAt(i));
		}
		return answ;
	}

	public int getInt(){
		return unbinary(dna);

	}

	public String encode(int[] in){
		String temp = "";

		for(int i =0;i<in.length;i++){
			temp += in[i]+"";
		}
		return temp;
	}

	public void generateDna(int in){
		for(int i =0;i<in;i++)
		if(random(50) <= 25){ dna+="0"; }else{ dna+="1"; }
	}

	public String getDna(){
		return dna;
	}

	public void setDna(String a){
		dna = "";
		dna = a;
	}


	public void setDna(int[] a){
		String tmp = "";

		for (int i = 0 ;i<a.length;i++){
			tmp += a[i]+"";
		}

		dna = tmp+"";
	}
}


class Recorder{
  String dir,name;
  int cntr = 0;

	
  Recorder(String _dir,String _name){
    dir = _dir;
    name= _name;
    //btrt = _btrt;
  }

  public void add(){
    save(dir+"/screen"+nf(cntr,4)+".png");
    cntr++;
  }

  public void finish(){
    String Path = sketchPath+"/"+dir;
    try{     
      String bitrate="8000k";//+(((int)(50*25*width*height)/256)*2);
      Runtime.getRuntime().exec("xterm -e png2vid "+Path+" "+name+" "+width+"x"+height+" "+bitrate);
      println("finishing");
    }
    catch(java.io.IOException e){
      println(e); 
    }  
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "geneticsAlgos2" });
  }
}
