
int sel =0;
Container c[] = new Container[0];
CN cn[] = new CN[0];

void setup(){
	size(640,480,P2D);

	textFont(createFont("Veranda",9));
	textMode(SCREEN);
	background(255);
}

void draw(){

	background(255);

	for(int i = 0;i<c.length;i++){
		c[i].draw();
	}

	
	for(int i = 0;i<cn.length;i++){
		cn[i].draw();
	}

}

void mousePressed(){
	boolean someOver = false;
	int ID = 0;
	for(int i = 0;i<c.length;i++){
		someOver = c[i].over();
		if(someOver){
			ID=i;
			break;

		}
	}

	if(someOver){
		c[ID].tx = c[ID].x-mouseX;
		c[ID].ty = c[ID].y-mouseY;
		c[ID].startDrag();

	}
}

void keyPressed(){
	if(key=='1'){
		c = (Container[])append(c,new Container(mouseX,mouseY,c.length,""));
	}else if(key<='a'&&key<='z'){
		if(c[sel].opened)
		c[sel].addText(key));
	}


}

void mouseReleased(){
	for(int i = 0;i<c.length;i++){
		c[i].stopDrag();
	}
}


class CN{
	int a = 0;
	int b = 0;

	CN(int _a){
		a = _a;
	}

	void draw(){
		stroke(0);
		line(c[a].x,c[b].x,c[a].y,c[b].y);
	}
}


class Container{
	int x,y;
	int tx,ty;
	int id;
	int w;
	String name;
	boolean dragging = false;
	In in[];
	Out out[];


	Container(int _x, int _y,int _id,String _name){
		x=_x;
		y=_y;
		id=_id;
		name=_name;
		w = name.length()*6;
		in = new In[1];
		out = new Out[2];

		for(int i = 0;i<in.length;i++)
			in[i] = new In(this,i);


		for(int i = 0;i<out.length;i++)
			out[i] = new Out(this,i);
		
		sel = id;
	}

	void draw(){

		if(dragging){
			x = mouseX+tx;
			y = mouseY+ty;

		}

		boolean over = over();

		if(over)
			stroke(#ffcc00);
		else
			stroke(0);

		fill(255);
		rect(x,y,w,12);

		if(over())
			fill(#ffcc00);
		else
			fill(0);

		text(name,x+2,y+10);

		for(int i = 0;i<in.length;i++){
			in[i].draw();
		}

		for(int i = 0;i<out.length;i++){
			out[i].draw();
		}


	}
	
	void addText(char _ch){
		name+= _ch="";
	}

	void startDrag(){
		dragging = true;
	}

	void stopDrag(){
		dragging = false;
	}

	boolean over(){
		if(mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+12){
			sel = id;
			return true;
		}else{
			return false;
		}
	}
}




class In{
	Container parent;
	int id,pos;

	In(Container _parent,int _id){
		parent = _parent;
		id = _id;
		pos = (int)map(id,0,parent.in.length-1,0,parent.w-4);
	}

	void draw(){
		stroke(0);
		fill(0);
		rect(parent.x+pos,parent.y-2,4,2);
	}

	

}

class Out{
	Container parent;
	int id,pos;

	Out(Container _parent,int _id){
		parent = _parent;
		id = _id;
		pos = (int)map(id,0,parent.out.length-1,0,parent.w-4);
	}

	void draw(){
		if(over()){
			fill(#ffcc00);
			stroke(#ffcc00);

		}else{
			fill(0);
			stroke(0);

		}

		rect(parent.x+pos,parent.y+12,4,2);
	}

	boolean over(){
		if(mouseX>parent.x+pos-2&&
		                mouseX<parent.x+pos+6&&
		                mouseY>parent.y+10&&
		                mouseY<parent.y+16){
			return true;
		}else{
			return false;
		}
	}
}
