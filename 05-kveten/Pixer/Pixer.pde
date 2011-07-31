color [] cols = {#000000,#ffcc00,#ff0000,#ffffff};

Pix[] p;

void setup(){

	size(320,240,P2D);
	
	frameRate(25);

	p = new Pix[width*height];
	for(int y = 0; y<height;y++){
		for(int x = 0; x<width;x++){
			p[y*width+x] = new Pix(x,y);
		}
	}

	loadPixels();
}

void draw(){
	
	int id;
	for(int y = 0; y<height;y++){
		for(int x = 0; x<width;x++){
			id = y*width+x;
			p[id].draw();//
		}
	}


}


class Pix{
	int x,y;
	int state = 0;

	
	Pix(int _x,int _y){
		x = _x;
		y = _y;
		state = 0;
	}

	void draw(){
	
	
		  if(random(50)<49)   
		                  state += 1;
		                                  else
		pixels[y*width+x] = lerpColor(
		cols[state],
		pixels[y*width+((x+width-2)%width)],
		0.0
		);
		
		
		if(state > cols.length-1){
			state = 0;
		}
	}


}
