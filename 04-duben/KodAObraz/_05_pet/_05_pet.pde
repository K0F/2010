// Sktript Pet
// Obraz a kod 2010

// komplikovanejsi program
// doporucuji male zmeny systemem "pokus omyl"

/*
* [0][1][2]
* [3][x][4]
* [5][6][7]
*/


int[][] px;
int matrix[][][];
int mm[] = {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,6,7};
int mod[];

int runNum[];


void setup(){
	size(640,480,P2D);
	px = new int[width][height];
	matrix = new int[width][height][mm.length];
	runNum = new int[width*height];
	mod = new int[width*height];
	frameRate(50);

	loadPixels();
	for(int x = 0;x<width;x++){
		for(int y = 0;y<height;y++){
			runNum[y*width+x] = 0;
			mod[y*width+x] = 0;
			px[x][y] = color(0);

			for(int i = 2;i<mm.length-1;i+=3){
				matrix[x][y][i] = mm[i];
				matrix[x][y][i-1] = mm[i-1];
				matrix[x][y][i-2] = (int)random(8);
			}

			matrix[x][y] = (int[])expand(matrix[x][y],matrix[x][y].length+1);
			matrix[x][y][matrix[x][y].length-1] = (int)random(8);

			pixels[y*width+x] = px[x][y];
		}
	}
}

void draw(){

	for(int x = 0;x<width;x++){
		for(int y = 0;y<height;y++){
			int index = y*width+x;

			if(runNum[index]>=matrix[x][y].length-1){
				runNum[index] = 0;
			}

			if(index%2==0)
				mod[index]++;

			int shx = 0, shy = 0;

			int modded = (matrix[x][y][runNum[index]]+mod[index])%7;
			switch(modded){
			case 0:
				shx = -1;
				shy = -1;
				break;

			case 1:
				shx = 0;
				shy = -1;
				break;

			case 2:
				shx = 1;
				shy = -1;
				break;

			case 3:
				shx = -1;
				shy = 0;
				break;

			case 4:
				shx = 1;
				shy = 0;
				break;

			case 5:
				shx = -1;
				shy = 1;
				break;

			case 6:
				shx = 0;
				shy = 1;
				break;

			case 7:
				shx = 1;
				shy = 1;
				break;
			}


			if(x>width/2)
				px[x][y] = pixels[((y+height-shy+mod[index])%height)*width+((x+width+shx+mod[index])%width)];
			else
				px[x][y] = pixels[((y+height+shy+mod[index])%height)*width+((x+width-shx+mod[index])%width)];

			runNum[index]++;
		}
	}

	int r = (int)((sin(frameCount/30.0)+1)*20);
	int r2 = (int)((cos(frameCount/33.3333)+1)*20);

	for(int x = 0;x<width;x++){
		for(int y = 0;y<height;y++){
			int index = y*width+x;
			if(x>width/2-r&&x<width/2+r&&y<height/2+r&&y>height/2-r){
				pixels[index] = color(0);
			}else if(x>width/2-r2&&x<width/2+r2&&y<height/2+r2&&y>height/2-r2){
				pixels[index] = color(255);
			}else{
				pixels[index] = px[x][y];
			}

		}

	}
	//println(frameCount);
}
