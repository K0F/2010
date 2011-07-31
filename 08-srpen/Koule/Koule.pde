import peasy.*;

PeasyCam cam;



Rez o[] = new Rez[200];

void setup(){

	size(800,480,P3D);
	noStroke();
	fill(0,30);

	noSmooth();

	for(int i = 0;i<o.length;i++)
		o[i] = new Rez(i);

	cam = new PeasyCam(this, 400);
	cam.setMinimumDistance(500);
	cam.setMaximumDistance(2000);

}



void draw(){


	background(255);
	/*pushStyle();
	fill(255);
	strokeWeight(20);
	rect(0,0,width,height);
	popStyle();
	*/



	noFill();

	for(int i = 0;i<o.length;i++){

		o[i].draw();
	}


	pushStyle();
	noFill();

	for(int i = 0;i<o[0].q;i++){
		beginShape();
		for(int n = 0;n<o.length;n++){
			stroke(0,(sin(i/o.length)+1)*30);
			vertex(o[n].xs[i],o[n].ys[i],o[n].zs[i]);
		}
		endShape();
	}
	popStyle();




}


class Rez{
	float x,y,r;
	float step = 0.3;
	int id;
	float xs[],ys[],zs[];
	int q = 0;

	Rez(int _id){
		id = _id;
		x = width/2;
		y = height/2;
		r = 40;


		for(float f = -PI;f < PI;f+=step)
			q++;

		xs = new float[q];
		ys = new float[q];
		zs = new float[q];
	}

	void draw(){
		
		r  = noise((frameCount+id)/100.33)*120+noise((frameCount+id)/1000.43)*21+4;
		beginShape();
		int i = 0;
		for(float f = -PI;f < PI;f+=step){
			xs[i] = cos(f)*r*2*noise(cos(f/2.0)+id/10.0+frameCount/20.0)+(noise((id+frameCount)/101.0)-0.5)*500;
			ys[i] = sin(f)*r*2*noise(sin(f/2.0)+id/10.0+frameCount/20.1)+(noise((id+frameCount)/111.0)-0.5)*500;
			zs[i] = id*5-((o.length/2)*5);

			stroke(0,(sin(f)+1)*70);
			vertex(xs[i],ys[i],zs[i]);
			i++;
		}
		endShape(CLOSE);
	}
}
