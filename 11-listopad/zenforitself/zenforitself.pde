import processing.opengl.*;

ArrayList d;
int ID = 0;

int [][] change;

void setup(){
	size(800,600,OPENGL);

	change = new int[width][height];

	for(int y = 0; y < height; y++){
		for(int x = 0; x < width; x++){
			int q = 0;//(int)random(11);			
			change[x][y] = q;
		}
	}

	
	d = new ArrayList(0);

	for(int i = 0 ; i< 5000;i++)
	d.add(new Dupliciter((int)random(width-1),(int)random(height-1)));


}



void draw(){

noStroke();
fill(0,50);
rect(0,0,width,height);

	for(int i = 0;i<d.size();i++){
		Dupliciter tmp = (Dupliciter)d.get(i);
		if(tmp.ignore){

		change[constrain(tmp.cx,0,width-1)][constrain(tmp.cy,0,height-1)] = (int)(random(100));
		}else{

		switch(change[tmp.cx][tmp.cy]){
				case 0:
				tmp.x = -1;
				tmp.y = -1;
				break;
  				case 1:
                                tmp.x = 0;
                                tmp.y = -1;
                                break;
  				case 2:
                                tmp.x = 1;
                                tmp.y = -1;
                                break;
  				case 3:
                                tmp.x = -1;
                                tmp.y = 0;
                                break;
  				case 4:
                                tmp.x = 1;
                                tmp.y = 0;
                                break;
  				case 5:
                                tmp.x = -1;
                                tmp.y = 1;
                                break;
 				case 6:
                                tmp.x = 0;
                                tmp.y = 1;
                                break;
				case 7:
                                tmp.x = 1;
                                tmp.y = 1;
                                break;
 				case 9:
				tmp.cloneit();
                                break;
  				case 10:
                                tmp.deleteit();
                                break;

		}
		tmp.ignore = true;
		tmp.life = 0;
}
		tmp.draw();
	}
}

class Dupliciter{

	int x,y,cx,cy;
	int id;
	boolean ignore = true;
	int timer,life = 0;

	Dupliciter(){
		cx = width / 2;
		cy = height / 2;
		id = ID++;
		timer = (int)random(30);
	}

	 Dupliciter(int _x,int _y){
                cx = _x;
                cy = _y;
                id = ID++;
		timer = (int)random(30);

        }


	void move(){
		life ++;

		if(life>timer){
			ignore = false;
		}

		cx+=x;
		cy+=y;
		
		if(cx>=width)cx=0;
		if(cx<0)cx=width-1;

		if(cy>=height)cy=0;
		if(cy<0)cy=height-1;

	}
	
	void draw(){
		move();
		pushStyle();
		strokeWeight(2);
		stroke(255,100);
		point(cx,cy);
		popStyle();
	}

	void cloneit(){
		d.add(new Dupliciter(cx+1,cy));

	}
	
	void deleteit(){
                d.remove(this);

        }

}
