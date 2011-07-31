import codeanticode.gsvideo.*;

int W = 320;
int H = 240;

int cw = W ;
int ch = H;
int depth = 255;
byte tresh = 30;

FileWriter file;
int linesWritten = 0;
GSPipeline cam;

float sc = 2.0;

float[][] temp;

boolean writepos = false;

int mode = 0;

boolean created = false;

void setup() {

	size(W,H,P3D);
	frameRate(30);

	String webcam = "v4l2src ! queue2 ! ffvideoscale ! video/x-raw-rgb,width="+cw+",height="+ch+", bpp=32, depth=24";
	cam = new GSPipeline(this, webcam);


	temp =  new float[cw][ch];
	for(int y = 0;y<ch;y++){
		for(int x = 0;x<cw;x++){
			temp[x][y] = 0;
		}
	}



	//size(350, 200,"hipstersinc.P5Sunflow");
	//noLoop();
	noStroke();
	background(0);
}
void draw() {
	background(0);

	if(mode==0){
		grabData();
	}
	//saveFrame("out/fram####.png");
}

void renderData(){
	try{
		String path = "/home/kof/data/sketchBook/2010/03-brezen/dimmensionalRec/render/";//"./render";//sketchPath++(((int)(50*25*width*height)/256)*2);
		println(path);
		Runtime.getRuntime().exec("xterm -e cd render "+path+" && pp");
		println("rendering");
	}
	catch(java.io.IOException e){
		println(e);
	}

	exit();


}

void grabData(){

	if (cam.available() == true){
		cam.read();
		//cam.loadPixels();



		if(linesWritten>3000)
			writepos = false;

		if(writepos&&!created){

			try
			{
				file = new FileWriter("/home/kof/data/sketchBook/2010/03-brezen/dimmensionalRec/render/positions.dump"); //bool tells to append
				file.write(cw+","+ch+"\n");
				println("file updated");

				created = true;
			}
			catch(Exception e)
			{
				println("Error: Can't open file!");
			}
		}


		for(int y = 0;y<ch;y++){
			for(int x = 0;x<cw;x++){
				temp[x][y] += (brightness(cam.pixels[y*cw+x])-temp[x][y])/8.0;
				//fill(cam.pixels[y*cw+x]);
				//rect(x,y,1,1);
				if(writepos)
					try{
						file.write(temp[x][y]+",");
					}catch(IOException e){
						println("Error: Can't write into a file!");
					}
			}

		}

		if(writepos)
			try{
				file.write("\n");
				linesWritten++;


			}catch(IOException e){
				println("Error: Can't write into a file!");
			}

	}
	float ys = mouseY;

	noFill();
	//stroke(255,50);
	noStroke();

	pushMatrix();
	translate(width/2,height/2+20,-160);
	rotateX(PI/3);
	rotateZ(frameCount/100.0);



	float scl = 2;


	for (int x = 0; x < temp.length-1; x++){
		for (int y = 0; y < temp[x].length-1; y++){
			if(temp[x][y]>tresh){
				pushMatrix();
				beginShape(QUADS);
				translate(x*scl-cw,y*scl-ch,ys);
				// stroke(z[x][y]+127,220);
				stroke(temp[x][y]/sc);

				vertex(0,0,temp[x][y]/sc);
				// stroke(z[x+1][y]+127,220);
				stroke(temp[x][y]);

				vertex(scl,0,temp[x+1][y]/sc);
				// stroke(z[x+1][y+1]+127,220);
				stroke(temp[x][y]);

				vertex(scl,scl,temp[x+1][y+1]/sc);
				// stroke(z[x][y+1]+127,220);
				stroke(temp[x][y]);

				vertex(0,scl,temp[x][y+1]/sc);
				endShape();
				//line(0,scl,z[x][y+1],0,scl,0);
				popMatrix();
			}

		}
	}

	popMatrix();


}

void keyPressed(){

	if(key == 'r'){
		writepos = !writepos;
	}else if(key =='q'){
		renderData();
	}

}

void stop(){

	if(created){
		print("closing dump...");

		try{
			file.close();
			println("CLOSED!");
		}catch(IOException e){
			println("Error: Can't close a file!");
		}
	}

	super.stop();

}

class Surface{

	int scl;
	int w,h;
	int rows, cols;
	float zoff = 0.0;
	float[][] z;


}
