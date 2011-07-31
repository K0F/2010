
Bitnum bn[];
int SEL = 0;
int num = 0;
void setup(){
	size(500,320,P2D);
	background(255);

	num = height/5;

	bn = new Bitnum[num];

	for(int i = 0 ;i<bn.length;i++){
		bn[i] = new Bitnum(10,i*5,i);
	}

	textFont(createFont("Veranda",8,false));
	textMode(SCREEN);

	noSmooth();
}


void draw(){

	background(255);

	for(int i = 0 ;i<bn.length;i++){
		bn[i].draw();// = new Bitnum(10,10,i);
	}


	SEL++;
	if(SEL>=bn.length)
		SEL=0;

	stroke(0);
	line(0,SEL*5,width,SEL*5);
}

void keyPressed(){
	
	save("folder.jpg");
}



class Bitnum{

	int x,y,id;
	boolean bits[];
	int len = 24;
	float nn[] = new float[1000];
	int maX;

	Bitnum(int _x , int _y,int _id){
		x = _x;
		y= _y;
		id = _id;
		bits = new boolean[len];

		String m = "";

		for(int i = 0;i<bits.length;i++){

			bits[i] = random(50)>45?true:false;


			m+=""+"1";
		}
		for(int i = 0;i<nn.length;i++){
			nn[i] = width;
		}

		maX = unbinary(m);
	}

	void draw(){
		stroke(100);
		for(int i = 0;i<bits.length;i++){
			if(bits[i])
				fill(0);
			else
				fill(255);
			rect(x+i*4,y,4,4);
		}

		fill(0);
		String q = "";
		for(int i = 0 ;i<len;i++)
			q+=""+(bits[i]?"1":"0");

		nn[0] = map(unbinary(q),0,maX,(len*4),width-20);//(-nn[0])/3.0;
		for(int i = 1 ;i<nn.length;i++){
			nn[i] += (nn[i-1]-nn[i])/1.4;
		}

		//text((int)nn[0],x+(5*len),y+5);

		stroke(0,15);
		for(int i = 0;i<nn.length;i++)
			line(nn[i]+(len*4),y,nn[i]+(len*4),y+4);
		//y = unbinary(q);


		if(SEL==id){
			addOthers();
			degen();
		}

		//if(frameCount%40==0)
		/*
		if(SEL==id){
		addOthers();


		if(SEL%len==0){
			degen();
	}
	}
		*/


	}

	void addOthers(){

		int i = (id+bn.length-1)%(bn.length);
		for(int q = len-1 ;q>=0;q--){

			if(bn[i].bits[(q+3)%len]==bits[q]&&bn[i].bits[(q+1)%len]==bits[q]&&bn[i].bits[(q+2)%len]!=bits[q]){
				bits[q] = !bits[q];
			}



		}

	}

	void degen(){
		int sel = (int)random(len);
		bits[sel] = !bits[sel];
	}

}
