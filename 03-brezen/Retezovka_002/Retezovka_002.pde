import processing.opengl.*;



Camera2 camer;
Retez retez;
Plane pln;



void setup()
{
	size(800,600,P3D);
//	hint(DISABLE_OPENGL_2X_SMOOTH);
noSmooth();

	retez = new Retez();
	camer = new Camera2();
	pln = new Plane(new Point(0,0,0),new Vector(1,0,0),new Vector(1,1,0));
	pln.displaySize = 200;

}

void draw()
{
	background(0);

	camer.preDraw();
	
	
	
	
	noFill();
	stroke(255);
	box(200);
	
	retez.Draw();
	pln.Draw();
	
	pushMatrix();
	translate(100,100,-100);
stroke(255,20,20);
	box(5);
	popMatrix();
	
	camer.postDraw();


	

	// calculate z value of picked vertex in model(world) space
	if (vertexMouseOver > -1) {
		zModelMouseOver = modelZ(vertices3D[vertexMouseOver], vertices3D[vertexMouseOver+1], vertices3D[vertexMouseOver+2]);
	}

}













