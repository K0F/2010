import codeanticode.gsvideo.*;

int W = 1600;
int H = 720;

int cw = 200 ;
int ch = 720;
int depth = 255;

GSPipeline cam;
Recorder r;

//byte[][][] mem = new byte[depth][H][W];
byte tresh = 30;

boolean rec = false;
boolean printout = false;

void setup(){
	size(W,H,P2D);
	frameRate(30);
	if(rec)
		r = new Recorder("out","slitScan2.mp4");
	//pipe = new GSPipeline(this, "v4l2src ! ffmpegcolorspace ! video/x-raw-yuv, width="+width+", height="+height+", bpp=32, depth=24 ! queue ! videorate ! video/x-raw-yuv, framerate=25/1 ! xvidenc ! queue ! avimux ! queue ! filesink location=/desk/test.avi");

	String webcam = "v4l2src ! queue2 ! ffvideoscale ! "+"video/x-raw-rgb,width="+cw+",height="+ch+", bpp=32, depth=24";
	cam = new GSPipeline(this, webcam);

	/*

		for(int i = 0;i<mem.length;i++){
			for(int ii = 0;ii<mem[i].length;ii++){
				for(int iii = 0;iii<mem[i][ii].length;iii++){
					mem[i][ii][iii] = 0;
				}
			}
		}
		
		*/
	background(0);
}


class Saver implements Runnable {
	// This method is called when the thread runs
	public void run() {
		save("strip"+nf(no,4)+".png");
	}
}

int qua = 0;
int cntr = 0;
int no =0;

void draw(){
	if (cam.available() == true){
		cam.read();
		cam.loadPixels();

		cntr++;

		if(cntr%W==0){

			// Create the object with the run() method
			Saver saver = new Saver();

			// Create the thread supplying it with the runnable object
			Thread thread = new Thread(saver);

			// Start the thread
			thread.start();
			no++;
		}


		/*
		for(int y = 0;y<height;y++){
			for(int i = 0;i<width;i++){
				mem[0][y][i] = byte(brightness(cam.pixels[y*W+i]));
			}
	}
		*/
		loadPixels();

		int x = cw/2;
		for(int y = 0;y<height;y++){
			pixels[y*width+width-2] = color(brightness(cam.pixels[y*cw+x]));
			if(printout){
				if(y%2==0){
					if(brightness(cam.pixels[y*cw+x])>15)
						print(1);
					else
						print(0);
				}
			}
		}
		if(printout)
		println("");


		/*
		for(int pos = depth-1;pos>0;pos--){

			for(int y = 0;y<height;y++){
				for(int i = 0;i<width;i++){
					//if(abs(mem[pos][y][i]-mem[pos-1][y][i])>tresh)
					mem[pos][y][i] = mem[pos-1][y][i]; //(byte)(brightness(cam.pixels[y*W+i]));
				}
			}
	}

		*/



		/*
		for(int Y = 0;Y<H;Y++){
			for(int X = 0;X<W;X++){
				pixels[Y*W+X] = pixels[Y*W+X];
			}
	}
		*/


		for(int X = 0;X<width-1;X++){
			for(int Y = 0;Y<H;Y++){
				pixels[Y*W+X] = pixels[Y*W+(X+1)];//color(int(mem[0][Y][X]));
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
