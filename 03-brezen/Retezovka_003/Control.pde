
boolean rightDown, leftDown, middleDown,once;
float px = 0;
float px2 = 0;
float scrn[] = {0, 0, 0};
float model[] = new float[3];

void mousePressed()
{
	if (mouseButton==LEFT )
	{

		once = true;
		leftDown = true;

		// apply transformation matrices to mouse coords
		scrn[0] = mouseX;
		scrn[1] = mouseY;
		scrn[2] = 0;

		model = new float[3];

		//pro jistotu provede transformace
		camer.applyMatrices();

		pridejRetez();
		

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

//mys odkliknuta
void mouseReleased()
{
	leftDown = rightDown = middleDown = false;
}

//mys tazena
void mouseDragged()
{
	if (mouseButton==RIGHT)
	{
		// mouse controlled rotation
		float x1 = mouseX-pmouseX;
		float y1 = mouseY-pmouseY;

		//add to global rotation
		rotX += -y1 * 0.01;
		rotY += x1 * 0.01;
	}
}

void keyPressed()
{
	// obrati gravitaci
	if (keyCode == ENTER)
	{
		gravity *= -1;//gravity;
	}
	// smaze body
	else if(keyCode == DELETE)
	{
		initRetez();
	}


}

