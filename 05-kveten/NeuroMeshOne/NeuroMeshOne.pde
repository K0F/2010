

int CONN = 3;
NeuroMesh nm;
float prum = 1;

void setup(){

	size(320,240,P2D);
	nm = new NeuroMesh(width*height);

	rectMode(CENTER);



}

void draw(){

	background(127);


	nm.draw();


}

void mousePressed(){
	nm.resetV();
}



class NeuroMesh{

	Node[] n;
	int len;

	NeuroMesh(int _len){
		len = _len;
		n = new Node[len];

		int X = 0;
		int Y = 0;

		for(int i =0 ;i<len;i++){
			n[i] = new Node(X,Y,i,this);
			X++;
			if(X>=width){
				X=0;
				Y++;
			}
		}

		for(int i =0 ;i<len;i++){
			n[i].createConnections();
		}

	}

	void draw(){

		for(int i =0 ;i<n.length;i++){
			n[i].compute();
			
			if(dist(mouseX,mouseY,n[i].x,n[i].y)<sin(frameCount/5.0)*200.0)
				n[i].setW(0.1);

		}

		for(int i =0 ;i<n.length;i++){
			n[i].draw();

		}

	}

	void resetV(){

		for(int i =0 ;i<n.length;i++){
			n[i].resetVal();
		}
	}
	
	
}

class Teacher{

	NeuroMesh mesh;

	Teacher(NeuroMesh _mesh){
		mesh = _mesh;

	}



}

class Node{

	float x,y;

	float val;
	int id;
	NeuroMesh parent;

	Connection c[];

	Node(float _x,float _y,int _id, NeuroMesh _parent){
		id = _id;
		x = _x;
		y = _y;
		parent = _parent;


		val = random(0,255);

	}

	void createConnections(){
		c = new Connection[0];

		for(int i =0;i<(int)random(1,CONN);i++){
			int q = id;
			while(q==id){
				q = (int)random(parent.len);
			}
			c = (Connection[])append(c,new Connection(this,parent.n[q]));

		}


	}

	void resetVal(){

		val = random(0,255);
	}

	void compute(){
		for(int i =0;i<c.length;i++){
			c[i].stochaist(0.4);
			val += ((c[i].b.val*c[i].w) - val) / c[i].speed;
		}

		prum += (val-prum)/(width*height+0.0);
	}

	void draw(){


		for(int i =0;i<c.length;i++){
			//noStroke();
			stroke(val);
			point(x,y);

			//	stroke(c[i].w*255,50);
			//line(parent.n[c[i].id2].x,parent.n[c[i].id2].y,x,y);

		}

	}
	
	void setVal(float _tmp){
		val = _tmp;
	}
	
	void setW(float _tmp){
		for(int i = 0 ;i<c.length;i++)
		c[i].w = _tmp;
	}
}

class Connection{
	float w;
	Node a,b;
	float speed;

	Connection(Node _a, Node _b){
		a = _a;
		b = _b;
		//println(id2);
		
		speed = constrain(dist(a.x,a.y,b.x,b.y)/12.0,2,width*2);//random(2,100);
		w = random(0,100)/50.0;
	}

	void stochaist(float va){
		w += random(-va,va);
		w = constrain(w,0.1,map(prum,0,255,3,0.2));
	}
}
