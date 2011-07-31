
Bytost alfa[];
int num = 500;
boolean blurring = false;
float counter[][] = new float[8][8];
float counterG[][] = new float[8][8];


void setup(){

	size(640,480,P2D);

	for(int Y = 0;Y<8;Y++){
		for(int X = 0;X<8;X++){
			counter[X][Y] = 0;
		}
	}

	alfa = new Bytost[num];

	for(int i =0;i<alfa.length;i++)
		alfa[i] = new Bytost();

	//println(PFont.list());
	textFont(createFont("DejaVu Sans",9));
	textMode(SCREEN);
}


void draw(){
	background(0);


	for(int i =0;i<alfa.length;i++){
		alfa[i].draw();
		
		
	for(int Y = 0;Y<8;Y++){
				for(int X = 0;X<8;X++){
					if( alfa[i].col[Y].dna.charAt(X) == '1')
						counterG[X][Y] += (1-counterG[X][Y])/(100.0);
					else
						counterG[X][Y] += (-counterG[X][Y])/(100.0);
				}
			}
		
	}


	if(blurring)
		filter(BLUR,2);

	for(int Y = 0;Y<8;Y++){
		for(int X = 0;X<8;X++){
			fill(counter[X][Y]*255,120);
			rect(mouseX+X*8,mouseY+Y*8,8,8);
		}

	}
	
	
	for(int Y = 0;Y<8;Y++){
				for(int X = 0;X<8;X++){
					if( col[Y].dna.charAt(X) == '1')
						counter[X][Y] += (1-counter[X][Y])/(100.0);
					else
						counter[X][Y] += (-counter[X][Y])/(100.0);
				}
			}

}


/*
void keyPressed(){
	if(key == 'q'){
		alfa.col[0].degen(1);
	}else if(key == 'w'){
		alfa.col[1].degen(1);
	}else if(key == 'e'){
		alfa.col[2].degen(1);
	}else if(key == 'r'){
		alfa.col[3].degen(1);
	}


}*/


class Bytost{


	Genome[] col;
	float x,y,tx,ty,r,g,b,a,velikost = 0,radius = 0;
	float speed = 40;
	int kadence;
	float mmn = 25;
	float mmx = 150;
	float blink;

	Bytost(){
		col = new Genome[8];

		for(int i = 0 ;i<col.length;i++){
			col[i] = new Genome(8);

			//println(col[i].getDna()+" = "+unbinary(col[i].getDna()));
		}

		x = tx = map(rowInt(0),0,255,0,width);
		y = ty = map(rowInt(1),0,255,0,height);


		kadence =  (int)random(20,200);//rowInt(3)+1;

		r = colInt(0);
		g = colInt(1);
		b = colInt(2);
		a = rowInt(6);

		blink = revdiagInt(6)/4.0;
		//g = random(255);
		//b = random(255);
		//a = random(255);





		//col[3].setDna(120);
	}

	void compute(){

		//for(int i = 0 ;i<col.length;i++){
		if(frameCount%kadence==0){
			col[(int)random(col.length)].degen(1);
			col[(int)random(col.length)].degen(1);
			col[(int)random(col.length)].degen(1);

		}
		//}

		tx = map(rowInt(0),0,255,0,width);
		ty = map(rowInt(1),0,255,0,height);

		speed += (diagInt(7)*2-speed)/40.0;

		//kadence = (int)(rowInt(4)/3.0+30+random(-5,5));

		speed = constrain(speed,30,255);
		kadence = constrain(kadence,1,255);



		x += (tx-x)/speed;
		y += (ty-y)/speed;


		r += (diagInt(2)-r)/speed;
		g += (diagInt(3)-g)/speed;
		b += (diagInt(4)-b)/speed;
		a += (rowInt(6)-a)/speed;

		velikost += (rowInt(5)-velikost)/speed;

		radius += (revdiagInt(4)-radius)/speed;

		blink += (diagInt(6)-blink)/speed;

		for(int i = 0;i<15;i++)
			income(1,0);

		//attract((int)(colInt(4)/10.0),diagInt(4));
		//detract((int)(colInt(6)/10.0),diagInt(6));

		//detract(2,200.0);


	}

