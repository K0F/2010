Seeker s;

void setup(){

	size(320,240,P2D);
	background(0);

	loadPixels();
	stroke(255);
	s = new Seeker();
}


void draw(){

	s.seek();
	s.step();
	s.draw();


}

class Seeker{

	int x,y,nx,ny;
	boolean[] ng;

	Seeker(){
		x = (int)(random(width));
		y= (int)(random(height));
		point(x,(y+1+height)%height);
		ng = new boolean[16];
		seek();


	}

	void seek(){
		int cnt = 0;
		for(int Y = -2;Y<3;Y++){
			for(int X = -2;X<3;X++){

				if(X!=0&&Y!=0){
					if(brightness(pixels[((y+Y+height)%height)*width+((x+X+width)%width)])<127){
						ng[cnt] = true;
						cnt++;
					}else{
						ng[cnt] = false;
						cnt++;
					}
				}
			}
		}
	}

	int next(){

		int tmp[] = new int[0];

		for(int i = 0;i<ng.length;i++){
			if(ng[i])
				tmp = (int[])append(tmp,i);
		}



		int choice = (int)random(tmp.length);
		//print(tmp[choice]);

		try{
			return tmp[choice];
		}catch(java.lang.NullPointerException e){
			reborn();
		}

		return -1;


	}

	void reborn(){

		int count = 0;
		while(brightness(pixels[y*width+x])>127||count>1000){
			x = (int)random(width);
			y = (int)random(height);
			seek();
			count++;
		}

	}

	void step(){
		int q = next();

		int cnt = 0;
		for(int Y = -2;Y<3;Y++){
			for(int X = -2;X<3;X++){

				if(X!=0&&Y!=0){

					if(cnt==q){
						x+=X;
						y+=Y;
					}
					cnt++;
				}
			}
		}


	}

	void draw(){

		point(x,y);

	}

}
