import saito.objloader.*;
int index;

OBJModel model;

float rotX;
float rotY;

PVector verts[];
int len;

void setup()
{
	size(600, 600, OPENGL);


	frameRate(30);
	//smooth();
	hint(ENABLE_OPENGL_4X_SMOOTH);
	model = new OBJModel(this);
	model.load("model.obj");
	model.drawMode(TRIANGLES);
	 len = model.getVertexsize(); 
	model.enableTexture();
	
	verts = new PVector[len];
	

	for(int i = 0;i<len;i++){
		verts[i] = model.getVertex(i); 
		 
	}
	
}

void draw()
{
	background(0);
	//stroke(255,80);
	noStroke();


	
	
	//lights();
	//directionalLight(200, 200, 200, -1, 0, 0);
	ambientLight(122, 0,0);


	pushMatrix();
	
	
	translate(width/2, height/2, 0);
	rotateX(rotY);
	rotateY(rotX);
	scale(100.0);

	//model.draw();
	
	
	for(int i = 0;i<len-4;i+=1){
	beginShape(TRIANGLES);
	
		vertex(verts[i].x,verts[i].y,verts[i].z);
		vertex(verts[i+1].x,verts[i+1].y,verts[i+1].z);
		vertex(verts[i+2].x,verts[i+2].y,verts[i+2].z);
	//	vertex(verts[i+1].x,verts[i+1].y,verts[i+1].z);
		
	
	endShape();
	}
	
	popMatrix();
}

void keyPressed()
{
	if(key == 'a')
		model.enableTexture();

	else if(key=='b')
		model.disableTexture();
}
void mouseDragged()
{
	rotX += (mouseX - pmouseX) * 0.01;
	rotY -= (mouseY - pmouseY) * 0.01;
}