	void income(int jakMoc,int degenerace){


		Bytost next = alfa[(int)random(alfa.length)];
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


	void draw(){

		compute();

		noStroke();
		//fill(lerpColor(color(r,g,b),0xFFFFFFFF,(sin(frameCount/blink)+1)/2.0),a);
		stroke(r,g,b,constrain(a/12.0+((sin(frameCount/(blink*.1))+1)*40.0),0,255));
		noFill();
		//ellipse(x,y,map(radius,0,255,16,20),map(radius,0,255,16,20));

		//ellipse(x,y,map(radius,0,255,16,30),map(radius,0,255,16,30));

		ellipse(x,y,map(radius,0,255,16,40),map(radius,0,255,16,40));
		//rect(x-8,y-8,16,16);

		noStroke();
		//drawText();
		drawHex();

	}

	boolean over(){

		if(dist(mouseX,mouseY,x,y)<map(radius,0,255,16,190)){
			for(int Y = 0;Y<8;Y++){
				for(int X = 0;X<8;X++){
					if( col[Y].dna.charAt(X) == '1')
						counter[X][Y] += (1-counter[X][Y])/(100.0);
					else
						counter[X][Y] += (-counter[X][Y])/(100.0);
				}
			}
			return true;
		}else{
			return false;
		}


	}

	void attract(int kolik,float jakMoc){

		for(int i = 0;i<kolik;i++){
			Bytost next = alfa[(int)random(alfa.length)];
			if(dist(x,y,next.x,next.y)<map(radius,0,255,mmn,mmx)){
				x+=(next.x-x)/jakMoc;
				y+=(next.y-y)/jakMoc;
			}
		}

	}

	void detract(int kolik,float jakMoc){

		for(int i = 0;i<kolik;i++){
			Bytost next = alfa[(int)random(alfa.length)];
			if(dist(x,y,next.x,next.y)<map(radius,0,255,mmn,mmx)){
				x-=(next.x-x)/jakMoc;
				y-=(next.y-y)/jakMoc;
			}
		}

	}


	void drawText(){
		fill(255,120);

		for(int i = 0 ;i<col.length;i++){
			text(col[i].dna,x+7,y+2+i*9);
		}

	}

	void drawHex(){
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

	String row(int which){

		String a = "";
		for(int i =0;i<col.length;i++){
			a += col[i].dna.charAt(which)+"";

		}

		return a;

	}

	int rowInt(int which){

		String a = "";
		for(int i =0;i<col.length;i++){
			a += col[i].dna.charAt(which)+"";

		}

		return unbinary(a);

	}

	int colInt(int which){

		return unbinary(col[which].dna);

	}

	int diagInt(int which){

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

	int revdiagInt(int which){

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





	void regen(){
		generateDna((int)random(mn,mx));
	}

	void regen(int _in){
		generateDna(_in);
	}

	void degen(int kolik){


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




	int[] decode(){
		String temp = getDna();
		int[] answ = new int[temp.length()];

		for(int i =0;i<answ.length;i++){
			answ[i] = parseInt(temp.charAt(i));
		}
		return answ;
	}

	int getInt(){
		return unbinary(dna);

	}

	String encode(int[] in){
		String temp = "";

		for(int i =0;i<in.length;i++){
			temp += in[i]+"";
		}
		return temp;
	}

	void generateDna(int in){
		for(int i =0;i<in;i++)
		if(random(50) <= 25){ dna+="0"; }else{ dna+="1"; }
	}

	String getDna(){
		return dna;
	}

	void setDna(String a){
		dna = "";
		dna = a;
	}


	void setDna(int a){

		dna = binary(a)+"";
	}
}


