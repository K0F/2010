import codeanticode.gsvideo.*;

int W = 320;
int H = 240;
int depth = H;

GSPipeline cam;
Recorder r;

byte[][][] mem = new byte[depth][H][W];

boolean rec = true;

void setup(){


	size(W,H,P2D);
	frameRate(25);
	if(rec)
		r = new Recorder("out","slitScan2.mp4");
		//pipe = new GSPipeline(this, "v4l2src ! ffmpegcolorspace ! video/x-raw-yuv, width="+width+", height="+height+", bpp=32, depth=24 ! queue ! videorate ! video/x-raw-yuv, framerate=25/1 ! xvidenc ! queue ! avimux ! queue ! filesink location=/desk/test.avi");
	
	String webcam = "v4l2src ! queue2 ! ffvideoscale ! "+"video/x-raw-rgb,width="+W+",height="+H;
	cam = new GSPipeline(this, webcam);

	

	for(int i = 0;i<mem.length;i++){
		for(int ii = 0;ii<mem[i].length;ii++){
			for(int iii = 0;iii<mem[i][ii].length;iii++){
				mem[i][ii][iii] = 0;
			}
		}
	}

	background(0);
}

int qua = 0;

void draw(){

	if (cam.available() == true){
		cam.read();
		cam.loadPixels();


		for(int y = 0;y<height;y++){
			for(int i = 0;i<width;i++){
				mem[0][y][i] = byte(brightness(cam.pixels[y*W+i]));

			}
		}


		for(int pos = depth-1;pos>0;pos--){

			for(int y = 0;y<height;y++){
				for(int i = 0;i<width;i++){
					mem[pos][y][i] = mem[pos-1][y][i]; //(byte)(brightness(cam.pixels[y*W+i]));
				}
			}
		}

		loadPixels();

		/*
		for(int Y = 0;Y<H;Y++){
			for(int X = 0;X<W;X++){
				pixels[Y*W+X] = pixels[Y*W+X];
			}
	}
		*/

		for(int Y = 0;Y<H;Y++){
			for(int X = 0;X<W;X++){
				pixels[Y*W+X] = color(int(mem[H-Y-1][Y][X]));
			}
		}

	
	
	if(rec)
		r.add();

	}
}

void keyPressed() {
	if (key == 'q') {
		// Finish the movie if space bar is pressed
		if(rec)
			r.finish();  
		// Quit running the sketch once the file is written
		exit();
	}
}


