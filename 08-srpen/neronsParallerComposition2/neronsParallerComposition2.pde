
Neuron n[];
Signal s[];

boolean render = true;

float sx,sy;

void setup(){

	size(800,480,P2D);

	n = new Neuron[3000];

	for(int i = 0;i<n.length;i++)
		n[i] = new Neuron(i,random(-width,width*2),random(-height,height*2));


	for(int i = 0;i<n.length;i++)
		n[i].makeSynapse();

	rectMode(CENTER);


	n[0].makeSignal(0);
	n[1].makeSignal(0);
	n[2].makeSignal(0);
	
	background(0);
	sx = sy = 0;

	textFont(createFont("Veranda",9,false));
	textMode(SCREEN);
}


void draw(){
	//background(255);

	fill(0,80);
	rect(width/2,height/2,width,height);
	
	
	
	
	pushMatrix();

	translate(width/2.5+(sx-width/2)*0.1,height/2.5+(sy-height/2)*0.1);
	scale(0.2);
	
	
	int cnt = 0;
	for(int i = 0;i<n.length;i++){
		for(int q = 0;q<n[i].sig.length;q++){
			if(n[i].sig[q].running){
				cnt ++;
				sx -= (n[i].sig[q].x+sx)/(n.length*5);
				sy -= (n[i].sig[q].y+sy)/(n.length*5);
			}
		}
	}
	
	
	for(int i = 0;i<n.length;i++)
		n[i].draw();

	
	popMatrix();
	
	if (render){
		saveFrame("out/neuro####.png");
		println(frameCount);
	}
	
	pushStyle();
	fill(0);
	noStroke();
	rect(40,20,80,40);
	fill(255);
	text(cnt,20,10);
	popStyle();

}

class  Neuron{
	int id;
	float x,y,val;
	float radius = 150.0;

	Synapse s[];
	Signal sig[];

	Neuron(int _id,float _x,float _y){
		id=_id;
		x=_x;
		y=_y;
	}

	void makeSynapse(){
		s = new Synapse[0];
		sig = new Signal[0];

		for(int i = 0;i<n.length;i++){
			if(i!=id && dist(x,y,n[i].x,n[i].y)<=radius&&noise(i/100.0)<0.6){
				s = (Synapse[])expand(s,s.length+1);
				s[s.length-1] = new Synapse(id,i);

				sig = (Signal[])expand(sig,sig.length+1);
				sig[sig.length-1] = new Signal(s[s.length-1]);

			}
		}
	}



	void makeSignal(int which){
		int i = which;
		sig[i].x = x;
		sig[i].y = y;
		sig[i].running = true;
	}




	void drawSynapse(){


		if(sig.length>0){
			for(int i = 0;i<sig.length;i+=1){
				if(sig[i].running){
					pushStyle();
					stroke(255,90);
					noFill();
					rect(sig[i].x,sig[i].y,1,1);
					popStyle();
					sig[i].step();
				}
			}
		}


		stroke(#ffcc11,3);
		for(int i = 0;i<s.length;i+=1){
			line(n[s[i].B].x,n[s[i].B].y,x,y);
		}




	}

	void draw(){
		drawSynapse();
		//move();
	}

	void move(){
		x+=(noise(id+frameCount/10.0)-.5);
		y+=(noise(id*5+frameCount/10.0)-.5);
	}

}

class Synapse{

	float weight = 1.5;
	int A,B;

	Synapse(int _A, int _B){

		A=_A;
		B=_B;

		weight = random(1001,1100)/300.0;

	}

}

class Signal{

	Synapse base;
	int cyc = 0;
	float x,y;
	float speed = 1.1;

	boolean running = false;
	boolean visible = true;

	int deadnum = 50;
	int deadcount = 0;

	Signal(Synapse _base){
		base = _base;
		x = n[base.A].x;
		y = n[base.A].y;
		speed *= base.weight;
	}

	void step(){
		running = true;

		x += (n[base.B].x-x) / speed;//(speed+(dist(n[base.A].x,n[base.A].y,n[base.B].x,n[base.B].y)+1)/100.0);
		y += (n[base.B].y-y) / speed;//(speed+(dist(n[base.A].x,n[base.A].y,n[base.B].x,n[base.B].y)+1)/100.0);



		if(dist(x,y,n[base.B].x,n[base.B].y)<1.0){

			if(deadcount<0){
				deadcount = deadnum;

				//deadnum += (int)random(-1,1);
				//println("run "+base.A+" : "+base.B);

				running = false;
				for(int i = 0; i < n[base.B].s.length;i++){
					if(!n[base.B].sig[i].running){
						n[base.B].makeSignal(i);
						n[base.B].sig[i].base.weight += (base.weight-n[base.B].sig[i].base.weight)/((dist(x,y,n[base.A].x,n[base.A].y)+1.0)/2.0);
					}

				}

				//base.weight = random(1001,3000) / 1000.0;

				x=n[base.A].x;
				y=n[base.A].y;


			}else{
				deadcount--;


			}
		}
	}
}




