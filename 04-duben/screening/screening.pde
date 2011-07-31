

Agent a;

void setup(){

	size(1280,720,P2D);


	hint(DISABLE_OPENGL_2X_SMOOTH);
	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);

	background(255);
	stroke(0,15);

	a = new Agent();
}



int h = 0;
float val = 0;

void draw(){

	//background(255);
	a.draw();

}

class Agent{

	float x,y,x2,y2;


	Agent(){
		x = 0;
		y = 0;
		update();



	}

	void update(){

		if(frameCount%5==0){
			x2 = x;
			y2 = y;
		}
		x = mouseX;
		y = mouseY;


	}


	void draw(){

		update();

		float dd = dist(mouseX,mouseY,width/2,height/2);


		if(abs(x-x2)>0.1&&abs(y-y2)>0.1)
			val = atan2(y-y2,x-x2);// ((atan2(y-y2,x-x2)+TWO_PI)-val)/30.0;

		pushMatrix();
		translate(x,y);


		//pushMatrix();

		rotate(val-TWO_PI);


		//line(0,dd,0,);
		line(0,-50,0,50);

		//line(-width,0,width,0);

		//popMatrix();

		popMatrix();

	}



}
