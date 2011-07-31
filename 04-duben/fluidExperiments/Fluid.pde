/*
float res =8;

class Fluid{

	Cell cell[][];

	Fluid(){
		cell = new Cell[(int)(width/res)][(int)(height/res)];

		for(int i =0;i<cell.length;i++){
			for(int ii =0;ii<cell[i].length;ii++){
				cell[i][ii] = new Cell(i,ii);
			}
		}

	}

	void calc(){
		for(int i =0;i<cell.length;i++){
			for(int ii =0;ii<cell[i].length;ii++){
				cell[i][ii].calc();
			}
		}

	}


	void draw(){
		for(int i =0;i<cell.length;i++){
			for(int ii =0;ii<cell[i].length;ii++){
				cell[i][ii].draw();
			}
		}


	}




}

class Cell{


	float x,y;
	float pressure;
	PVector low,high;
	int id;

	Cell(int _x,int _y){
		//parent = _parent;

		x = _x;
		y = _y;

		id = (int)(y*height+x);

		pressure = random(0.9,1.1);
		low = new PVector(0,0);
		high = new PVector(0,0);
		//println("cell no. "+id+" created");
	}



	void calc(){

		int counter = 0;
		int index1[] = new int[0];
		int index2[] = new int[0];
		for(int i =0;i<fl.cell.length;i++){
			for(int ii =0;ii<fl.cell[i].length;ii++){
				if(dist(fl.cell[i][ii].x,fl.cell[i][ii].y,x,y)<rad){
					index1 = (int[])append(index1,i);
					index2 = (int[])append(index2,ii);
					counter++;
				}
			}

		}


		float prss = 0.0;
		high = new PVector(0,0);
		low = new PVector(0,0);
		for(int i =0;i<index1.length;i++){

			Cell tmp = fl.cell[index1[i]][index2[i]];
			prss += tmp.pressure;

			if(tmp.pressure>pressure){
				high.add((tmp.x-x),(tmp.y-y),0);
			}else{
				low.add((tmp.x-x),(tmp.y-y),0);
			}

		}

		low.normalize();
		high.normalize();
		pressure += (prss-pressure)/30.0;

		x += (low.x-x)/20.0;
		y += (low.y-y)/20.0;

		x -= (high.x-x)/20.0;
		y -= (high.y-y)/20.0;

	}

	void draw(){

		stroke(0,150);
		line(x*res,y*res,x*res+1,y*res);

	}

}*/
