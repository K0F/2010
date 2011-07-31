
int num = 100;
Intel in[];

void setup(){
	size(400,300,P2D);
	background(255);
	
	in = new Intel[num];
	
	stroke(0,50);
	
	for(int i = 0;i<num;i++){
		in[i] = new Intel(20);
	}

}



void draw(){

	fill(255,15);
	rect(0,0,width,height);
	
	for(int i = 0;i<num;i++){
		in[i].draw();
	}
}

class Intel{
	float x,y;
	float speed = 11.0;
	Leg[] legs;
	int num;

	Intel(int _num){
		x = random(width);
		y = random(height);
		num = _num;

		legs = new Leg[num];
		for(int i = 0 ;i<legs.length;i++)
			legs[i] = new Leg(this,x,y,x+random(-20,20),y+random(-20,20));
	}


	void draw(){
		for(int i = 0 ;i<legs.length;i++)
			legs[i].draw();
		move();
	}

	void move(){
		for(int i = 0 ;i<legs.length;i++){
			x+=(legs[i].x2-x)/((legs.length)*speed);
			y+=(legs[i].y2-y)/((legs.length)*speed);
		}

		if(x<0)x=0;
		if(x>width)x=width;

		if(y<0)y=0;
		if(y>height)y=height;

	}

}

class Leg{
	float x1,y1,x2,y2;
	Intel parent;

	Leg(Intel _parent,float _x1,float _y1,float _x2,float _y2){
		parent=_parent;
		x1=_x1;
		x2=_x2;
		y1=_y1;
		y2=_y2;
	}



	void draw(){
		line(x1,y1,x2,y2);
		move();
	}

	void move(){
		x1 = parent.x;
		y1 = parent.y;
		x2 += random(-10,10)/10.0;
		y2 += random(-10,10)/10.0;
		

	}

}
