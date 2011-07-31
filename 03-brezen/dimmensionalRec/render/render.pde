import hipstersinc.sunflow.*;
import hipstersinc.sunflow.shader.*;
import hipstersinc.*;

String[] rawData;
String fileName;
float z[];
BufferedReader file;

int W,H;
float tresh = 30.0;

int startFrame = 0;
int currentFrame = startFrame;

boolean oneShot = false;
boolean preview = false;

void setup(){

	fileName = sketchPath("positions.dump") ;

	try{
		file = new BufferedReader (new FileReader (fileName)) ;
		String dimm = file.readLine();
		println(dimm);
		String dimm2[] = splitTokens(dimm,",");
		W = parseInt(dimm2[0]);
		H = parseInt(dimm2[1]);

		println("skipping on frameno "+startFrame);

		for(int i = 0;i<=startFrame;i++){
			String trash = file.readLine();
		}

	}catch (Exception e){
		println ("Error" + e) ;
	}

	if(!preview){
		size(W, H,"hipstersinc.P5Sunflow"); //,"hipstersinc.P5Sunflow"
		if(oneShot)
		noLoop();
	}else{

		size(W, H, P3D);
	}

	noStroke();
	fill(255);
}

void setupCamera() {
	P5Sunflow sunflow = (P5Sunflow) g;
	sunflow.camera.setType(SunflowCamera.THINLENS);
	sunflow.camera.setFocalDistance(450);
	sunflow.camera.setLensRadius(12f);

	// Now we set the Anti-Aliasing sampling.
	sunflow.scene.setAaSamples(12);

}


void draw(){
	if(preview){
		background(0);
	}else{
		background(230);
		//setupCamera();

	}

	try{
		String raw = file.readLine();
		String temp[] = splitTokens(raw,",");

		z = new float[temp.length];
		for(int i = 0;i<z.length;i++){
			z[i] = parseFloat(temp[i]);
		}

	}catch (Exception e){
		println ("Error " + e + " @frame: "+frameCount);

		exit();
	}



	float scl = 2;
	float sc = 2.0;
	float ys = 20.0;

	if(z!=null){

		//pushMatrix();
		translate(width/2,height/2+20,-160);
		rotateX(PI/3);
		//rotateZ(width/2.0/100.0);

		if(preview){
			noStroke();
			for (int x = 0; x < W-1; x++){
				for (int y = 0; y < H-1; y++){
					if(z[y*W+x]>tresh){
						fill(z[y*W+x]);
						beginShape(QUADS);
						//	translate(x*scl-W,y*scl-H,ys);
						// stroke(z[x][y]+127,220);


						vertex(x*scl-W,y*scl-H,ys+z[y*W+x]/sc);
						// stroke(z[x+1][y]+127,220);
						//fill(255,1);

						vertex(scl+x*scl-W,y*scl-H,ys+z[y*W+x+1]/sc);
						// stroke(z[x+1][y+1]+127,220);
						//stroke(255,1);

						vertex(scl+x*scl-W,scl+y*scl-H,ys+z[(y+1)*W+x+1]/sc);
						// stroke(z[x][y+1]+127,220);
						//stroke(255,1);

						vertex(x*scl-W,scl+y*scl-H,ys+z[(y+1)*W+x]/sc);
						endShape();
						//line(0,scl,z[x][y+1],0,scl,0);

					}

				}
			}

		}else{

			fill(255);
			noStroke();

			for (int x = 0; x < W-1; x++){
				for (int y = 0; y < H-1; y++){
					if(z[y*W+x]>tresh){

						beginShape(QUADS);
						//	translate(x*scl-W,y*scl-H,ys);
						// stroke(z[x][y]+127,220);
						//stroke(z[x][y]/sc);

						vertex(x*scl-W,y*scl-H,ys+z[y*W+x]/sc);
						// stroke(z[x+1][y]+127,220);
						//stroke(z[x][y]);

						vertex(scl+x*scl-W,y*scl-H,ys+z[y*W+x+1]/sc);
						// stroke(z[x+1][y+1]+127,220);
						//stroke(z[x][y]);

						vertex(scl+x*scl-W,scl+y*scl-H,ys+z[(y+1)*W+x+1]/sc);
						// stroke(z[x][y+1]+127,220);
						//stroke(z[x][y]);

						vertex(x*scl-W,scl+y*scl-H,ys+z[(y+1)*W+x]/sc);
						endShape();
						//line(0,scl,z[x][y+1],0,scl,0);

					}

				}
			}
		}
		
		fill(230);
		beginShape(QUADS);
		vertex(-W*2,-H*2,0);
		vertex(W*2,-H*2,0);
		vertex(W*2,H*2,0);
		vertex(-W*2,H*2,0);
		endShape();

		//popMatrix();

	}

	if(!preview){
		saveFrame("out/render"+nf(currentFrame,4)+".png");
		currentFrame++;

	}
}
