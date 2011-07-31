
boolean rightDown, leftDown, middleDown;
float px = 0;
float px2 = 0;
float scrn[] = {0, 0, 0};
float model[] = new float[3];

/*
void mousePressed(){

	if(mouseButton==LEFT){
		leftDown = true;
		retez.add(new Point(mouseX,mouseY,0));
		
	}else if(mouseButton == RIGHT){
		rightDown = true;
		//px=mouseX;
	}else{
		middleDown = true;
	}
	//println(frameCount+" L:"+leftDown+" R:"+rightDown+" M:"+middleDown);

}*/

void mousePressed(){
	if (mouseButton==LEFT )
	{





		// apply transformation matrices to mouse coords
		scrn[0] = mouseX;
		scrn[1] = mouseY;
		scrn[2] = 0;

		model = new float[3];
		
		screen2Model.mult(scrn, model);
		screen2Model = modvwInv;
		screen2Model.apply(cam);




		retez.add(new Point(model[0],model[1],model[2]));
		/*
		vertexKlicked = vertexMouseOver;
		zModelKlick = zModelMouseOver;

		// calculate transformation matrix for projecting mouse coords
		// to the plane where the current selected vertex is
		// this doesn't work!
		screen2Model = modvwInv;
		screen2Model.apply(cam);
		*/



		//screen2Model.apply(proj);
		//screen2Model.translate(0, 0, zModelKlick);
	}
}

void mouseReleased(){
	vertexKlicked = -1;
}

void mouseDragged() {
	if (mouseButton==LEFT && vertexKlicked>-1) {


		//vertices3D[vertexKlicked] = model[0];
		//vertices3D[vertexKlicked+1] = model[1];
		//vertices3D[vertexKlicked+2] = model[2];
	}
	else {
		// mouse controlled rotation
		float x1 = mouseX-pmouseX;
		float y1 = mouseY-pmouseY;
		rotX += -y1 * 0.01;
		rotY += x1 * 0.01;
	}
}

/*

void mouseReleased(){

	if(mouseButton==LEFT){
		leftDown = false;
		
		

	}else if(mouseButton == RIGHT){

		rightDown = false;
		px2+=mouseX-width/2.0+px;
	}else{
		middleDown = false;
	}
	//println(frameCount+" L:"+leftDown+" R:"+rightDown+" M:"+middleDown);

}


*/
