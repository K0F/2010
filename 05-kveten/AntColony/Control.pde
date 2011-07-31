
boolean rightDown, leftDown, middleDown;
boolean shiftDown, ctrlDown = false;
boolean drag = false;


void mousePressed()
{
	if (mouseButton==LEFT)
	{
		leftDown = true;
		tool.Calculate();
	}

}

//mys odkliknuta
void mouseReleased()
{



	if (mouseButton==RIGHT)
	{
		rightDown = true;
		tool.Calculate();
	}


	leftDown = rightDown = middleDown = false;
	drag = false;
}


//mys tazena
void mouseDragged()
{
	rightDown = false;
	drag = true;

	if (mouseButton==RIGHT && !shiftDown)
	{
		// mouse controlled rotation
		float x1 = mouseX-pmouseX;
		float y1 = mouseY-pmouseY;

		//add to global rotation
		rotX += -y1 * 0.01;
		rotY += x1 * 0.01;
	}

	if (mouseButton==RIGHT && shiftDown)
	{
		float x1 = mouseX-pmouseX;
		float y1 = mouseY-pmouseY;

		panY += y1*2;
		panX += x1*2;
	}
}

void keyPressed()
{
	if (keyCode == ENTER)
	{

	}

	else if(keyCode == DELETE)
	{
		for(int i = 0; i < area.length; i++)
		{
			if(! area[i].isSelected)
			{
				area[i].Kill();
			}
		}
	}
	else if(keyCode == UP)
	{

	}
	else if(keyCode == DOWN)
	{

	}
	else if( key == 32) // SPACE
	{
		if(speed == 1) speed = 3;
		else if(speed == 3) speed = 10;
		else if(speed == 10) speed = 1;
	}
	else if( keyCode == CONTROL)
	{
		ctrlDown = true;
	}
	else if( keyCode == SHIFT)
	{
		shiftDown = true;
	}
	else if(key == 'S' || key == 's')
	{
		cam.SaveScreen();
	}
	else if(key == 'r'){
		rec = !rec;
		println("exporting pdf..");

	}


}


//klavesa odkliknuta
void keyReleased()
{
	shiftDown = false;
}

































