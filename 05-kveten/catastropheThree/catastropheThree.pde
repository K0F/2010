

/*
*
*
*
*/

Mesh m[] = new Mesh[30];

void setup(){

	size(300,300,P3D);

	background(255);

	stroke(0,30);
	noFill();



	for(int i = 0;i<m.length;i++)
		m[i] = new Mesh(i,(int)random(2550));

	noSmooth();
}





void draw(){


	background(255);

	pushMatrix();

	translate(width/2,height/2,-width);
	rotateY(radians(frameCount));
	for(int i = 0;i<m.length;i++){
		m[i].compute();
		m[i].draw();
	}


	popMatrix();
}


class Mesh{
	int id,len;
	float[] x,y,z;
	float move = 50.0;
	float speed = 1.2;
	float rx,ry,rz;

	Mesh(int _id,int _len){
		id = _id;
		len = _len;

		rx = random(10000);
		ry = random(10000);
		rz = random(10000);



		x = new float[len];
		y = new float[len];
		z = new float[len];

		for(int i = 0;i<len;i++){
			x[i] = 0;
			y[i] = 0;
			z[i] = 0;
		}
	}

	void compute(){

		if(id==0){
			x[0] += (noise(rx+frameCount/10.0+id)-0.49)*move;
			y[0] += (noise(ry+frameCount/10.0+id)-0.49)*move;
			z[0] += (noise(rz+frameCount/10.0+id)-0.49)*move;



			x[0] -= x[0]/30.0;
			y[0] -= y[0]/30.0;
			z[0] -= z[0]/30.0;


		}else{
			x[0] += (m[0].x[0]-x[0])/speed;// += (noise(rx+frameCount+id)-0.49)*move;
			y[0] += (m[0].y[0]-y[0])/speed;
			z[0] += (m[0].z[0]-z[0])/speed;
			
			
			x[0] += (noise(rx+frameCount/10.0+id)-0.49)*move*10.0;
			y[0] += (noise(ry+frameCount/10.0+id)-0.49)*move*10.0;
			z[0] += (noise(rz+frameCount/10.0+id)-0.49)*move*10.0;
		}

		for(int i = 1;i<len;i++){
			
			x[i] += (x[i-1]-x[i]) / speed;
			y[i] += (y[i-1]-y[i]) / speed;
			z[i] += (z[i-1]-z[i]) / speed;
		}

	}

	void draw(){

		beginShape();
		//vertex(x[0],y[0],z[0]);

		for(int i = 1;i<len-1;i++){
			vertex(x[i],y[i],z[i]);
		}

		vertex(x[len-1],y[len-1],z[len-1]);

		endShape();


	}






}
