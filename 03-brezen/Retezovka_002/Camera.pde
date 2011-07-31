PGraphics3D p3d;
PMatrix3D proj = new PMatrix3D();
PMatrix3D cam = new PMatrix3D();
PMatrix3D modvw = new PMatrix3D();
PMatrix3D modvwInv = new PMatrix3D();
PMatrix3D screen2Model = new PMatrix3D();


// rotation
float rotX, rotY;

// arrays hold the vertices of 3d object
float[] vertices3D = new float[0];
int[] vertices2D = new int[0];

// index of current mouseover / clicked vertex
int vertexMouseOver = -1;
int vertexKlicked= -1;

// z value in model/world space of current vertex
float zModelMouseOver;
float zModelKlick;

class Camera2{
                                           



	Camera2(){
		p3d = (PGraphics3D)g;	
rotX=PI;	
	}


	void preDraw(){

		pushMatrix();

		//apply mouse rotation and translation to center of screen
		translations();

		//get 3d matrices
		proj = p3d.projection.get();
		cam = p3d.camera.get();
		modvw = p3d.modelview.get();
		modvwInv = p3d.modelviewInv.get();
		
		screen2Model.mult(scrn, model);
		
		screen2Model = modvwInv;
		screen2Model.apply(cam);

	}


	void postDraw(){

		//visualize 3d axes for orientation
		//camer.drawAxes3D();

		//visualize vertices
		//camer.drawVertSphere();
		//	camer.drawVert();

		hitDetect();

		// 3d object space end
		popMatrix();

		drawHitDetect();
	}

	void translations() {
		translate(width/2, height/2);
		//mouse rotate
		rotateX(rotX);
		rotateZ(rotY);
	}

	void drawAxes3D() {
		stroke(255,0,0);
		line(0,0,0, 100,0,0);
		stroke(0,255,0);
		line(0,0,0, 0,-100,0);
		stroke(0,0,255);
		line(0,0,0, 0,0,100);
	}

	

	void hitDetect() {
		// mouse hit detection using screnX, screenY
		vertices2D = new int[0];
		vertexMouseOver = -1;

		for(int i=0; i<vertices3D.length; i=i+3) {
			int x = int(screenX(vertices3D[i], vertices3D[i+1], vertices3D[i+2]));
			int y = int(screenY(vertices3D[i], vertices3D[i+1], vertices3D[i+2]));

			vertices2D = append(vertices2D, x);
			vertices2D = append(vertices2D, y);

			if (x > mouseX-5 && x < mouseX+5 && y > mouseY-5 && y < mouseY+5) {
				vertexMouseOver = i;
			}
		}
	}

	void drawHitDetect() {
		if (vertexKlicked > -1) {
			stroke(255, 0, 0);
			noFill();
			ellipse(vertices2D[vertexKlicked/3*2], vertices2D[vertexKlicked/3*2+1], 30, 30);
		} else if (vertexMouseOver > -1) {
			stroke(100, 100, 100);
			noFill();
			ellipse(vertices2D[vertexMouseOver/3*2], vertices2D[vertexMouseOver/3*2+1], 20, 20);
		}
	}





}





