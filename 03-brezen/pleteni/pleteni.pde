
float[][] row = new float[2][160];

float mm = 3;
float mx = 4;
float xshift = 1000.0;
void setup(){
	size(800,600,P2D);
	background(255);
	reset();
	smooth();
}

void reset(){
	for(int i =0;i<row[0].length;i++){
		row[0][i] = map(i,0,row[0].length,0,width);
	}

	for(int i =0;i<row[1].length;i++){
		if(i%2==0){
			row[1][i] = height-(mm/2.0);
		}else{
			row[1][i] = height;
		}
	}
	//background(255);
}

void draw(){
	//background(255);

	for(int i =0;i<row[0].length;i++){
		row[0][i] += (random(-100,100)/xshift);//map(i,0,row[0].length,0,width);
	}

	boolean over = false;
	int cnt = 0;

	for(int i =0;i<row[1].length;i++){
		if(frameCount%2==0){
			if(i%2==0)
				row[1][i] -= random(mm,mx);
		}else{
			if((i+1)%2==0)
				row[1][i] -= random(mm,mx);
		}

		if(row[1][i]<0)
			cnt++;

		if(cnt>=row[1].length-1)
			over=true;
	}

	if(over){
		reset();
	}

	stroke(0,120);
	noFill();

	beginShape();
	for(int i=0;i<row[0].length;i++){
		vertex(row[0][i],row[1][i]);
	}
	endShape();
}
